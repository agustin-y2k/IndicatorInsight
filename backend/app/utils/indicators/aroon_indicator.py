# aroon_indicator.py
import talib
import pandas as pd
import logging
from .recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_aroon(company_data):
    try:
        period=14
        overbought_level=70
        oversold_level=30
        data_df = pd.DataFrame(company_data)
        data_df['Date'] = data_df['Date'].astype(str)

        aroon_up_label = f'AROON_UP_{period}'
        aroon_down_label = f'AROON_DOWN_{period}'

        aroon_up, aroon_down = talib.AROON(data_df['High'], data_df['Low'], timeperiod=14)

        data_df[aroon_up_label] = aroon_up
        data_df[aroon_down_label] = aroon_down

        last_aroon_up = round(data_df[aroon_up_label].iloc[-1], 2)
        last_aroon_down = round(data_df[aroon_down_label].iloc[-1], 2)

        recommendation = identify_aroon_signal(last_aroon_up, last_aroon_down, overbought_level, oversold_level)

        return {
            'AroonUp': last_aroon_up,
            'AroonDown': last_aroon_down,
            'Recommendation': recommendation
        }

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_aroon_signal(aroon_up, aroon_down, overbought_level, oversold_level):
    if aroon_up > aroon_down and aroon_up >= overbought_level:
        return Recommendation.SELL, "Aroon Up is overbought"
    elif aroon_down > aroon_up and aroon_down >= oversold_level:
        return Recommendation.BUY, "Aroon Down is oversold"
    else:
        return Recommendation.NEUTRAL, "No clear signal"
