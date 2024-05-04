# macd_indicator.py
import talib
import pandas as pd
import logging
from .fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate MACD"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_macd(symbol):
    try:
        data = fetch_company_data(symbol)
        
        if data is None:
            raise ValueError(f"{ERROR_NO_DATA_FOUND} {symbol}")

        data_df = pd.DataFrame(data)

        if len(data_df) < 26:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        macd, signal, _ = talib.MACD(data_df['Close'], fastperiod=12, slowperiod=26, signalperiod=9)

        macd_data = {
            'macd_line': round(macd.iloc[-1], 2),
            'signal_line': round(signal.iloc[-1], 2),
            'histogram': round(macd.iloc[-1] - signal.iloc[-1], 2),
            'recommendation': macd_recommendation(macd, signal)
        }

        return macd_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def macd_recommendation(macd, signal):
    if macd.iloc[-1] > signal.iloc[-1]:
        return Recommendation.BUY
    elif macd.iloc[-1] < signal.iloc[-1]:
        return Recommendation.SELL
    else:
        return Recommendation.NEUTRAL
