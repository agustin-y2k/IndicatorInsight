# williams_r_indicator.py
import talib
import pandas as pd
import logging
from .fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_williams_r(symbol, period):
    try:
        data = fetch_company_data(symbol)
        if data is None:
            raise ValueError(ERROR_NO_DATA_FOUND)

        if not isinstance(data, list):
            raise ValueError(ERROR_INVALID_DATA_FORMAT)

        data_df = pd.DataFrame(data)
        data_df['Date'] = data_df['Date'].astype(str)

        williams_r_label = f'WilliamsR_{period}'
        williams_r_values = talib.WILLR(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=period)
        data_df[williams_r_label] = williams_r_values
        last_williams_r_value = round(data_df[williams_r_label].iloc[-1], 2)

        recommendation, signal_strength = identify_williams_r_signal(last_williams_r_value)

        return {'WilliamsR': last_williams_r_value, 'Recommendation': recommendation, 'Signal Strength': signal_strength}

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_williams_r_signal(williams_r_value):
    if williams_r_value >= -20:
        return Recommendation.SELL, "Strong Overbought"
    elif williams_r_value <= -80:
        return Recommendation.BUY, "Strong Oversold"
    elif -20 > williams_r_value > -50:
        return Recommendation.SELL, "Moderate Overbought"
    elif -80 < williams_r_value < -50:
        return Recommendation.BUY, "Moderate Oversold"
    else:
        return Recommendation.NEUTRAL, "Neutral"