# app.py
from flask import Flask, request, jsonify, Response
from indicators.ma_indicator import calculate_moving_averages
from indicators.adx_indicator import calculate_adx

app = Flask(__name__)

@app.route('/companies/<symbol>/indicators/moving_averages', methods=['POST'])
def calculate_moving_averages_for_company(symbol):
    data = request.get_json()
    moving_average_type = data.get('moving_average_type')
    periods = [int(period) for period in data.get('periods', [])]
    result = calculate_moving_averages(symbol, moving_average_type, periods)
    if 'error' in result:
        return jsonify(result), 404
    return jsonify(result), 200

@app.route('/companies/<symbol>/indicators/adx', methods=['POST'])
def calculate_adx_for_company(symbol):
    result = calculate_adx(symbol)
    if 'error' in result:
        return jsonify(result), 404
    return jsonify(result), 200

if __name__ == '__main__':
    app.run(debug=True)

