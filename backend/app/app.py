# app.py
from flask import Flask, request, jsonify, Response
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from utils.indicators.ma_indicator import calculate_moving_averages
from utils.indicators.adx_indicator import calculate_adx
from utils.indicators.rsi_indicator import calculate_rsi
from utils.indicators.macd_indicator import calculate_macd
from utils.indicators.stochastic_indicator import calculate_stochastic
from utils.indicators.willims_r_indicator import calculate_williams_r
from utils.indicators.bollinger_bands_indicator import calculate_bollinger_bands
from utils.indicators.aroon_indicator import calculate_aroon
from utils.indicators.parabolic_sar_indicator import calculate_parabolic_sar
from utils.indicators.cci_indicator import calculate_cci
from utils.data_downloader import download_and_store_historical_data, update_current_data, initialize_database
import logging
from werkzeug.exceptions import HTTPException
from apscheduler.schedulers.background import BackgroundScheduler
from prometheus_client import Counter, generate_latest, Histogram
from flask_cors import CORS
import sys

app = Flask(__name__)
CORS(app)

# Configurar el limitador
limiter = Limiter(
    app,
    key_func=get_remote_address,
    default_limits=["10000 per day", "1000 per hour", "100 per minute"]
)

# Configurar el sistema de registro para escribir en stderr
logging.basicConfig(stream=sys.stderr, level=logging.WARNING)

# Definir métricas de Prometheus
REQUEST_COUNT = Counter('http_requests_total', 'Total HTTP Requests')
REQUEST_LATENCY = Histogram('http_request_latency_seconds', 'HTTP Request Latency')

# Middleware para el registro
@app.after_request
def after_request(response):
    if response.status_code >= 400:
        logging.error('%s %s %s %s', request.remote_addr, request.method, request.url, response.status)
    return response

# Manejar excepciones HTTP
@app.errorhandler(HTTPException)
def handle_http_exception(error):
    return jsonify(error=str(error), message="An error occurred"), error.code

# Manejar excepciones generales
@app.errorhandler(Exception)
def handle_exception(error):
    app.logger.exception("Unhandled Exception: %s", error)
    return jsonify(error="An internal server error occurred"), 500

# Inicializar la base de datos al iniciar la aplicación
initialize_database()

# Inicializar el programador de tareas en segundo plano
scheduler = BackgroundScheduler()
scheduler.start()

# Ejecutar la descarga de datos históricos una vez al inicio
download_and_store_historical_data()

# Programar la ejecución de la función de actualización de datos cada hora
scheduler.add_job(update_current_data, 'interval', hours=1)

# Punto de entrada de la API
@app.route('/')
@REQUEST_LATENCY.time()
def index():
    REQUEST_COUNT.inc()
    return jsonify({'message': 'Welcome to Indicator Insight!'})

# Endpoint para métricas de Prometheus
@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype='text/plain')

@app.route('/companies/<symbol>/indicators/moving_averages', methods=['POST'])
def calculate_moving_averages_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_ma = request.get_json()
        moving_average_type = data_input_ma.get('moving_average_type')
        periods = [int(period) for period in data_input_ma.get('periods', [])]
        moving_averages_data = calculate_moving_averages(symbol, moving_average_type, periods)

        return jsonify(moving_averages_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/adx', methods=['POST'])
def calculate_adx_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_adx= calculate_adx(symbol)
        return jsonify(data_input_adx)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/rsi', methods=['POST'])
def calculate_rsi_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_rsi = request.get_json()
        period = data_input_rsi.get('period', 14)  # Period is optional, default is 14
        rsi_data = calculate_rsi(symbol, period)
        return jsonify(rsi_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/macd', methods=['POST'])
def calculate_macd_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_macd = request.get_json()
        fast_period = data_input_macd.get('fast_period', 12)  # Default fast period is 12
        slow_period = data_input_macd.get('slow_period', 26)  # Default slow period is 26
        signal_period = data_input_macd.get('signal_period', 9)  # Default signal period is 9
        macd_data = calculate_macd(symbol, fast_period, slow_period, signal_period)
        return jsonify(macd_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/stochastic', methods=['POST'])
def calculate_stochastic_for_company(symbol):
    try:
        symbol = symbol.upper()
        data = request.get_json()
        fastk_period = data.get('fastk_period', 14)  # The fastk_period is optional, the default is 14
        slowk_period = data.get('slowk_period', 3)  # The slowk_period is optional, the default is 3
        slowd_period = data.get('slowd_period', 3)  # The slowd_period is optional, the default is 3
        slowk_matype = data.get('slowk_matype', 0)  # The slowk_matype is optional, the default is 0
        slowd_matype = data.get('slowd_matype', 0)  # The slowd_matype is optional, the default is 0
        stochastic_data = calculate_stochastic(symbol, fastk_period, slowk_period, slowd_period, slowk_matype, slowd_matype)
        return jsonify(stochastic_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/williams_r', methods=['POST'])
def calculate_williams_r_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_williams_r = request.get_json()
        period = data_input_williams_r.get('period', 14)  # The period is optional, the default is 14
        williams_r_data = calculate_williams_r(symbol, period)
        return jsonify(williams_r_data)
    except Exception as e:
        raise HTTPException(description=str(e))
    
@app.route('/companies/<symbol>/indicators/bollinger_bands', methods=['POST'])
def calculate_bollinger_bands_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_bollinger_bands = request.get_json()
        period = data_input_bollinger_bands.get('period', 20)  # The period is optional, the default is 20
        deviation = data_input_bollinger_bands.get('deviation', 2)  # The deviation is optional, the default is 2
        bollinger_bands_data = calculate_bollinger_bands(symbol, period, deviation)
        return jsonify(bollinger_bands_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/aroon', methods=['POST'])
def calculate_aroon_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_aroon = request.get_json()
        period = data_input_aroon.get('period', 14)  # Period is optional, default is 14
        aroon_data = calculate_aroon(symbol, period)
        return jsonify(aroon_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/parabolic_sar', methods=['POST'])
def calculate_parabolic_sar_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_input_parabolic_sar = request.get_json()
        acceleration = data_input_parabolic_sar.get('acceleration', 0.02)  # Acceleration is optional, default is 0.02
        maximum = data_input_parabolic_sar.get('maximum', 0.2)  # Maximum is optional, default is 0.2
        parabolic_sar_data = calculate_parabolic_sar(symbol, acceleration, maximum)
        return jsonify(parabolic_sar_data)
    except Exception as e:
        raise HTTPException(description=str(e))

@app.route('/companies/<symbol>/indicators/cci', methods=['POST'])
def calculate_cci_for_company(symbol):
    try:
        symbol = symbol.upper()
        data_cci = calculate_cci(symbol)
        return jsonify(data_cci)
    except Exception as e:
        raise HTTPException(description=str(e))

if __name__ == '__main__':
    app.run(host='0.0.0.0')