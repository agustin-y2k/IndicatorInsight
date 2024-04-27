# ma_indicator.py
import pymongo
import pandas as pd
import talib

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

# Initialize MongoDB client
client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client["indicator_insight"]

# Function to fetch data from MongoDB and calculate moving averages
def calculate_moving_averages(symbol, moving_average_type):
    collection = db[symbol]
    # Fetch data from MongoDB and adjust the index
    data = pd.DataFrame(collection.find({}, {"_id": 0, "Date": 1, "Close": 1}))
    data['Date'] = pd.to_datetime(data['Date'])
    data.set_index('Date', inplace=True)

    # Calculate moving averages
    periods = [20, 50, 200]
    for period in periods:
        ma_func = getattr(talib, moving_average_type.upper())
        data[f'{moving_average_type.upper()}{period}'] = ma_func(data['Close'], timeperiod=period)

    return data

# Identify last crossover between moving averages
def identify_last_crossing(data, short_term, long_term):
    last_crossing = None
    
    for i in range(1, len(data)):
        if data[short_term].iloc[i-1] < data[long_term].iloc[i-1] and data[short_term].iloc[i] > data[long_term].iloc[i]:
            if data[short_term].iloc[i] > data[long_term].iloc[i]:
                last_crossing = {'Date': data.index[i], 'Value': data[short_term].iloc[i], 'Type': 'Golden Cross'}
        elif data[short_term].iloc[i-1] > data[long_term].iloc[i-1] and data[short_term].iloc[i] < data[long_term].iloc[i]:
            if data[short_term].iloc[i] < data[long_term].iloc[i]:
                last_crossing = {'Date': data.index[i], 'Value': data[short_term].iloc[i], 'Type': 'Death Cross'}
    
    return last_crossing['Date'], last_crossing['Value'], last_crossing['Type']

def identify_position_to_ma(data, moving_average_label):
    last_close = data['Close'].iloc[-1]
    last_ma_value = data[moving_average_label].iloc[-1]
    
    if last_close > last_ma_value:
        return Recommendation.BUY
    elif last_close < last_ma_value:
        return Recommendation.SELL
    else:
        return Recommendation.NEUTRAL

# Get the list of available companies
companies = db.list_collection_names()

print("Available companies:")
for i, company in enumerate(companies):
    print(f"{i + 1}. {company}")
selection = int(input("Enter the number of the company you want to analyze: ")) - 1
selected_company = companies[selection]

print("Available types of moving averages: SMA (Simple Moving Average), EMA (Exponential Moving Average), WMA (Weighted Moving Average)")
for i, ma_type in enumerate(['SMA', 'EMA', 'WMA']):
    print(f"{i + 1}. {ma_type}")
selection = int(input("Enter the number of the moving average type you want to use: ")) - 1
moving_average_type = ['SMA', 'EMA', 'WMA'][selection]

# Fetch data and calculate moving averages for the selected company
data = calculate_moving_averages(selected_company, moving_average_type)

# Show the relationship between the current price and each moving average
current_price = round(data['Close'].iloc[-1], 2)
print(f"\nCurrent price of {selected_company}: {current_price}")
print(f"\nCurrent trend for {selected_company}:")
for period in [20, 50, 200]:
    if period == 20:
        term = "short-term"
    elif period == 50:
        term = "medium-term"
    elif period == 200:
        term = "long-term"

    ma_label = f'{moving_average_type.upper()}{period}'
    ma_value = round(data[ma_label].iloc[-1], 2)

    if current_price > ma_value:
        trend = "bullish"
    elif current_price < ma_value:
        trend = "bearish"
    else:
        trend = "sideways"

    print(f"{term}: {trend} -> value of {ma_label}: {ma_value}")

# Identify and show the last crossover between moving averages for each combination
for short_term, long_term in [(f'{moving_average_type}20', f'{moving_average_type}50'), (f'{moving_average_type}50', f'{moving_average_type}200')]:
    last_crossing_date, last_crossing_value, last_crossing_type = identify_last_crossing(data, short_term, long_term)
    last_crossing_date = last_crossing_date.date()
    last_crossing_value = round(last_crossing_value, 2)
    if last_crossing_date is not None:
        print(f"\nLast crossover between {short_term} and {long_term} for {selected_company}:")
        print(f"Date: {last_crossing_date}, Value: {last_crossing_value}, Type: {last_crossing_type}")
    else:
        print(f"\nNo crossover between {short_term} and {long_term} found for {selected_company}")

for period in [20, 50, 200]:
    ma_label = f'{moving_average_type.upper()}{period}'
    ma_value = round(data[ma_label].iloc[-1], 2)
    recommendation = identify_position_to_ma(data, ma_label)
    print(f"\nRecommendation based on closing value and {ma_label}: {recommendation}")
