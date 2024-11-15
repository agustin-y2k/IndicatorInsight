# ma_indicator.py
import pandas as pd
import logging
from collections import OrderedDict
<<<<<<< HEAD
from models.recommendation import Recommendation
=======
>>>>>>> develop

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_moving_averages(company_data, sma_periods=None, ema_periods=None, wma_periods=None, timeframe='daily'):
    try:
        data_df = pd.DataFrame(company_data)
        data_df['Date'] = pd.to_datetime(data_df['Date'])  # Convertir a fecha completa

        # Resample data based on timeframe
        data_df = resample_data(data_df, timeframe)

        # Check if there is enough data for the longest period requested
        if len(data_df) < max(max(sma_periods or [0]), max(ema_periods or [0]), max(wma_periods or [0])):
            raise ValueError(ERROR_NO_DATA_FOUND)

        moving_averages = OrderedDict()
        last_crossings = OrderedDict()

        if sma_periods:
            sma_periods = sorted(sma_periods)
            for period in sma_periods:
                ma_label = f'SMA{int(period)}'
                data_df[ma_label] = data_df['Close'].rolling(window=period).mean()
                last_ma_value = round(data_df[ma_label].iloc[-1], 2)
                moving_averages[ma_label] = last_ma_value

            for short_term, long_term in zip(sma_periods[:-1], sma_periods[1:]):
                short_label = f'SMA{int(short_term)}'
                long_label = f'SMA{int(long_term)}'
                last_crossing_date, last_crossing_value, last_crossing_type = identify_last_crossing(data_df, short_label, long_label)
                if last_crossing_date:
                    last_crossings[f'{short_label}-{long_label}'] = {
                        'Date': str(last_crossing_date),
                        'Value': round(last_crossing_value, 2),
                        'Type': last_crossing_type
                    }

        if ema_periods:
            ema_periods = sorted(ema_periods)
            for period in ema_periods:
                ma_label = f'EMA{int(period)}'
                data_df[ma_label] = data_df['Close'].ewm(span=period, adjust=False).mean()
                last_ma_value = round(data_df[ma_label].iloc[-1], 2)
                moving_averages[ma_label] = last_ma_value

            for short_term, long_term in zip(ema_periods[:-1], ema_periods[1:]):
                short_label = f'EMA{int(short_term)}'
                long_label = f'EMA{int(long_term)}'
                last_crossing_date, last_crossing_value, last_crossing_type = identify_last_crossing(data_df, short_label, long_label)
                if last_crossing_date:
                    last_crossings[f'{short_label}-{long_label}'] = {
                        'Date': str(last_crossing_date),
                        'Value': round(last_crossing_value, 2),
                        'Type': last_crossing_type
                    }

        if wma_periods:
            wma_periods = sorted(wma_periods)
            for period in wma_periods:
                ma_label = f'WMA{int(period)}'
                data_df[ma_label] = calculate_wma(data_df['Close'], period)
                last_ma_value = round(data_df[ma_label].iloc[-1], 2)
                moving_averages[ma_label] = last_ma_value

            for short_term, long_term in zip(wma_periods[:-1], wma_periods[1:]):
                short_label = f'WMA{int(short_term)}'
                long_label = f'WMA{int(long_term)}'
                last_crossing_date, last_crossing_value, last_crossing_type = identify_last_crossing(data_df, short_label, long_label)
                if last_crossing_date:
                    last_crossings[f'{short_label}-{long_label}'] = {
                        'Date': str(last_crossing_date),
                        'Value': round(last_crossing_value, 2),
                        'Type': last_crossing_type
                    }

        return {
            'moving_averages': dict(moving_averages),
            'last_crossings': dict(last_crossings)
        }

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def calculate_wma(close_prices, period):
    weights = range(1, period + 1)
    wma = close_prices.rolling(window=period).apply(lambda prices: sum(weights * prices) / sum(weights), raw=True)
    return wma

def identify_last_crossing(data_df, short_term, long_term):
    last_crossing_date = None
    last_crossing_value = None
    last_crossing_type = None

    for i in range(1, len(data_df)):

        if data_df[short_term].iloc[i - 1] < data_df[long_term].iloc[i - 1] and data_df[short_term].iloc[i] > data_df[long_term].iloc[i]:
            last_crossing_date = data_df['Date'].iloc[i]
            last_crossing_value = data_df[short_term].iloc[i]
            last_crossing_type = 'Golden Cross'

        elif data_df[short_term].iloc[i - 1] > data_df[long_term].iloc[i - 1] and data_df[short_term].iloc[i] < data_df[long_term].iloc[i]:
            last_crossing_date = data_df['Date'].iloc[i]
            last_crossing_value = data_df[short_term].iloc[i]
            last_crossing_type = 'Death Cross'

    return last_crossing_date, last_crossing_value, last_crossing_type

def resample_data(data_df, timeframe='daily'):
    data_df['Date'] = pd.to_datetime(data_df['Date'])
    data_df.set_index('Date', inplace=True)

    if timeframe == 'weekly':
        return data_df.resample('W').agg({
            'Open': 'first',
            'High': 'max',
            'Low': 'min',
            'Close': 'last',
            'Volume': 'sum'
        }).dropna().reset_index()
    elif timeframe == 'monthly':
        return data_df.resample('M').agg({
            'Open': 'first',
            'High': 'max',
            'Low': 'min',
            'Close': 'last',
            'Volume': 'sum'
        }).dropna().reset_index()
    else:  # daily
        return data_df.reset_index()
