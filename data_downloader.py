# data_downloader.py
import yfinance as yf
from pymongo import MongoClient
from datetime import datetime, timedelta
import logging
import sys

# Config the logging  system to write to stderr
logging.basicConfig(stream=sys.stderr, level=logging.ERROR)


def initialize_database():
    try:
        client = MongoClient('localhost', 27017)
        
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
        client = MongoClient('localhost', 27017)
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
                
    except Exception as e:
        logging.exception("Error in download_and_store_historical_data: %s", e)

def update_current_data():
    try:
        companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']
        client = MongoClient('localhost', 27017)
        db = client['indicator_insight']
        
        today = datetime.now()
        for company in companies:
            collection = db[company]
            
            # Last document for the current day
            last_document = collection.find_one({'Date': today})
            
            if last_document is None:
                # If there is no data for the current day, insert it
                data = yf.download(company, start=today)
                data.reset_index(inplace=True)
                data_dict = data.to_dict(orient='records')
                collection.insert_many(data_dict)
                logging.info(f"Data for {company} inserted for {today} in MongoDB.")
            else:
                # If there is data for the current day, check if it needs to be updated
                last_date = last_document['Date']
                last_document_id = last_document['_id']
                last_time = datetime.now().time().replace(second=0, microsecond=0)
                last_datetime = datetime.combine(last_date, last_time)
                
                # If the last update was more than an hour ago, update the data
                if datetime.now() - last_datetime >= timedelta(hours=1):
                    new_data = yf.download(company, start=today)
                    new_data.reset_index(inplace=True)
                    new_data_dict = new_data.to_dict(orient='records')
                    
                    # Remove the old data and insert the new data
                    collection.delete_one({'_id': last_document_id})
                    collection.insert_many(new_data_dict)
                    
                    logging.info(f"Data for {company} updated for {today} in MongoDB.")
                else:
                    logging.info(f"No update needed for {company} for {today}.")
    except Exception as e:
        logging.exception("Error in update_current_data: %s", e)