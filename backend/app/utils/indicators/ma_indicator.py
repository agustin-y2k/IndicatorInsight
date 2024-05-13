# ma_indicator.py
import talib
import pandas as pd
import logging
from collections import OrderedDict
from ..fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"


def calculate_moving_averages(company_data, moving_average_type, periods):
    try:

        data_df = pd.DataFrame(company_data)
        data_df['Date'] = data_df['Date'].astype(str)
        
        periods = sorted(periods)

        moving_averages = OrderedDict()
        last_crossing = OrderedDict()
        recommendation = OrderedDict()

        for period in periods:
            ma_label = f'{moving_average_type.upper()}{int(period)}'
            ma_values = talib.MA(data_df['Close'], timeperiod=int(period))
            data_df[ma_label] = ma_values
            last_ma_value = round(data_df[ma_label].iloc[-1], 2)  # Reduce to two decimal places
            moving_averages[ma_label] = last_ma_value

        for short_term, long_term in zip(periods[:-1], periods[1:]):
            short_label = f'{moving_average_type.upper()}{int(short_term)}'
            long_label = f'{moving_average_type.upper()}{int(long_term)}'
            last_crossing_date, last_crossing_value, last_crossing_type = identify_last_crossing(data_df, short_label, long_label)
            if last_crossing_date:
                last_crossing[f'{short_label}_{long_label}'] = {'Date': str(last_crossing_date), 'Value': round(last_crossing_value, 2), 'Type': last_crossing_type}  # Round to two decimal places

        for period in periods:
            ma_label = f'{moving_average_type.upper()}{int(period)}'
            position_to_ma = identify_recommendation(data_df, ma_label)
            recommendation[ma_label] = position_to_ma

        return {
            'moving_averages': dict(moving_averages),
            'last_crossing': dict(last_crossing),
            'recommendation': dict(recommendation)
        }

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_last_crossing(data_df, short_term, long_term):
    last_crossing_date = None
    last_crossing_value = None
    last_crossing_type = None

    for i in range(1, len(data_df)):
        if data_df[short_term].iloc[i-1] < data_df[long_term].iloc[i-1] and data_df[short_term].iloc[i] > data_df[long_term].iloc[i]:
            last_crossing_date = data_df['Date'].iloc[i]
            last_crossing_value = data_df[short_term].iloc[i]
            last_crossing_type = 'Golden Cross'
        elif data_df[short_term].iloc[i-1] > data_df[long_term].iloc[i-1] and data_df[short_term].iloc[i] < data_df[long_term].iloc[i]:
            last_crossing_date = data_df['Date'].iloc[i]
            last_crossing_value = data_df[short_term].iloc[i]
            last_crossing_type = 'Death Cross'

    return last_crossing_date, last_crossing_value, last_crossing_type

def identify_recommendation(data_df, moving_average_label):
    last_close = data_df['Close'].iloc[-1]
    last_ma_value = data_df[moving_average_label].iloc[-1]

    if last_close > last_ma_value:
        return Recommendation.BUY
    elif last_close < last_ma_value:
        return Recommendation.SELL
    else:
        return Recommendation.NEUTRAL
