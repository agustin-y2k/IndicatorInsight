# app.py
from flask import Flask, request, jsonify, Response
from indicators.ma_indicator import calculate_moving_averages
from indicators.adx_indicator import calculate_adx
from indicators.rsi_indicator import calculate_rsi
from indicators.macd_indicator import calculate_macd
from indicators.stochastic_indicator import calculate_stochastic
from indicators.willims_r_indicator import calculate_williams_r
from indicators.bollinger_bands_indicator import calculate_bollinger_bands
from indicators.aroon_indicator import calculate_aroon
from indicators.parabolic_sar_indicator import calculate_parabolic_sar
from indicators.cci_indicator import calculate_cci
from data_downloader import download_and_store_historical_data, update_current_data, initialize_database
import logging
from werkzeug.exceptions import HTTPException
from apscheduler.schedulers.background import BackgroundScheduler
from prometheus_client import Counter, generate_latest, Histogram
from flask_cors import CORS
import sys

app = Flask(__name__)
CORS(app)


# Config the logging  system to write to stderr
logging.basicConfig(stream=sys.stderr, level=logging.ERROR)

# Define Prometheus metrics
REQUEST_COUNT = Counter('http_requests_total', 'Total HTTP Requests')
REQUEST_LATENCY = Histogram('http_request_latency_seconds', 'HTTP Request Latency')


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

# Index endpoint
@app.route('/')
@REQUEST_LATENCY.time()
def index():
    REQUEST_COUNT.inc()
    return jsonify({'message': 'Welcome to Indicator Insight!'})

# Metrics endpoint for Prometheus
@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype='text/plain')

# Before shutting down the server
def cleanup():
    # Close database connections or perform other cleanup tasks here
    logging.info('Closing database connections...')

@app.before_shutdown
def cleanup_before_shutdown():
    cleanup()

@app.route('/companies/<symbol>/indicators/moving_averages', methods=['POST'])
def calculate_moving_averages_for_company(symbol):
    try:
        data = request.get_json()
        moving_average_type = data.get('moving_average_type')
        periods = [int(period) for period in data.get('periods', [])]
        moving_averages_data = calculate_moving_averages(symbol, moving_average_type, periods)
        return jsonify(moving_averages_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/adx', methods=['POST'])
def calculate_adx_for_company(symbol):
    try:
        adx_data = calculate_adx(symbol)
        return jsonify(adx_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/rsi', methods=['POST'])
def calculate_rsi_for_company(symbol):
    try:
        data = request.get_json()
        period = data.get('period', 14)  # Period is optional, default is 14
        rsi_data = calculate_rsi(symbol, period)
        return jsonify(rsi_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/macd', methods=['POST'])
def calculate_macd_for_company(symbol):
    try:
        macd_data = calculate_macd(symbol)
        return jsonify(macd_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/stochastic', methods=['POST'])
def calculate_stochastic_for_company(symbol):
    try:
        stochastic_data = calculate_stochastic(symbol)
        return jsonify(stochastic_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/williams_r', methods=['POST'])
def calculate_williams_r_for_company(symbol):
    try:
        data = request.get_json()
        period = data.get('period', 14)  # The period is optional, the default is 14
        williams_r_data = calculate_williams_r(symbol, period)
        return jsonify(williams_r_data)
    except Exception as e:
        raise HTTPException(description=str(e))
    
@app.route('/companies/<symbol>/indicators/bollinger_bands', methods=['POST'])
def calculate_bollinger_bands_for_company(symbol):
    try:
        data = request.get_json()
        period = data.get('period', 20)  # The period is optional, the default is 20
        deviation = data.get('deviation', 2)  # The deviation is optional, the default is 2
        bollinger_bands_data = calculate_bollinger_bands(symbol, period, deviation)
        return jsonify(bollinger_bands_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/aroon', methods=['POST'])
def calculate_aroon_for_company(symbol):
    try:
        data = request.get_json()
        period = data.get('period', 14)  # Period is optional, default is 14
        aroon_data = calculate_aroon(symbol, period)
        return jsonify(aroon_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/parabolic_sar', methods=['POST'])
def calculate_parabolic_sar_for_company(symbol):
    try:
        parabolic_sar_data = calculate_parabolic_sar(symbol)
        return jsonify(parabolic_sar_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/cci', methods=['POST'])
def calculate_cci_for_company(symbol):
    try:
        cci_data = calculate_cci(symbol)
        return jsonify(cci_data)
    except Exception as e:
        raise HTTPException(description=str(e))

if __name__ == '__main__':
    app.run(host='0.0.0.0')