# macd_indicator.py
import pandas as pd
import logging
<<<<<<< HEAD
from models.recommendation import Recommendation
=======
>>>>>>> develop

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate MACD"
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

def calculate_macd(company_data, timeframe='daily'):
    try:
        data_df = pd.DataFrame(company_data)
        data_df = resample_data(data_df, timeframe)
        
        if len(data_df) < max(12, 26, 9):
            raise ValueError(ERROR_INSUFFICIENT_DATA)
        
        # Calculate MACD line (difference between 12-day and 26-day EMA)
        data_df['EMA_12'] = data_df['Close'].ewm(span=12, adjust=False).mean()
        data_df['EMA_26'] = data_df['Close'].ewm(span=26, adjust=False).mean()
        data_df['MACD_Line'] = data_df['EMA_12'] - data_df['EMA_26']
        
        # Calculate Signal line (9-day EMA of MACD line)
        data_df['Signal_Line'] = data_df['MACD_Line'].ewm(span=9, adjust=False).mean()
        
        # Calculate Histogram (difference between MACD line and Signal line)
        data_df['Histogram'] = data_df['MACD_Line'] - data_df['Signal_Line']
        
        # Get the latest values
        macd_line = round(data_df['MACD_Line'].iloc[-1], 2)
        signal_line = round(data_df['Signal_Line'].iloc[-1], 2)
        histogram = round(data_df['Histogram'].iloc[-1], 2)
        
        # MACD trend analysis
        trend_analysis = macd_trend_analysis(data_df['MACD_Line'], data_df['Signal_Line'])
        
        # Divergence analysis
        divergence = detect_divergence(data_df['MACD_Line'], data_df['Close'])
        
        # Histogram analysis
        histogram_analysis = histogram_movement(data_df['Histogram'])

        return {
            'macd_line': macd_line,
            'signal_line': signal_line,
            'histogram': histogram,
            'trend_analysis': trend_analysis,
            'divergence': divergence,
            'histogram_analysis': histogram_analysis
        }
    
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def macd_trend_analysis(macd_line, signal_line):
    if macd_line.iloc[-1] > signal_line.iloc[-1]:
        return "Bullish - MACD line is above the Signal line"
    elif macd_line.iloc[-1] < signal_line.iloc[-1]:
        return "Bearish - MACD line is below the Signal line"
    else:
        return "Neutral - MACD line is equal to the Signal line"

def detect_divergence(macd_line, close_prices):
    if macd_line.iloc[-1] > macd_line.iloc[-2] and close_prices.iloc[-1] < close_prices.iloc[-2]:
        return "Bearish Divergence - MACD rising while price is falling"
    elif macd_line.iloc[-1] < macd_line.iloc[-2] and close_prices.iloc[-1] > close_prices.iloc[-2]:
        return "Bullish Divergence - MACD falling while price is rising"
    else:
        return "No significant divergence detected"

def histogram_movement(histogram):
    if histogram.iloc[-1] > histogram.iloc[-2]:
        return "Histogram expanding - trend strengthening"
    elif histogram.iloc[-1] < histogram.iloc[-2]:
        return "Histogram contracting - trend weakening"
    else:
        return "Histogram stable - steady trend"