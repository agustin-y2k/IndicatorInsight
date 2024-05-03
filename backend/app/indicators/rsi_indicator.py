import talib
import pandas as pd
import logging
from .fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

def calculate_rsi(symbol, period=14):
    try:
        data = fetch_company_data(symbol)
        if data is None:
            raise ValueError("No data found for the symbol")

        if not isinstance(data, list):
            raise ValueError("Invalid data format")

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
        logging.exception(f"An unexpected error occurred: {e}")
        return {"error": "An unexpected error occurred"}

def identify_rsi_signal(rsi_value):
    if rsi_value >= 70:
        return Recommendation.SELL, "Overbought"
    elif rsi_value <= 30:
        return Recommendation.BUY, "Oversold"
    else:
        return Recommendation.NEUTRAL, "Neutral"

