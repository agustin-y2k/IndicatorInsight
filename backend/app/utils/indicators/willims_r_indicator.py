# williams_r_indicator.py
import talib
import pandas as pd
import logging
from .recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_williams_r(company_data):
    try:
        period=14
        data_df = pd.DataFrame(company_data)
        data_df['Date'] = data_df['Date'].astype(str)

        williams_r_label = f'WilliamsR_{period}'
        williams_r_values = talib.WILLR(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=14)
        data_df[williams_r_label] = williams_r_values
        last_williams_r_value = round(data_df[williams_r_label].iloc[-1], 2)

        recommendation_data = identify_williams_r_signal(last_williams_r_value)

        williams_r_data = {
            'WilliamsR': last_williams_r_value,
            'Recommendation': recommendation_data["recommendation"],
            'Signal Strength': recommendation_data["signal_strength"]
        }

        return williams_r_data

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_williams_r_signal(williams_r_value):
    if williams_r_value <= -80:
        return {
            "recommendation": Recommendation.STRONG_BUY,
            "signal_strength": "Strong Oversold"
        }
    elif williams_r_value >= -20:
        return {
            "recommendation": Recommendation.STRONG_SELL, 
            "signal_strength": "Strong Overbought"
        }
    elif -80 < williams_r_value < -50:
        return {
            "recommendation": Recommendation.BUY, 
            "signal_strength": "Oversold"
        }
    elif -20 > williams_r_value > -50:
        return {
            "recommendation": Recommendation.SELL, 
            "signal_strength": "Overbought"
        }
    else:
        return {
            "recommendation": Recommendation.NEUTRAL,
            "signal_strength": "No clear signal"
        }
