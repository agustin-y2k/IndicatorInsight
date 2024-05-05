# parabolic_sar_indicator.py
import talib
import pandas as pd
from .fetch_data import fetch_company_data
import logging

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate Parabolic SAR"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_parabolic_sar(symbol):
    try:
        data = fetch_company_data(symbol)
        
        if data is None:
            raise ValueError(f"{ERROR_NO_DATA_FOUND} {symbol}")

        data_df = pd.DataFrame(data)

        if len(data_df) < 2:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        sar_values = talib.SAR(data_df['High'], data_df['Low'], acceleration=0.02, maximum=0.2)

        sar_data = {
            'current_sar': round(sar_values.iloc[-1], 2),
            'previous_sar': round(sar_values.iloc[-2], 2),
            'recommendation': sar_recommendation(sar_values)
        }

        return sar_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def sar_recommendation(sar_values):
    current_sar = sar_values.iloc[-1]
    previous_sar = sar_values.iloc[-2]
    
    if current_sar > previous_sar:
        return Recommendation.BUY
    elif current_sar < previous_sar:
        return Recommendation.SELL
    else:
        return Recommendation.NEUTRAL