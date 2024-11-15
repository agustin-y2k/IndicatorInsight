# adx_indicator.py
import pandas as pd
import numpy as np
import logging

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate ADX"
ERROR_UNEXPECTED = "An unexpected error occurred"

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

def calculate_adx(company_data, period=14, timeframe='daily'):
    try:
        data_df = pd.DataFrame(company_data)
        data_df = resample_data(data_df, timeframe)
        
        if len(data_df) < period:
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        # Calculate True Range (TR)
        data_df['TR'] = np.maximum(
            data_df['High'] - data_df['Low'],
            np.maximum(
                abs(data_df['High'] - data_df['Close'].shift(1)),
                abs(data_df['Low'] - data_df['Close'].shift(1))
            )
        )

        # Calculate +DM and -DM
        data_df['+DM'] = np.where((data_df['High'] - data_df['High'].shift(1)) > (data_df['Low'].shift(1) - data_df['Low']),
                                data_df['High'] - data_df['High'].shift(1), 0)
        data_df['+DM'] = np.where(data_df['+DM'] < 0, 0, data_df['+DM'])
        data_df['-DM'] = np.where((data_df['Low'].shift(1) - data_df['Low']) > (data_df['High'] - data_df['High'].shift(1)),
                                data_df['Low'].shift(1) - data_df['Low'], 0)
        data_df['-DM'] = np.where(data_df['-DM'] < 0, 0, data_df['-DM'])

        # Smooth TR, +DM, -DM using exponential moving average (RMA equivalent)
        data_df['TR_smooth'] = data_df['TR'].ewm(span=period, adjust=False).mean()
        data_df['+DM_smooth'] = data_df['+DM'].ewm(span=period, adjust=False).mean()
        data_df['-DM_smooth'] = data_df['-DM'].ewm(span=period, adjust=False).mean()

        # Calculate +DI and -DI
        data_df['+DI'] = 100 * (data_df['+DM_smooth'] / data_df['TR_smooth'])
        data_df['-DI'] = 100 * (data_df['-DM_smooth'] / data_df['TR_smooth'])

        # Calculate DX
        data_df['DX'] = 100 * abs(data_df['+DI'] - data_df['-DI']) / (data_df['+DI'] + data_df['-DI'])

        # Calculate ADX using exponential moving average for smoothing DX
        data_df['ADX'] = data_df['DX'].ewm(span=period, adjust=False).mean()

        # Extract the last values
        adx_data = {
            'current_adx': round(data_df['ADX'].iloc[-1], 2),
            'current_di_plus': round(data_df['+DI'].iloc[-1], 2),
            'current_di_minus': round(data_df['-DI'].iloc[-1], 2),
            'trend_strength': determine_trend_strength(data_df['ADX'].iloc[-1], data_df['+DI'].iloc[-1], data_df['-DI'].iloc[-1]),
            'last_cross': identify_last_cross(data_df, data_df['+DI'], data_df['-DI']),
        }

        return adx_data

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_last_cross(data_df, di_plus, di_minus):
    last_cross = None
    for i in range(1, len(di_plus)):
        if di_plus.iloc[i-1] < di_minus.iloc[i-1] and di_plus.iloc[i] > di_minus.iloc[i]:
            date = data_df['Date'].iloc[i].strftime("%Y-%m-%d")
            last_cross = {'Type': 'Bullish Cross', 'Date': date}
        elif di_plus.iloc[i-1] > di_minus.iloc[i-1] and di_plus.iloc[i] < di_minus.iloc[i]:
            date = data_df['Date'].iloc[i].strftime("%Y-%m-%d")
            last_cross = {'Type': 'Bearish Cross', 'Date': date}
    return last_cross

def determine_trend_strength(adx_value, di_plus, di_minus):
    if adx_value < 25:
        return "No significant trend detected"
    elif adx_value >= 25 and adx_value < 40:
        if di_plus > di_minus:
            return "Moderate bullish trend observed"
        elif di_plus < di_minus:
            return "Moderate bearish trend observed"
        else:
            return "Sideways trend with moderate strength"
    elif adx_value >= 40 and adx_value <= 50:
        if di_plus > di_minus:
            return "Strong bullish trend detected, possible peak"
        elif di_plus < di_minus:
            return "Strong bearish trend detected, possible peak"
        else:
            return "Sideways trend with strong momentum"
    elif adx_value > 50:
        return "Very strong trend detected, near peak strength"
