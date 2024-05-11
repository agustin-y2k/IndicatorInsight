# data_downloader.py
import yfinance as yf
from pymongo import MongoClient
from datetime import datetime, timedelta
import logging
import sys
import time
from prometheus_client import Counter

# Config the logging  system to write to stderr
logging.basicConfig(stream=sys.stderr, level=logging.ERROR)

# Defin the Prometheus counter for historical data downloads
HISTORICAL_DATA_DOWNLOAD_COUNT = Counter('historical_data_download_total', 'Total Historical Data Downloads')

def initialize_database():
    try:
        client = MongoClient('mongodb', 27017)
        
        # Eliminar la base de datos si existe
        if 'indicator_insight' in client.list_database_names():
            client.drop_database('indicator_insight')
            logging.info("Existing database 'indicator_insight' has been dropped.")

        db = client['indicator_insight']

        companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
        for company in companies:
            db.create_collection(company)
            logging.info(f"Collection '{company}' has been created in MongoDB.")
        
        logging.info("Database 'indicator_insight' has been created.")
    except Exception as e:
        logging.exception("Error initializing database: %s", e)

def download_data_with_retry(company):
    max_retries = 3
    retry_delay = 5  # seconds
    for _ in range(max_retries):
        try:
            data = yf.download(company)
            return data
        except Exception as e:
            logging.error(f"Error downloading data for {company}: {e}")
            logging.error(f"Retrying in {retry_delay} seconds...")
            time.sleep(retry_delay)
    logging.error(f"Failed to download data for {company} after {max_retries} retries.")
    return None

def download_and_store_historical_data():
    try:
        companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
        client = MongoClient('mongodb', 27017)
        db = client['indicator_insight']
        
        for company in companies:
            collection = db[company]
            
            # Descargar datos con reintento
            data = download_data_with_retry(company)
            if data is None:
                continue  # Saltar esta empresa si la descarga falla
            
            data.reset_index(inplace=True)
            data_dict = data.to_dict(orient='records')
            collection.insert_many(data_dict)
            
            logging.info(f"Data downloaded and stored for {company}.")
    except Exception as e:
        logging.exception("Error in download_and_store_historical_data: %s", e)

def update_current_data():
    try:
        companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
        client = MongoClient('mongodb', 27017)
        db = client['indicator_insight']

        for company in companies:
            collection = db[company]
            
            # Descargar datos con reintento
            data = download_data_with_retry(company)
            if data is None:
                continue  # Saltar esta empresa si la descarga falla
            
            data.reset_index(inplace=True)
            latest_date_db = collection.find_one(sort=[('Date', -1)])['Date'] if collection.count_documents({}) > 0 else None
            latest_date_yf = data['Date'].max()

            # Comprobar si es necesario insertar nuevos datos o actualizar el último documento
            if latest_date_db and latest_date_yf and latest_date_yf > latest_date_db:
                # Insertar un nuevo documento en la colección
                new_data = data[data['Date'] > latest_date_db]
                data_dict = new_data.to_dict(orient='records')
                collection.insert_many(data_dict)
                logging.info(f"New document inserted for {company}.")
            else:
                # Actualizar el último documento en la colección con los nuevos datos
                collection.update_one({'Date': latest_date_db}, {"$set": data_dict[-1]})
                logging.info(f"Last document updated for {company}.")
    except Exception as e:
        logging.exception("Error in update_current_data: %s", e)