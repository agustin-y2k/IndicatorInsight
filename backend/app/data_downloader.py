# data_downloader.py
import yfinance as yf
from pymongo import MongoClient
from datetime import datetime, timedelta
import logging
import sys
from prometheus_client import Counter

# Config the logging  system to write to stderr
logging.basicConfig(stream=sys.stderr, level=logging.ERROR)

# Defin the Prometheus counter for historical data downloads
HISTORICAL_DATA_DOWNLOAD_COUNT = Counter('historical_data_download_total', 'Total Historical Data Downloads')

def initialize_database():
    try:
        client = MongoClient('mongodb', 27017)
        
        # Remove the database if it exists
        if 'indicator_insight' in client.list_database_names():
            client.drop_database('indicator_insight')
            logging.info("Existing database 'indicator_insight' dropped.")

        db = client['indicator_insight']

        companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
        for company in companies:
            db.create_collection(company)
            logging.info(f"Collection '{company}' created in MongoDB.")
        
        logging.info("Database 'indicator_insight' created.")
    except Exception as e:
        logging.exception("Error initializing database: %s", e)

def download_and_store_historical_data():
    try:
        companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
        client = MongoClient('mongodb', 27017)
        db = client['indicator_insight']
        
        for company in companies:
            collection = db[company]
            
            # Verify if there is data in the collection
            if collection.count_documents({}) == 0:
                # If there is no data, download and store historical data
                data = yf.download(company)
                data.reset_index(inplace=True)
                data_dict = data.to_dict(orient='records')
                collection.insert_many(data_dict)
            else:
                # If there is data, download and store only the new data
                latest_date_db = collection.find_one(sort=[('Date', -1)])['Date']
                data = yf.download(company, start=latest_date_db)
                data.reset_index(inplace=True)
                data_dict = data.to_dict(orient='records')
                collection.insert_many(data_dict)

    except Exception as e:
        logging.exception("Error in download_and_store_historical_data: %s", e)

def update_current_data():
    try:
        companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
        client = MongoClient('mongodb', 27017)
        db = client['indicator_insight']

        for company in companies:
            collection = db[company]
            
            companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
            client = MongoClient('mongodb', 27017)
            db = client['indicator_insight']
            last_document = collection.find_one(sort=[('Date', -1)])
            latest_date_db = last_document['Date'] if last_document else None
            
            data = yf.download(company)
            data.reset_index(inplace=True)
            data_dict = data.to_dict(orient='records')
            latest_date_yf = data_dict[-1]['Date'] if data_dict else None
            
            # Verify if new data needs to be inserted or the last document needs to be updated
            if latest_date_db and latest_date_yf and latest_date_yf > latest_date_db:
                # Insert a new document in the collection
                collection.insert_one(data_dict[-1])
                print(f"New document inserted for {company}.")
            else:
                # Update the last document in the collection with the new data
                collection.update_one({'Date': latest_date_db}, {"$set": data_dict[-1]})
                print(f"Last document updated for {company}.")

    except Exception as e:
        logging.exception("Error in update_current_data: %s", e)