# data_collection.py
import yfinance as yf
from pymongo import MongoClient

# Companies to fetch data for
companies = ['META', 'AAPL', 'GOOG', 'AMZN', 'MSFT', 'TSLA', 'NVDA']

# Connect to the MongoDB database
client = MongoClient('localhost', 27017)
db = client['indicator_insight']

# Get complete historical data for each company and save only the missing data to MongoDB
for company in companies:
    # Get the corresponding collection
    collection = db[company]
    
    # Get complete historical data from Yahoo Finance
    data = yf.download(company)
    
    # Convert the data to a format that can be inserted into MongoDB
    data.reset_index(inplace=True)
    data_dict = data.to_dict(orient='records')
    
    # Check if the data already exists in the collection
    existing_dates = collection.distinct("Date")
    
    # Get the latest date in the collection
    if existing_dates:
        latest_date = max(existing_dates)
    else:
        latest_date = None
    
    # Filter out the new data that is not present in the collection
    new_data = [record for record in data_dict if record['Date'] > latest_date] if latest_date else data_dict
    
    # Insert the new data into the collection
    if new_data:
        collection.insert_many(new_data)
        print(f"New data for {company} inserted into MongoDB.")
    else:
        print(f"No new data for {company}.")
