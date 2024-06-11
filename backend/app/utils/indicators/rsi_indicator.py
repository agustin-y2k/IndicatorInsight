# rsi_indicator.py
import talib
import pandas as pd
import logging
from .recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_rsi(company_data):
    try:
        period = 14
        data_df = pd.DataFrame(company_data)
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
    if rsi_value >= 80:
        return Recommendation.STRONG_SELL
    elif rsi_value >= 70:
        return Recommendation.SELL
    elif rsi_value <= 20:
        return Recommendation.STRONG_BUY
    elif rsi_value <= 30:
        return Recommendation.BUY
    else:
        return Recommendation.NEUTRAL


