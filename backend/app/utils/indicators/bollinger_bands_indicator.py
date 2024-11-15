# bollinger_bands_indicator.py
import pandas as pd
import numpy as np
import logging

ERROR_NO_DATA_FOUND = "No data found for the symbol"
ERROR_UNEXPECTED = "An unexpected error occurred"

def calculate_bollinger_bands(company_data, period=20, deviation=2, timeframe='daily'):
    try:

        data_df = pd.DataFrame(company_data)
        data_df = resample_data(data_df, timeframe)

        if len(data_df) < period:
            raise ValueError(ERROR_NO_DATA_FOUND)

        data_df['MiddleBand'] = data_df['Close'].rolling(window=period).mean()

        data_df['StdDev'] = data_df['Close'].rolling(window=period).std()

        data_df['UpperBand'] = data_df['MiddleBand'] + (data_df['StdDev'] * deviation)
        data_df['LowerBand'] = data_df['MiddleBand'] - (data_df['StdDev'] * deviation)

        last_close_price = data_df['Close'].iloc[-1]
        last_upper_band_value = round(data_df['UpperBand'].iloc[-1], 2)
        last_middle_band_value = round(data_df['MiddleBand'].iloc[-1], 2)
        last_lower_band_value = round(data_df['LowerBand'].iloc[-1], 2)
        band_width = round(last_upper_band_value - last_lower_band_value, 2)

        avg_band_width = round(data_df['UpperBand'].tail(period).mean() - data_df['LowerBand'].tail(period).mean(), 2)

        signal_data = interpret_bollinger_bands_signal(
            last_close_price,
            last_upper_band_value,
            last_middle_band_value,
            last_lower_band_value,
            band_width,
            avg_band_width,
            data_df['UpperBand'].iloc[-20:].values,
            data_df['LowerBand'].iloc[-20:].values
        )
        description = signal_data["description"]
        signal_strength = signal_data["signal"]

        return {
            'UpperBand': last_upper_band_value,
            'MiddleBand': last_middle_band_value,
            'LowerBand': last_lower_band_value,
            'BandWidth': band_width,
            'SignalStrength': signal_strength,
            'Description': description
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
        resampled_data = data_df.resample('W').agg({
            'Open': 'first',
            'High': 'max',
            'Low': 'min',
            'Close': 'last',
            'Volume': 'sum'
        })
    elif timeframe == 'monthly':
        resampled_data = data_df.resample('M').agg({
            'Open': 'first',
            'High': 'max',
            'Low': 'min',
            'Close': 'last',
            'Volume': 'sum'
        })
    else:
        resampled_data = data_df.copy()

    return resampled_data.dropna().reset_index()

def interpret_bollinger_bands_signal(close_price, upper_band, middle_band, lower_band, band_width, avg_band_width, upper_band_history, lower_band_history):
    narrow_bands = all(abs(upper - lower) < 0.1 * avg_band_width for upper, lower in zip(upper_band_history, lower_band_history))

    if close_price > upper_band:
        if band_width > avg_band_width:
            return {
                "signal": "Strong",
                "description": "The price is above the upper band, indicating a possible overbought condition with high volatility."
            }
        else:
            return {
                "signal": "Moderate",
                "description": "The price is above the upper band, which may suggest a potential overbought condition."
            }
    elif close_price < lower_band:
        if band_width > avg_band_width:
            return {
                "signal": "Strong",
                "description": "The price is below the lower band, indicating a possible oversold condition with high volatility."
            }
        else:
            return {
                "signal": "Moderate",
                "description": "The price is below the lower band, which may suggest a potential oversold condition."
            }
    elif narrow_bands:
        return {
            "signal": "Potential Breakout",
            "description": "The bands have been narrow for a prolonged period, suggesting low volatility and a potential breakout pattern."
        }
    elif close_price > middle_band:
        return {
            "signal": "Weak",
            "description": "The price is above the middle band, indicating a mild upward trend."
        }
    elif close_price < middle_band:
        return {
            "signal": "Weak",
            "description": "The price is below the middle band, indicating a mild downward trend."
        }
    else:
        return {
            "signal": "Neutral",
            "description": "The price is within the Bollinger bands, indicating typical price movement within a neutral range."
        }