# ma_indicator.py
import talib
import pandas as pd
import logging
from .fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

def calculate_moving_averages(symbol, moving_average_type, periods):
    try:
        data = fetch_company_data(symbol)  # Obtener solo los datos, no los tipos de datos
        if data is None:
            raise ValueError("No data found for the symbol")

        if not isinstance(data, list):
            raise ValueError("Invalid data format")

        data_df = pd.DataFrame(data)

        # Convertir la columna de fecha a cadena
        data_df['Date'] = data_df['Date'].astype(str)

        response_data = {
            'moving_averages': {},
            'last_crossing': {},
            'position_to_ma': {}
        }

        # Calculate moving averages
        for period in periods:
            ma_label = f'{moving_average_type.upper()}{int(period)}'
            ma_values = talib.MA(data_df['Close'], timeperiod=int(period))
            data_df[ma_label] = ma_values
            last_ma_value = round(data_df[ma_label].iloc[-1], 2)  # Redondear a dos decimales
            response_data['moving_averages'][ma_label] = last_ma_value

        # Identificar el cruce más reciente
        last_crossing = {}
        for short_term, long_term in zip(periods[:-1], periods[1:]):
            short_label = f'{moving_average_type.upper()}{int(short_term)}'
            long_label = f'{moving_average_type.upper()}{int(long_term)}'
            last_crossing_date, last_crossing_value, last_crossing_type = identify_last_crossing(data_df, short_label, long_label)
            if last_crossing_date:
                last_crossing[f'{short_label}_{long_label}'] = {'Date': str(last_crossing_date), 'Value': round(last_crossing_value, 2), 'Type': last_crossing_type}  # Redondear a dos decimales

        response_data['last_crossing'] = last_crossing

        # Identificar posición respecto a la MA
        position_to_ma = {}
        for period in periods:
            ma_label = f'{moving_average_type.upper()}{int(period)}'
            recommendation = identify_position_to_ma(data_df, ma_label)
            position_to_ma[ma_label] = recommendation

        response_data['position_to_ma'] = position_to_ma

        return response_data

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"An unexpected error occurred: {e}")
        return {"error": "An unexpected error occurred"}

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

def identify_position_to_ma(data_df, moving_average_label):
    last_close = data_df['Close'].iloc[-1]
    last_ma_value = data_df[moving_average_label].iloc[-1]

    if last_close > last_ma_value:
        return Recommendation.BUY
    elif last_close < last_ma_value:
        return Recommendation.SELL
    else:
        return Recommendation.NEUTRAL
