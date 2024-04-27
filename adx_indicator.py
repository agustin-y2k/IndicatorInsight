# adx_indicator.py
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

# Function to fetch data from MongoDB and calculate the ADX indicator, DI+ and DI-
def calculate_adx(symbol):
    collection = db[symbol]
    # Fetch data from MongoDB and adjust the index
    data = pd.DataFrame(collection.find({}, {"_id": 0, "Date": 1, "High": 1, "Low": 1, "Close": 1}))
    data['Date'] = pd.to_datetime(data['Date'])
    data.set_index('Date', inplace=True)

    # Calculate ADX, DI+ and DI-
    adx_values = talib.ADX(data['High'], data['Low'], data['Close'], timeperiod=14)
    di_plus = talib.PLUS_DI(data['High'], data['Low'], data['Close'], timeperiod=14)
    di_minus = talib.MINUS_DI(data['High'], data['Low'], data['Close'], timeperiod=14)

    # Add ADX, DI+ and DI- values to the DataFrame
    data['ADX'] = adx_values
    data['DI+'] = di_plus
    data['DI-'] = di_minus

    return data

# Identify the last crossover between DI+ and DI-
def identify_last_cross(data):
    last_cross = None
    for i in range(1, len(data)):
        if data['DI+'].iloc[i-1] < data['DI-'].iloc[i-1] and data['DI+'].iloc[i] > data['DI-'].iloc[i]:
            last_cross = {'Date': data.index[i], 'Type': 'Bullish Cross'}
        elif data['DI+'].iloc[i-1] > data['DI-'].iloc[i-1] and data['DI+'].iloc[i] < data['DI-'].iloc[i]:
            last_cross = {'Date': data.index[i], 'Type': 'Bearish Cross'}
    return last_cross

def determine_trend_strength(adx_value, di_plus, di_minus):
    if adx_value < 25:
        return "Absence of clear trend"
    elif adx_value >= 25 and adx_value < 40:
        if di_plus > di_minus:
            return "Clear bullish trend"
        elif di_plus < di_minus:
            return "Clear bearish trend"
        else:
            return "Sideways trend"
    elif adx_value >= 40 and adx_value <= 50:
        if di_plus > di_minus:
            return "Strong bullish trend (possible peak)"
        elif di_plus < di_minus:
            return "Strong bearish trend (possible peak)"
        else:
            return "Sideways trend"
    elif adx_value > 50:
        return "Very strong trend (trend peak)"

# Recommendation function based on ADX and DI crossovers
def adx_recommendation(adx, adxpdi, adxndi, adxpdi1, adxndi1):
    if (adx > 25 and adxpdi1 < adxndi1 and adxpdi > adxndi):
        return Recommendation.BUY
    elif (adx > 25 and adxpdi1 > adxndi1 and adxpdi < adxndi):
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

# Fetch data and calculate ADX, DI+ and DI- for the selected company
data = calculate_adx(selected_company)

# Show the current value of ADX, DI+ and DI-
current_adx = round(data['ADX'].iloc[-1], 2)
current_pdi = round(data['DI+'].iloc[-1], 2)
current_ndi = round(data['DI-'].iloc[-1], 2)

print(f"\nCurrent ADX value for {selected_company}: {current_adx}")
print(f"Current DI+ value for {selected_company}: {current_pdi}")
print(f"Current DI- value for {selected_company}: {current_ndi}")

# Determine trend strength based on ADX
trend_strength = determine_trend_strength(current_adx, current_pdi, current_ndi)

# Print the recommendation and trend strength
print(f"\nTrend strength for {selected_company}: {trend_strength}")

# Identify the last crossover between DI+ and DI-
last_cross = identify_last_cross(data)
if last_cross:
    cross_date = last_cross['Date'].date()  # Get only the date
    print(f"\nLast crossover between DI+ and DI- for {selected_company}: {last_cross['Type']} on {cross_date}")
else:
    print(f"\nNo crossover between DI+ and DI- found for {selected_company}")

# Calculate recommendation based on ADX and DI crossovers
adx_value = current_adx
pdi = current_pdi
ndi = current_ndi
recommendation = adx_recommendation(adx_value, pdi, ndi, data['DI+'].iloc[-2], data['DI-'].iloc[-2])
print(f"\nRecommendation for {selected_company}: {recommendation}")
