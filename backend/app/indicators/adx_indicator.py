# adx_indicator.py
import talib
import pandas as pd
from datetime import datetime
from .fetch_data import fetch_company_data
import logging

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

# Function to calculate the ADX indicator for a given symbol
def calculate_adx(symbol):
    try:
        data = fetch_company_data(symbol)
        
        if data is None:
            raise ValueError(f"No data found for symbol {symbol}")

        data_df = pd.DataFrame(data)

        if len(data_df) < 14:
            raise ValueError("Insufficient data to calculate ADX")

        adx_values = talib.ADX(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=14)
        di_plus = talib.PLUS_DI(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=14)
        di_minus = talib.MINUS_DI(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=14)

        adx_data = {
            'current_adx': round(adx_values.iloc[-1], 2),
            'current_di_plus': round(di_plus.iloc[-1], 2),
            'current_di_minus': round(di_minus.iloc[-1], 2),
            'trend_strength': determine_trend_strength(adx_values.iloc[-1], di_plus.iloc[-1], di_minus.iloc[-1]),
            'last_cross': identify_last_cross(data_df, di_plus, di_minus),
            'recommendation': adx_recommendation(adx_values, di_plus, di_minus)
        }

        return adx_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"An unexpected error occurred: {e}")
        return {"error": "An unexpected error occurred"}

# Function to identify the last bullish or bearish cross
def identify_last_cross(data_df, di_plus, di_minus):
    last_cross = None
    for i in range(1, len(di_plus)):
        if di_plus.iloc[i-1] < di_minus.iloc[i-1] and di_plus.iloc[i] > di_minus.iloc[i]:
            date = data_df['Date'].iloc[i].strftime("%Y-%m-%d")
            last_cross = {'Type': 'Bullish Cross', 'Date': date}
        elif di_plus.iloc[i-1] > di_minus.iloc[i-1] and di_plus.iloc[i] < di_minus.iloc[i]:
            date = data_df['Date'].iloc[i].strftime("%Y-%m-%d")
            last_cross = {'Type': 'Bearish Cross', 'Date': date}
    return last_cross

# Function to determine the strength of the trend based on the ADX value
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

# Function to determine the recommendation based on the ADX values
def adx_recommendation(adx_values, di_plus, di_minus):
    adx_value = adx_values.iloc[-1]
    pdi = di_plus.iloc[-1]
    ndi = di_minus.iloc[-1]
    pdi1 = di_plus.iloc[-2]
    ndi1 = di_minus.iloc[-2]
    
    if adx_value > 25:
        if pdi1 < ndi1 and pdi > ndi:
            return Recommendation.BUY
        elif pdi1 > ndi1 and pdi < ndi:
            return Recommendation.SELL
    return Recommendation.NEUTRAL


