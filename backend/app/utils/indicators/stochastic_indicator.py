# schocastic_indicator.py
import talib
import pandas as pd
import logging
from .recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate Stochastic Oscillator"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_stochastic(company_data, fastk_period, slowk_period, slowd_period, slowk_matype, slowd_matype):
    try:

        data_df = pd.DataFrame(company_data)

        if len(data_df) < fastk_period:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        slowk, slowd = talib.STOCH(data_df['High'], data_df['Low'], data_df['Close'],
                                fastk_period, slowk_period,
                                slowk_matype, slowd_period,
                                slowd_matype)

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
    if slowk.iloc[-1] > slowd.iloc[-1] and slowk.iloc[-1] > 50 and slowd.iloc[-1] > 50:
        return Recommendation.BUY
    elif slowk.iloc[-1] < slowd.iloc[-1] and slowk.iloc[-1] < 50 and slowd.iloc[-1] < 50:
        return Recommendation.SELL
    else:
        return Recommendation.NEUTRAL

