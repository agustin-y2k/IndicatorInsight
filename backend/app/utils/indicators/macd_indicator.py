# macd_indicator.py
import talib
import pandas as pd
import logging
from ..fetch_data import fetch_company_data

class Recommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INSUFFICIENT_DATA = "Insufficient data to calculate MACD"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_macd(company_data, fast_period, slow_period, signal_period):
    try:
        
        data_df = pd.DataFrame(company_data)

        if len(data_df) < max(fast_period, slow_period, signal_period):
            raise ValueError(ERROR_INSUFFICIENT_DATA)

        macd, signal, _ = talib.MACD(data_df['Close'], fastperiod=fast_period, slowperiod=slow_period, signalperiod=signal_period)

        macd_data = {
            'macd_line': round(macd.iloc[-1], 2),
            'signal_line': round(signal.iloc[-1], 2),
            'histogram': round(macd.iloc[-1] - signal.iloc[-1], 2),
            'recommendation': macd_recommendation(macd, signal, data_df['Close'])
        }

        return macd_data
    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def macd_recommendation(macd, signal, close_prices):
    if macd.iloc[-1] > signal.iloc[-1]:
        if close_prices.iloc[-1] < close_prices.iloc[-2]:
            return Recommendation.SELL, "Bearish Divergence"
        elif macd.iloc[-1] > 0 and signal.iloc[-1] > 0:
            return Recommendation.BUY, "MACD and signal in bullish territory"
        else:
            return Recommendation.NEUTRAL, "Conflicting signals"
    elif macd.iloc[-1] < signal.iloc[-1]:
        if close_prices.iloc[-1] > close_prices.iloc[-2]:
            return Recommendation.BUY, "Bullish Divergence"
        elif macd.iloc[-1] < 0 and signal.iloc[-1] < 0:
            return Recommendation.SELL, "MACD and signal in bearish territory"
        else:
            return Recommendation.NEUTRAL, "Conflicting signals"
    else:
        return Recommendation.NEUTRAL, "Neutral"

def macd_trend(macd, signal):
    if macd.iloc[-1] > signal.iloc[-1]:
        return "Bullish"
    elif macd.iloc[-1] < signal.iloc[-1]:
        return "Bearish"
    else:
        return "Neutral"