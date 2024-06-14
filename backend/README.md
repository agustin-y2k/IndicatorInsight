# Indicator Insight

Indicator Insight is a web application that provides financial technical analysis for both beginners and experts. It utilizes technical indicators such as moving averages and the average directional movement index (ADX) to offer recommendations on potential stock buying or selling opportunities.

## Table of Contents

- [Indicator Insight](#indicator-insight)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Configuration](#configuration)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Project Structure](#project-structure)
  - [Metrics](#metrics)

## Prerequisites

To be able to run and use Indicator Insight, make sure you have the following installed on your system:

- Docker
- Python 3.9

## Configuration

1. Clone this repository to your local machine.
2. Ensure Docker is installed and running.
3. Make sure Python 3.9 is installed on your system.
4. Navigate to the project directory in your terminal.

## Installation

```bash
docker-compose up -d
```

## Usage

For more detailed usage and parameter information, refer to the Swagger UI documentation available at http://localhost:8000/docs

## Project Structure
The project is structured as follows:

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

## Metrics
The application provides metrics that can be collected by Prometheus for subsequent visualization in Grafana. Available metrics include the total count of HTTP requests and request latency.

Prometheus

    localhost:9090

Grafana

    localhost:3000