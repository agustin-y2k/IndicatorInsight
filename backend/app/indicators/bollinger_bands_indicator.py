# bollinger_bands_indicator.py
import talib
import pandas as pd
import logging
from .fetch_data import fetch_company_data

class BollingerBandsRecommendation:
    BUY = "BUY"
    SELL = "SELL"
    NEUTRAL = "NEUTRAL"

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_bollinger_bands(symbol, period=20, deviation=2):
    try:
        data = fetch_company_data(symbol)
        if data is None:
            raise ValueError(ERROR_NO_DATA_FOUND)

        if not isinstance(data, list):
            raise ValueError(ERROR_INVALID_DATA_FORMAT)

        data_df = pd.DataFrame(data)
        data_df['Date'] = pd.to_datetime(data_df['Date'])

        upper_band_label = f'BB_UPPER_{period}_{deviation}'
        middle_band_label = f'BB_MIDDLE_{period}'
        lower_band_label = f'BB_LOWER_{period}_{deviation}'

        upper_band, middle_band, lower_band = talib.BBANDS(data_df['Close'], timeperiod=period, nbdevup=deviation, nbdevdn=deviation, matype=0)

        data_df[upper_band_label] = upper_band
        data_df[middle_band_label] = middle_band
        data_df[lower_band_label] = lower_band

        last_upper_band_value = round(data_df[upper_band_label].iloc[-1], 2)
        last_middle_band_value = round(data_df[middle_band_label].iloc[-1], 2)
        last_lower_band_value = round(data_df[lower_band_label].iloc[-1], 2)

        recommendation = identify_bollinger_bands_signal(data_df['Close'].iloc[-1], last_upper_band_value, last_lower_band_value)

        return {
            'UpperBand': last_upper_band_value,
            'MiddleBand': last_middle_band_value,
            'LowerBand': last_lower_band_value,
            'Recommendation': recommendation
        }

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_bollinger_bands_signal(close_price, upper_band, lower_band):
    if close_price > upper_band:
        return BollingerBandsRecommendation.SELL, "Price above Upper Band"
    elif close_price < lower_band:
        return BollingerBandsRecommendation.BUY, "Price below Lower Band"
    else:
        return BollingerBandsRecommendation.NEUTRAL, "Within Bollinger Bands"
