# rsi_indicator.py
import talib
import pandas as pd
import logging
from ..fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_rsi(symbol, period=14):
    try:
        data = fetch_company_data(symbol)
        if data is None:
            raise ValueError(ERROR_NO_DATA_FOUND)

        if not isinstance(data, list):
            raise ValueError(ERROR_INVALID_DATA_FORMAT)

        data_df = pd.DataFrame(data)
        data_df['Date'] = data_df['Date'].astype(str)

        rsi_label = f'RSI_{period}'
        rsi_values = talib.RSI(data_df['Close'], timeperiod=period)
        data_df[rsi_label] = rsi_values
        last_rsi_value = round(data_df[rsi_label].iloc[-1], 2)

        recommendation = identify_rsi_signal(last_rsi_value)

        return {'RSI': last_rsi_value, 'Recommendation': recommendation}

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_rsi_signal(rsi_value):
    midpoint = 50
    if rsi_value > midpoint:
        if rsi_value >= 70:
            return Recommendation.SELL, "Overbought"
        else:
            return Recommendation.NEUTRAL, "Closer to Overbought"
    elif rsi_value < midpoint:
        if rsi_value <= 30:
            return Recommendation.BUY, "Oversold"
        else:
            return Recommendation.NEUTRAL, "Closer to Oversold"
    else:
        return Recommendation.NEUTRAL, "Neutral"