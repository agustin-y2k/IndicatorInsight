# parabolic_sar_indicator.py
import talib
import pandas as pd
import logging
from models.recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate Parabolic SAR"
ERROR_UNEXPECTED = "An unexpected error occurred"
UPWARD_TREND = "Upward Trend"
DOWNWARD_TREND = "Downward Trend"

def calculate_parabolic_sar(company_data):
    try:
        
        data_df = pd.DataFrame(company_data)

        if len(data_df) < 2:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        sar_values = talib.SAR(data_df['High'], data_df['Low'], acceleration=0.02, maximum=0.2)

        sar_data = {
            'current_sar': round(sar_values.iloc[-1], 2),
            'previous_sar': round(sar_values.iloc[-2], 2),
            'trend_direction': determine_trend_direction(data_df, sar_values),
            'recommendation': sar_recommendation(data_df, sar_values)['recommendation'],
        }

        return sar_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}


def determine_trend_direction(data_df, sar_values):
    current_sar = sar_values.iloc[-1]
    previous_sar = sar_values.iloc[-2]
    current_price = data_df['Close'].iloc[-1]
    previous_price = data_df['Close'].iloc[-2]

    if current_sar > previous_sar and current_price > previous_price:
        return UPWARD_TREND
    elif current_sar < previous_sar and current_price < previous_price:
        return DOWNWARD_TREND
    else:
        return "No Clear Trend"

def sar_recommendation(data_df, sar_values):
    current_sar, previous_sar = sar_values.iloc[-1], sar_values.iloc[-2]

    if current_sar > previous_sar:
        if data_df['Close'].iloc[-1] > current_sar:
            recommendation = Recommendation.STRONG_BUY
        else:
            recommendation = Recommendation.BUY
    elif current_sar < previous_sar:
        if data_df['Close'].iloc[-1] < current_sar:
            recommendation = Recommendation.STRONG_SELL
        else:
            recommendation = Recommendation.SELL
    else:
        recommendation = Recommendation.NEUTRAL

    return {"recommendation": recommendation}


