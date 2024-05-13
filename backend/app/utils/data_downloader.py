# data_downloader.py
import yfinance as yf
from pymongo import MongoClient
import logging
from prometheus_client import Counter
import pandas as pd

# Define the Prometheus counter for historical data downloads
HISTORICAL_DATA_DOWNLOAD_COUNT = Counter('historical_data_download_total', 'Total Historical Data Downloads')

def initialize_database():
    try:
        client = MongoClient('mongodb', 27017)
        
        # Check if the database 'indicator_insight' exists
        if 'indicator_insight' not in client.list_database_names():
            # If the database does not exist, create it
            client['indicator_insight']
            logging.info("Database 'indicator_insight' created.")
        else:
            logging.info("Database 'indicator_insight' already exists.")
    except Exception as e:
        logging.exception("Error initializing database: %s", e)

def download_and_store_data(today, symbol):
    try:
        client = MongoClient('mongodb://mongodb:27017/')
        db = client['indicator_insight']
        
        collection = db[symbol]

        # Check if there's any data in the collection
        if collection.count_documents({}) == 0:
            # If no data, download and store historical data
            data = yf.download(symbol)
            if not data.empty:
                data.reset_index(inplace=True)
                data_dict = data.to_dict(orient='records')
                collection.insert_many(data_dict)
                logging.info(f"Downloaded and stored historical data for {symbol}")
                HISTORICAL_DATA_DOWNLOAD_COUNT.inc()
            else:
                logging.info(f"No historical data found for {symbol} from Yahoo Finance")
        else:
            # If there's data, check if today's data exists
            if collection.count_documents({'Date': today}) == 0:
                # If today's data is missing, download and store all missing data
                latest_date_db = collection.find_one(sort=[('Date', -1)])['Date'].strftime('%Y-%m-%d')
                data = yf.download(symbol, start=latest_date_db)
                if not data.empty:
                    data.reset_index(inplace=True)
                    data_dict = data.to_dict(orient='records')
                    collection.insert_many(data_dict)
                    logging.info(f"Downloaded and stored missing historical data for {symbol}")
                    HISTORICAL_DATA_DOWNLOAD_COUNT.inc()
                else:
                    logging.info(f"No missing historical data found for {symbol}")

    except Exception as e:
        logging.exception("Error in download_and_store_data: %s", e)

def update_latest_data(symbol):
    try:
        client = MongoClient('mongodb://mongodb:27017/')
        db = client['indicator_insight']
        
        collection = db[symbol]

        # Obtener la fecha del último documento en la base de datos
        latest_date_db = collection.find_one(sort=[('Date', -1)])['Date'].strftime('%Y-%m-%d')

        # Descargar los datos más recientes de Yahoo Finance desde la fecha del último documento
        latest_date_yahoo = yf.download(symbol, start=latest_date_db)

        if not latest_date_yahoo.empty:
            latest_date_yahoo.reset_index(inplace=True)
            latest_data_dict = latest_date_yahoo.to_dict(orient='records')
            latest_data = latest_data_dict[0]  # Assuming there's only one record
            collection.replace_one({'Date': latest_date_db}, latest_data)
            logging.info(f"Updated historical data for {symbol} on {latest_date_db}")
            HISTORICAL_DATA_DOWNLOAD_COUNT.inc()
        else:
            logging.info(f"No data found for {symbol} on {latest_date_db}")

    except IndexError:
        logging.warning(f"No data found for {symbol} on {latest_date_db}")
    except Exception as e:
        logging.exception("Error in update_latest_data: %s", e)
