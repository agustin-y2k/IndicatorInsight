# fetch_data.py
import pymongo

# Initialize MongoDB client pointing to the MongoDB service within Docker Compose
client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client["indicator_insight"]

def fetch_company_data(symbol):
    try:
        collection = db[symbol]
        cursor = collection.find({}, {"_id": 0, "Date": 1, "Open": 1, "High": 1, "Low": 1, "Close": 1, "Adj Close": 1, "Volume": 1})
        data = list(cursor)
        if not data:
            return None
        return data
    except Exception as e:
        print(f"An error occurred while fetching data for symbol {symbol}: {str(e)}")
        return None
