# bollinger_bands_indicator.py
import talib
import pandas as pd
import logging
from .recommendation import Recommendation

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_INVALID_DATA_FORMAT = "Invalid data format"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_bollinger_bands(company_data, period, deviation):
    try:
        data_df = pd.DataFrame(company_data)
        data_df['Date'] = pd.to_datetime(data_df['Date'])

        upper_band_label = f'BB_UPPER_{period}_{deviation}'
        middle_band_label = f'BB_MIDDLE_{period}'
        lower_band_label = f'BB_LOWER_{period}_{deviation}'

        upper_band, middle_band, lower_band = talib.BBANDS(data_df['Close'], timeperiod=period, nbdevup=deviation, nbdevdn=deviation, matype=0)

        data_df[upper_band_label] = upper_band
        data_df[middle_band_label] = middle_band
        data_df[lower_band_label] = lower_band

        last_upper_band_value = round(data_df[upper_band_label].iloc[-1], 2)
        last_lower_band_value = round(data_df[lower_band_label].iloc[-1], 2)
        band_width = round(last_upper_band_value - last_lower_band_value, 2)

        signal_data = identify_bollinger_bands_signal(data_df['Close'].iloc[-1], last_upper_band_value, last_lower_band_value, band_width)
        recommendation = signal_data["recommendation"]
        signal_strength = signal_data["signal"]

        return {
            'UpperBand': last_upper_band_value,
            'MiddleBand': round(data_df[middle_band_label].iloc[-1], 2),
            'LowerBand': last_lower_band_value,
            'BandWidth': band_width,
            'Recommendation': recommendation,
            'SignalStrength': signal_strength
        }

    except ValueError as e:
        logging.warning(str(e))
        return {"error": str(e)}
    except Exception as e:
        logging.exception(f"{ERROR_UNEXPECTED}: {e}")
        return {"error": ERROR_UNEXPECTED}

def identify_bollinger_bands_signal(close_price, upper_band, lower_band, band_width):
    if close_price > upper_band:
        if band_width > 2:
            return {
                "recommendation": Recommendation.SELL,
                "signal": {"description": "Price above Upper Band - Overbought with Wide Bands", "strength": "Strong"}
            }
        else:
            return {
                "recommendation": Recommendation.SELL,
                "signal": {"description": "Price above Upper Band - Overbought", "strength": "Moderate"}
            }
    elif close_price < lower_band:
        if band_width > 2:
            return {
                "recommendation": Recommendation.BUY,
                "signal": {"description": "Price below Lower Band - Oversold with Wide Bands", "strength": "Strong"}
            }
        else:
            return {
                "recommendation": Recommendation.BUY,
                "signal": {"description": "Price below Lower Band - Oversold", "strength": "Moderate"}
            }
    elif band_width < 0.1:
        return {
            "recommendation": Recommendation.NEUTRAL,
            "signal": {"description": "Narrow Bands - Neutral", "strength": "Weak"}
        }
    else:
        return {
            "recommendation": Recommendation.NEUTRAL,
            "signal": {"description": "Within Bollinger Bands - Neutral", "strength": "Weak"}
        }