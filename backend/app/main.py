# main.py
from fastapi import FastAPI, HTTPException, Request, Response, Body
from fastapi.responses import JSONResponse, ORJSONResponse
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.openapi.docs import get_swagger_ui_html
from fastapi.openapi.utils import get_openapi
from fastapi.param_functions import Body
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
from utils.data_downloader import initialize_database
from utils.fetch_data import fetch_data
import logging
import sys
from prometheus_client import Counter, generate_latest, Histogram

app = FastAPI(
    title="Indicator Insight API",
    description="API for calculating financial indicators.",
    version="1.0.0"
)

# Configure logging to write to stderr
logging.basicConfig(stream=sys.stderr, level=logging.INFO)

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

NO_DATA_ERROR = "No data found for the symbol"
# Initialize the database
initialize_database()

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
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        moving_average_type = moving_average_input.get("moving_average_type")
        periods = moving_average_input.get("periods", [])
        if not moving_average_type:
            raise ValueError("Moving average type is required in the request body")
        moving_averages_data = calculate_moving_averages(symbol_data, moving_average_type, periods)
        return moving_averages_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating ADX for a company
@app.post("/companies/{symbol}/indicators/adx")
async def calculate_adx_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        adx_data = calculate_adx(symbol_data)
        return adx_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating RSI for a company
@app.post("/companies/{symbol}/indicators/rsi")
async def calculate_rsi_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        rsi_data = calculate_rsi(symbol_data)
        return rsi_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating MACD for a company
@app.post("/companies/{symbol}/indicators/macd")
async def calculate_macd_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        macd_data = calculate_macd(symbol_data)
        return macd_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating stochastic for a company
@app.post("/companies/{symbol}/indicators/stochastic")
async def calculate_stochastic_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        stochastic_data = calculate_stochastic(symbol_data)
        return stochastic_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Williams R for a company
@app.post("/companies/{symbol}/indicators/williams_r")
async def calculate_williams_r_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        williams_r_data = calculate_williams_r(symbol_data)
        return williams_r_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Bollinger Bands for a company
@app.post("/companies/{symbol}/indicators/bollinger_bands")
async def calculate_bollinger_bands_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        bollinger_bands_data = calculate_bollinger_bands(symbol_data)
        return bollinger_bands_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Aroon for a company
@app.post("/companies/{symbol}/indicators/aroon")
async def calculate_aroon_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        aroon_data = calculate_aroon(symbol_data)
        return aroon_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating Parabolic SAR for a company
@app.post("/companies/{symbol}/indicators/parabolic_sar")
async def calculate_parabolic_sar_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        parabolic_sar_data = calculate_parabolic_sar(symbol_data)
        return parabolic_sar_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Define endpoint for calculating CCI for a company
@app.post("/companies/{symbol}/indicators/cci")
async def calculate_cci_for_company(symbol: str):
    try:
        symbol = symbol.upper()
        symbol_data = fetch_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        cci_data = calculate_cci(symbol_data)
        return cci_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000)