# Indicator Insight API

This project is a FastAPI-based application for financial data analysis and technical indicator calculations. 
It is designed for both local and containerized deployment with Docker, featuring monitoring and authentication capabilities.

## Features

- **Financial Data Analysis**: Implements indicators like RSI, Moving Averages (MA), MACD, ADX, and Bollinger Bands.
- **User Authentication**: Secured routes with JWT-based authentication.
- **Email Integration**: Includes utilities for password recovery.
- **Data Download & Management**: Efficient handling of historical financial data.
- **Monitoring**: Integrated with Prometheus and Grafana for performance monitoring.

## Configuration

This project utilizes a `config` folder to manage dependencies and service configurations. Below are the key configuration files:

- **requirements.txt**: Specifies Python dependencies for the project.
- **prometheus.yml**: Configures Prometheus for monitoring.
- **nginx.conf**: Configures NGINX as a reverse proxy.

Before running the project, create a `.env` file in config folder with the following parameters:

```plaintext
MAIL_USERNAME="your_email@example.com"
MAIL_PASSWORD="your_email_password"
MAIL_FROM="your_email@example.com"
MAIL_SERVER="your_smtp_server"
MAIL_PORT=465 for SSL or 587 for TLS
MAIL_TLS=False or True
MAIL_SSL=True or False
SECRET_KEY="your_secret_key"
```

## Deployment with Docker

The project supports containerized deployment using Docker. Use the following commands to build and run:

1. Build the Docker image:
   ```bash
   docker compose up -d --scale indicator_insight_api=<NUM_INSTANCES>
   ```

<<<<<<< HEAD
- *main.py*: Contains the main logic of the FastAPI application.
- *main.py*: Contains the main logic of the FastAPI application.
- *Dockerfile*: Configuration file for building the FastAPI Docker image.
- *docker-compose.yml*: Configuration file for Docker Compose to orchestrate containers.
- *config/*
- *prometheus.yml*: Configuration file for Prometheus.
- *requirements.txt*: Python dependencies for the project.
- *routes/*
- *indicator_routes.py*: Routes and handlers for financial indicators.
- *user_routes.py*: Routes and handlers for user management.
- *models/*
- *recommendation.py*: Model for stock recommendations.
- *user.py*: Model for user data.
- *utils/*
- *auth.py*: Authentication and JWT token handling.
- *data_downloader.py*: Functions for downloading and storing financial data.
- *get_data.py*: Functions for retrieving financial data from MongoDB.
- *indicators/*: Directory containing modules for calculating technical indicators.
=======
### Services
>>>>>>> develop

- **API**: FastAPI application (`indicator_insight_api`).
- **Database**: MongoDB for data storage.
- **Monitoring**: Prometheus and Grafana for analytics.
- **NGINX**: Serves as a reverse proxy to route requests and provide load balancing for the FastAPI application. It ensures efficient request handling and improved security.

## API Documentation

The API documentation is accessible through Swagger UI, which provides a user-friendly interface to explore all endpoints and their parameters.

- **Swagger UI**: Visit `http://<your-domain>:<port>/docs` to view the interactive API documentation.
- **OpenAPI JSON**: The JSON schema for the API is available at `http://<your-domain>:<port>/openapi.json`.

### Key Endpoints
Swagger allows you to test endpoints like:
- **User Authentication**: `/users`
- **Financial Indicator Calculations**: `/companies/{symbol}/indicators`