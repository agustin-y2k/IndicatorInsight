# cci_indicator.py
import talib
import pandas as pd
from ..fetch_data import fetch_company_data
import logging

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate CCI"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_cci(symbol, period=14):
    try:
        data = fetch_company_data(symbol)
        
        if data is None:
            raise ValueError(f"{ERROR_NO_DATA_FOUND} {symbol}")

        data_df = pd.DataFrame(data)

        if len(data_df) < period:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        cci_values = talib.CCI(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=period)

        cci_data = {
            'current_cci': round(cci_values.iloc[-1], 2),
            'recommendation': cci_recommendation(cci_values)
        }

        return cci_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def cci_recommendation(cci_values):
    current_cci = cci_values.iloc[-1]
    previous_cci = cci_values.iloc[-2]
    cci_trend = current_cci - previous_cci
    
    safety_margin = 10  # Margen de seguridad
    
    if current_cci > (100 + safety_margin) and previous_cci <= (100 + safety_margin) and cci_trend > 0:
        return Recommendation.SELL
    elif current_cci < (-100 - safety_margin) and previous_cci >= (-100 - safety_margin) and cci_trend < 0:
        return Recommendation.BUY
    else:
        return Recommendation.NEUTRAL
