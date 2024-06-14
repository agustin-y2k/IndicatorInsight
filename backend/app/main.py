# main.py
from fastapi import FastAPI, HTTPException, Request, Response, Depends
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.openapi.docs import get_swagger_ui_html
from fastapi.openapi.utils import get_openapi
import logging
import sys
from prometheus_client import Counter, generate_latest, Histogram
from utils.data_downloader import initialize_database
from routes.indicator_routes import router as indicator_router
from routes.user_routes import router as user_router

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


initialize_database()

# Middleware for logging
@app.middleware("http")
async def log_requests(request: Request, call_next):
    if request.url.path != "/metrics":  # Excluir el punto final /metrics del registro
        logging.getLogger('uvicorn.access').setLevel(logging.INFO)
    else:
        logging.getLogger('uvicorn.access').setLevel(logging.ERROR)
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

app.include_router(user_router, prefix="/users", tags=["users"])
app.include_router(indicator_router, prefix="/companies/{symbol}/indicators", tags=["indicators"])

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000)