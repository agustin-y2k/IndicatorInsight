# data_downloader.py
import yfinance as yf
from pymongo import MongoClient
import logging
from prometheus_client import Counter

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

def download_and_store_historical_data(symbol):
    try:
        client = MongoClient('mongodb', 27017)
        db = client['indicator_insight']
        collection = db[symbol]

        data = yf.download(symbol)
        data.reset_index(inplace=True)
        data['Date'] = data['Date'].dt.strftime('%Y-%m-%d')

        if not data.empty:
            data_dict = data.to_dict(orient='records')
            collection.insert_many(data_dict)
            logging.info(f"Historical data downloaded and stored for {symbol}")
            HISTORICAL_DATA_DOWNLOAD_COUNT.inc()
        else:
            logging.info(f"No historical data found for {symbol} in Yahoo Finance")
            
    except Exception as e:
        logging.exception(f"Error in download_and_store_historical_data for {symbol}: {e}")
    finally:
        client.close()

def download_and_store_missing_data(symbol):
    try:
        client = MongoClient('mongodb', 27017)
        db = client['indicator_insight']
        collection = db[symbol]

        latest_date_db = collection.find_one(sort=[('Date', -1)])['Date']
        missing_data = yf.download(symbol, start=latest_date_db)

        if not missing_data.empty:
            missing_data.reset_index(inplace=True)
            missing_data['Date'] = missing_data['Date'].dt.strftime('%Y-%m-%d')
            missing_data_dict = missing_data.to_dict(orient='records')

            existing_data = list(collection.find({'Date': {'$gte': latest_date_db}}, {'_id': 0}))
            existing_data_dates = [data['Date'] for data in existing_data]
            missing_data_dict = [data for data in missing_data_dict if data['Date'] not in existing_data_dates]

            if missing_data_dict:
                collection.insert_many(missing_data_dict)
                logging.info(f"Missing historical data downloaded and stored for {symbol}")
                HISTORICAL_DATA_DOWNLOAD_COUNT.inc()
            else:
                logging.info(f"No missing data found for {symbol} in Yahoo Finance")
        else:
            logging.info(f"No missing data found for {symbol} in Yahoo Finance")
            
    except Exception as e:
        logging.exception(f"Error in download_and_store_missing_data for {symbol}: {e}")
    finally:
        client.close()

def update_latest_data(today, symbol):
    try:
        client = MongoClient('mongodb', 27017)
        db = client['indicator_insight']
        collection = db[symbol]

        latest_document = collection.find_one(sort=[('Date', -1)])
        latest_document_date = latest_document.get('Date')

        latest_data = yf.download(symbol, start=today)
        latest_data.reset_index(inplace=True)

        if not latest_data.empty:
            latest_data['Date'] = latest_data['Date'].dt.strftime('%Y-%m-%d')

            latest_data_dict = latest_data.iloc[0].to_dict()
            latest_document_values = {key: latest_document.get(key) for key in latest_data_dict.keys()}

            data_changed = False
            for key, value in latest_data_dict.items():
                if key != 'Date' and value != latest_document_values.get(key):
                    data_changed = True
                    break

            if data_changed:
                collection.update_one({'Date': latest_document_date}, {'$set': latest_data_dict}, upsert=True)
                logging.info(f"Latest data updated for {symbol}")
            else:
                logging.info(f"No changes in data for {symbol}, skipping update")

        else:
            logging.info(f"No latest data found for {symbol} in Yahoo Finance")

    except Exception as e:
        logging.exception(f"Error in update_latest_data for {symbol}: {e}")
    finally:
        client.close()

