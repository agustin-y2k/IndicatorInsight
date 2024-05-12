from fastapi import FastAPI, HTTPException, Request, Response, Body
from fastapi.responses import JSONResponse, ORJSONResponse
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.openapi.docs import get_swagger_ui_html
from fastapi.openapi.utils import get_openapi
from typing import List
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
from prometheus_client import Counter, generate_latest, Histogram

app = FastAPI(
    title="Indicator Insight API",
    description="API for calculating financial indicators.",
    version="1.0.0"
)

# Configure logging to write to stderr
logging.basicConfig(level=logging.ERROR)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configure GZipMiddleware
app.add_middleware(GZipMiddleware, minimum_size=1000)

# Define Prometheus metrics
REQUEST_COUNT = Counter('http_requests_total', 'Total HTTP Requests')
REQUEST_LATENCY = Histogram('http_request_latency_seconds', 'HTTP Request Latency')

# Middleware for logging
@app.middleware("http")
async def log_requests(request: Request, call_next):
    response = await call_next(request)
    REQUEST_COUNT.inc()
    if response.status_code >= 400:
        logging.error('%s %s %s %s', request.client.host, request.method, request.url.path, response.status_code)
    return response

# Handle HTTP exceptions
@app.exception_handler(HTTPException)
async def http_exception_handler(request, exc):
    return JSONResponse(status_code=exc.status_code, content={"error": str(exc), "message": "An error occurred"})

# Handle general exceptions
@app.exception_handler(Exception)
async def generic_exception_handler(request, exc):
    logging.exception("Unhandled Exception: %s", exc)
    return JSONResponse(status_code=500, content={"error": "An internal server error occurred"})

# Initialize the database when starting the application
initialize_database()

# Run historical data download once at startup
download_and_store_historical_data()

# Schedule data update function to run every hour
update_current_data()

# API entry point
@app.get("/")
async def index():
    return {"message": "Welcome to Indicator Insight!"}

# Endpoint for Prometheus metrics
@app.get("/metrics")
async def metrics():
    return Response(content=generate_latest(), media_type="text/plain")

# Endpoint for Swagger UI documentation
@app.get("/docs", include_in_schema=False)
async def custom_swagger_ui_html():
    return get_swagger_ui_html(openapi_url="/openapi.json", title="API Docs")

# Endpoint for OpenAPI JSON specification
@app.get("/openapi.json", include_in_schema=False)
async def get_openapi_json():
    return JSONResponse(get_openapi(title="API Docs", version="1.0.0", routes=app.routes))

# Define endpoint for calculating moving averages for a company
@app.post("/companies/{symbol}/indicators/moving_averages")
async def calculate_moving_averages_for_company(symbol: str, moving_average_input: dict = Body(...)):
    try:
        symbol = symbol.upper()
        moving_average_type = moving_average_input.get("moving_average_type")
        periods = moving_average_input.get("periods", [])
        if not moving_average_type:
            raise ValueError("Moving average type is required in the request body")
        moving_averages_data = calculate_moving_averages(symbol, moving_average_type, periods)
        return moving_averages_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating ADX for a company
@app.post("/companies/{symbol}/indicators/adx")
async def calculate_adx_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        adx_data = calculate_adx(symbol)
        return adx_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating RSI for a company
@app.post("/companies/{symbol}/indicators/rsi")
async def calculate_rsi_for_company(symbol: str, data_input_rsi: dict = Body(...)):
    try:
        symbol = symbol.upper()
        period = data_input_rsi.get('period', 14)
        rsi_data = calculate_rsi(symbol, period)
        return rsi_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating MACD for a company
@app.post("/companies/{symbol}/indicators/macd")
async def calculate_macd_for_company(symbol: str, data_input_macd: dict = Body(...)):
    try:
        symbol = symbol.upper()
        fast_period = data_input_macd.get('fast_period', 12)
        slow_period = data_input_macd.get('slow_period', 26)
        signal_period = data_input_macd.get('signal_period', 9)
        macd_data = calculate_macd(symbol, fast_period, slow_period, signal_period)
        return macd_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating stochastic for a company
@app.post("/companies/{symbol}/indicators/stochastic")
async def calculate_stochastic_for_company(symbol: str, data: dict = Body(...)):
    try:
        symbol = symbol.upper()
        fastk_period = data.get('fastk_period', 14)
        slowk_period = data.get('slowk_period', 3)
        slowd_period = data.get('slowd_period', 3)
        slowk_matype = data.get('slowk_matype', 0)
        slowd_matype = data.get('slowd_matype', 0)
        stochastic_data = calculate_stochastic(symbol, fastk_period, slowk_period, slowd_period, slowk_matype, slowd_matype)
        return stochastic_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Williams R for a company
@app.post("/companies/{symbol}/indicators/williams_r")
async def calculate_williams_r_for_company(symbol: str, data_input_williams_r: dict = Body(...)):
    try:
        symbol = symbol.upper()
        period = data_input_williams_r.get('period', 14)
        williams_r_data = calculate_williams_r(symbol, period)
        return williams_r_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Bollinger Bands for a company
@app.post("/companies/{symbol}/indicators/bollinger_bands")
async def calculate_bollinger_bands_for_company(symbol: str, data_input_bollinger_bands: dict = Body(...)):
    try:
        symbol = symbol.upper()
        period = data_input_bollinger_bands.get('period', 20)
        deviation = data_input_bollinger_bands.get('deviation', 2)
        bollinger_bands_data = calculate_bollinger_bands(symbol, period, deviation)
        return bollinger_bands_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Aroon for a company
@app.post("/companies/{symbol}/indicators/aroon")
async def calculate_aroon_for_company(symbol: str, data_input_aroon: dict = Body(...)):
    try:
        symbol = symbol.upper()
        period = data_input_aroon.get('period', 14)
        aroon_data = calculate_aroon(symbol, period)
        return aroon_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Parabolic SAR for a company
@app.post("/companies/{symbol}/indicators/parabolic_sar")
async def calculate_parabolic_sar_for_company(symbol: str, data_input_parabolic_sar: dict = Body(...)):
    try:
        symbol = symbol.upper()
        acceleration = data_input_parabolic_sar.get('acceleration', 0.02)
        maximum = data_input_parabolic_sar.get('maximum', 0.2)
        parabolic_sar_data = calculate_parabolic_sar(symbol, acceleration, maximum)
        return parabolic_sar_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating CCI for a company
@app.post("/companies/{symbol}/indicators/cci")
async def calculate_cci_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        cci_data = calculate_cci(symbol)
        return cci_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000)