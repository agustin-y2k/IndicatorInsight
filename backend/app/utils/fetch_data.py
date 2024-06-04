# fetch_data.py
import pymongo
from pymongo import MongoClient
import logging
from .data_downloader import download_and_store_historical_data, download_and_store_missing_data, update_latest_data
from datetime import datetime

def fetch_data(symbol):
    try:
        client = MongoClient('mongodb', 27017)
        db = client["indicator_insight"]
        collection = db[symbol]
        data_count = collection.count_documents({})

        if data_count == 0:
            logging.info(f"No data found for symbol {symbol}. Downloading and storing historical data.")
            download_and_store_historical_data(symbol)

        else:
            today = datetime.now().strftime('%Y-%m-%d')

            latest_document = collection.find_one(sort=[('Date', -1)])
            latest_document_date = latest_document.get('Date')
            
            if isinstance(latest_document_date, str):
                latest_document_date = datetime.strptime(latest_document_date, '%Y-%m-%d')

            latest_document_date_str = latest_document_date.strftime('%Y-%m-%d')

            if latest_document_date_str == today:
                logging.info(f"Data found for symbol {symbol} and for today's date. Updating today's data.")
                update_latest_data(today, symbol)
            else:  
                logging.info(f"Data found for symbol {symbol} but not for today's date.")
                
                # Check if there are missing data
                earliest_date = collection.find_one(sort=[('Date', 1)])['Date']
                if earliest_date != latest_document_date_str:
                    logging.info("Downloading and storing missing historical data.")
                    download_and_store_missing_data(symbol)
                else:
                    logging.info("No missing data found.")

        cursor = collection.find({}, {"_id": 0, "Date": 1, "Open": 1, "High": 1, "Low": 1, "Close": 1, "Adj Close": 1, "Volume": 1})
        data = list(cursor)
        return data

    except pymongo.errors.PyMongoError as e:
        logging.error(f"A MongoDB error occurred: {e}")
        return None
    except Exception as e:
        logging.exception(f"An unexpected error occurred: {e}")
        return None
