# aroon_indicator.py
import talib
import pandas as pd
import logging
from .fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_aroon(symbol, period=14):
    try:
        data = fetch_company_data(symbol)
        if data is None:
            raise ValueError(ERROR_NO_DATA_FOUND)

        if not isinstance(data, list):
            raise ValueError(ERROR_INVALID_DATA_FORMAT)

        data_df = pd.DataFrame(data)
        data_df['Date'] = data_df['Date'].astype(str)

        aroon_up_label = f'AROON_UP_{period}'
        aroon_down_label = f'AROON_DOWN_{period}'

        aroon_up, aroon_down = talib.AROON(data_df['High'], data_df['Low'], timeperiod=period)

        data_df[aroon_up_label] = aroon_up
        data_df[aroon_down_label] = aroon_down

        last_aroon_up = round(data_df[aroon_up_label].iloc[-1], 2)
        last_aroon_down = round(data_df[aroon_down_label].iloc[-1], 2)

        recommendation = identify_aroon_signal(last_aroon_up, last_aroon_down)

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

def identify_aroon_signal(aroon_up, aroon_down):
    if aroon_up > aroon_down:
        return Recommendation.BUY, "Aroon Up is greater than Aroon Down"
    elif aroon_up < aroon_down:
        return Recommendation.SELL, "Aroon Down is greater than Aroon Up"
    else:
        return Recommendation.NEUTRAL, "Aroon Up and Aroon Down are equal"