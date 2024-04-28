# fetch_data.py
import pymongo
import logging

# Initialize MongoDB client pointing to the MongoDB service within Docker Compose
client = pymongo.MongoClient("mongodb://mongodb:27017/")  # Use the service name defined in Docker Compose
db = client["indicator_insight"]

def fetch_company_data(symbol):
    try:
        collection = db[symbol]
        cursor = collection.find({}, {"_id": 0, "Date": 1, "Open": 1, "High": 1, "Low": 1, "Close": 1, "Adj Close": 1, "Volume": 1})
        data = list(cursor)
        if not data:
            raise ValueError(f"No data found for symbol {symbol}")
        return data
    except Exception as e:
        logging.exception(f"An unexpected error occurred: {e}")
        return None

