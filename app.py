# app.py
from flask import Flask, request, jsonify, Response
from indicators.ma_indicator import calculate_moving_averages
from indicators.adx_indicator import calculate_adx
from data_downloader import download_and_store_historical_data, update_current_data, initialize_database
import logging
from werkzeug.exceptions import HTTPException
from apscheduler.schedulers.background import BackgroundScheduler

app = Flask(__name__)


# Config the logging system to write to a file
logging.basicConfig(filename='error.log', level=logging.ERROR)

# Middleware for logging
@app.after_request
def after_request(response):
    if response.status_code >= 400:
        logging.error('%s %s %s %s', request.remote_addr, request.method, request.url, response.status)
    return response

# Handle exceptions
@app.errorhandler(Exception)
def handle_exception(error):
    code = 500
    if isinstance(error, HTTPException):
        code = error.code
    return jsonify(error=str(error)), code

# Initialize the database when the application starts
initialize_database()

# Initialize the scheduler
scheduler = BackgroundScheduler()
scheduler.start()

# Execute the download of historical data once at the beginning
download_and_store_historical_data()

# Programa the execution of the update data function every hour
scheduler.add_job(update_current_data, 'interval', hours=1)


@app.route('/companies/<symbol>/indicators/moving_averages', methods=['POST'])
def calculate_moving_averages_for_company(symbol):
    data = request.get_json()
    moving_average_type = data.get('moving_average_type')
    periods = [int(period) for period in data.get('periods', [])]
    moving_averages_data = calculate_moving_averages(symbol, moving_average_type, periods)
    if 'error' in moving_averages_data:
        return jsonify(moving_averages_data), 404
    return jsonify(moving_averages_data)

@app.route('/companies/<symbol>/indicators/adx', methods=['POST'])
def calculate_adx_for_company(symbol):
    adx_data = calculate_adx(symbol)
    if adx_data is None:
        return jsonify({'error': 'No ADX data found for the symbol'}), 404
    return jsonify(adx_data)

if __name__ == '__main__':
    app.run(debug=True)