# stochastic_indicator.py
import talib
import pandas as pd
import logging
from models.recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate Stochastic Oscillator"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_stochastic(company_data):
    try:
        data_df = pd.DataFrame(company_data)

        if len(data_df) < 14:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        slowk, slowd = talib.STOCH(data_df['High'], data_df['Low'], data_df['Close'],
                                fastk_period=14, slowk_period=3,
                                slowk_matype=0, slowd_period=3,
                                slowd_matype=0)

        stochastic_data = {
            'slowk': round(slowk.iloc[-1], 2),
            'slowd': round(slowd.iloc[-1], 2),
            'recommendation': stochastic_recommendation(slowk, slowd),
        }

        return stochastic_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def stochastic_recommendation(slowk, slowd):
    current_slowk = slowk.iloc[-1]
    current_slowd = slowd.iloc[-1]

    if current_slowk > current_slowd and current_slowk < 20 and current_slowd < 20:
        if current_slowk < 10 and current_slowd < 10:
            return Recommendation.STRONG_BUY
        return Recommendation.BUY
    elif current_slowk < current_slowd and current_slowk > 80 and current_slowd > 80:
        if current_slowk > 90 and current_slowd > 90:
            return Recommendation.STRONG_SELL
        return Recommendation.SELL
    
    return Recommendation.NEUTRAL

