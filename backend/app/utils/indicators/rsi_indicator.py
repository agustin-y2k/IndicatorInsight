# rsi_indicator.py
import pandas as pd
import numpy as np
import logging

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_rsi(company_data, period=14, timeframe='daily'):
    try:
        data_df = pd.DataFrame(company_data)
        data_df = resample_data(data_df, timeframe)
        
        if len(data_df) < period:
            raise ValueError(ERROR_NO_DATA_FOUND)

        # Calculate RSI using Wilder's EMA method on closing prices
        data_df['Change'] = data_df['Close'].diff()
        data_df['Gain'] = np.where(data_df['Change'] > 0, data_df['Change'], 0)
        data_df['Loss'] = np.where(data_df['Change'] < 0, -data_df['Change'], 0)

        avg_gain = data_df['Gain'].rolling(window=period, min_periods=period).mean()
        avg_loss = data_df['Loss'].rolling(window=period, min_periods=period).mean()

        for i in range(period, len(data_df)):
            avg_gain.iloc[i] = (avg_gain.iloc[i - 1] * (period - 1) + data_df['Gain'].iloc[i]) / period
            avg_loss.iloc[i] = (avg_loss.iloc[i - 1] * (period - 1) + data_df['Loss'].iloc[i]) / period

        data_df['RS'] = avg_gain / avg_loss
        data_df['RSI'] = 100 - (100 / (1 + data_df['RS']))

        # Calculate SMA of RSI (optional for analysis but not returned)
        data_df['RSI_SMA'] = data_df['RSI'].rolling(window=period).mean()

        last_rsi_value = round(data_df['RSI'].iloc[-1], 2)
        last_rsi_sma = round(data_df['RSI_SMA'].iloc[-1], 2)

        interpretation = interpret_rsi(last_rsi_value, data_df)

        return {
            'RSI': last_rsi_value,
            'RSI_SMA': last_rsi_sma,
            'Interpretation': interpretation
        }

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

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

def interpret_rsi(rsi_value, data_df):
    interpretation = {}

    # 1. Overbought and Oversold
    if rsi_value >= 70:
        interpretation['Condition'] = "Overbought"
    elif rsi_value <= 30:
        interpretation['Condition'] = "Oversold"
    else:
        interpretation['Condition'] = "Neutral"

    # 2. Trend Analysis (Above or Below 50)
    if rsi_value > 50:
        interpretation['Trend'] = "Bullish Trend"
    elif rsi_value < 50:
        interpretation['Trend'] = "Bearish Trend"
    else:
        interpretation['Trend'] = "Neutral"

    # 3. Divergence Detection
    if len(data_df) >= 2:
        last_price = data_df['Close'].iloc[-1]
        previous_price = data_df['Close'].iloc[-2]
        last_rsi = data_df['RSI'].iloc[-1]
        previous_rsi = data_df['RSI'].iloc[-2]

        if (last_price > previous_price and last_rsi < previous_rsi):
            interpretation['Divergence'] = "Bearish Divergence"
        elif (last_price < previous_price and last_rsi > previous_rsi):
            interpretation['Divergence'] = "Bullish Divergence"
        else:
            interpretation['Divergence'] = "No Clear Divergence"

    return interpretation
