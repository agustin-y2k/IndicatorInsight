import talib
import pandas as pd
import logging
from .fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

def calculate_williams_r(symbol, period=14):
    try:
        data = fetch_company_data(symbol)
        if data is None:
            raise ValueError("No data found for the symbol")

        if not isinstance(data, list):
            raise ValueError("Invalid data format")

        data_df = pd.DataFrame(data)
        data_df['Date'] = data_df['Date'].astype(str)

        williams_r_label = f'WilliamsR_{period}'
        williams_r_values = talib.WILLR(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=period)
        data_df[williams_r_label] = williams_r_values
        last_williams_r_value = round(data_df[williams_r_label].iloc[-1], 2)

        recommendation = identify_williams_r_signal(last_williams_r_value)

        return {'WilliamsR': last_williams_r_value, 'Recommendation': recommendation}

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"An unexpected error occurred: {e}")
        return {"error": "An unexpected error occurred"}

def identify_williams_r_signal(williams_r_value):
    if williams_r_value >= -20:
        return Recommendation.SELL, "Overbought"
    elif williams_r_value <= -80:
        return Recommendation.BUY, "Oversold"
    else:
        return Recommendation.NEUTRAL, "Neutral"
