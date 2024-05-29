# cci_indicator.py
import talib
import pandas as pd
import logging
from .recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate CCI"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_cci(company_data, period=20):
    try:
        data_df = pd.DataFrame(company_data)

        if len(data_df) < period:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        # Calculate CCI values
        cci_values = talib.CCI(data_df['High'], data_df['Low'], data_df['Close'], timeperiod=period)

        cci_data = {
            'current_cci': round(cci_values.iloc[-1], 2),
            'recommendation': cci_recommendation(cci_values, data_df)
        }

        return cci_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def cci_recommendation(cci_values, data_df):
    current_cci = cci_values.iloc[-1]
    previous_cci = cci_values.iloc[-2]
    cci_trend = current_cci - previous_cci

    safety_margin = 5
    strong_threshold = 200

    if current_cci > (100 + safety_margin):
        if current_cci > strong_threshold or (previous_cci <= (100 + safety_margin) and cci_trend > 0):
            return Recommendation.STRONG_SELL if current_cci > strong_threshold else Recommendation.SELL
    elif current_cci < (-100 - safety_margin):
        if current_cci < -strong_threshold or (previous_cci >= (-100 - safety_margin) and cci_trend < 0):
            return Recommendation.STRONG_BUY if current_cci < -strong_threshold else Recommendation.BUY
    else:
        price_trend = data_df['High'][-1] - data_df['Low'][-1]
        short_term_trend = cci_values.iloc[-1] - cci_values.iloc[-10]
        long_term_trend = cci_values.iloc[-1] - cci_values.iloc[-40]

        if price_trend > 0 and cci_trend < 0:
            return f"Bearish Divergence - {Recommendation.SELL}"
        elif price_trend < 0 and cci_trend > 0:
            return f"Bullish Divergence - {Recommendation.BUY}"
        elif short_term_trend > 0 and long_term_trend > 0:
            return Recommendation.BUY
        elif short_term_trend < 0 and long_term_trend < 0:
            return Recommendation.SELL
        else:
            return Recommendation.NEUTRAL