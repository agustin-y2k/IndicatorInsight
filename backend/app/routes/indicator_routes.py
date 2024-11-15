# indicator_routes.py
from fastapi import APIRouter, Depends, HTTPException, Query
from utils.get_data import get_data
from utils.auth import TokenData, get_current_user
from utils.indicators.ma_indicator import calculate_moving_averages
from utils.indicators.adx_indicator import calculate_adx
from utils.indicators.rsi_indicator import calculate_rsi
from utils.indicators.macd_indicator import calculate_macd
from utils.indicators.bollinger_bands_indicator import calculate_bollinger_bands

router = APIRouter()

NO_DATA_ERROR = "No data found for the symbol"

@router.post("/moving_averages")
async def calculate_moving_averages_for_company(
    symbol: str,
    moving_average_input: dict,
    interval: str = 'daily',
    current_user: TokenData = Depends(get_current_user)
):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        
        if not symbol_data:
            raise ValueError(f"{NO_DATA_ERROR} for symbol {symbol}")
        if interval not in ['daily', 'weekly', 'monthly']:
            raise ValueError("Invalid timeframe. Please use 'daily', 'weekly', or 'monthly'.")

        sma_periods = moving_average_input.get("sma_periods", [])
        ema_periods = moving_average_input.get("ema_periods", [])
        wma_periods = moving_average_input.get("wma_periods", [])
        if not sma_periods and not ema_periods and not wma_periods:
            raise ValueError("At least one type of moving average periods (SMA, EMA, WMA) must be specified.")

        moving_averages_data = calculate_moving_averages(
            symbol_data,
            sma_periods=sma_periods,
            ema_periods=ema_periods,
            wma_periods=wma_periods,
            timeframe=interval
        )
        return moving_averages_data

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/adx")
async def calculate_adx_for_company(
    symbol: str,
    interval: str = 'daily',
    period: int = 14,
    current_user: TokenData = Depends(get_current_user)
):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
        if interval not in ['daily', 'weekly', 'monthly']:
            raise ValueError("Invalid timeframe. Please use 'daily', 'weekly', or 'monthly'.")

        adx_data = calculate_adx(symbol_data, period=period, timeframe=interval)
        if "error" in adx_data:
            raise ValueError(adx_data["error"])

        return adx_data

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail="An unexpected error occurred")

@router.post("/rsi")
async def calculate_rsi_for_company(
    symbol: str,
    interval: str = 'daily',
    period: int = 14,
    current_user: TokenData = Depends(get_current_user)
):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
        if interval not in ['daily', 'weekly', 'monthly']:
            raise ValueError("Invalid timeframe. Please use 'daily', 'weekly', or 'monthly'.")

        rsi_data = calculate_rsi(symbol_data, period=period, timeframe=interval)
        if "error" in rsi_data:
            raise ValueError(rsi_data["error"])

        return rsi_data

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail="An unexpected error occurred")

@router.post("/macd")
async def calculate_macd_for_company(
    symbol: str,
    interval: str = 'daily',
    current_user: TokenData = Depends(get_current_user)
):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
        if interval not in ['daily', 'weekly', 'monthly']:
            raise ValueError("Invalid timeframe. Please use 'daily', 'weekly', or 'monthly'.")

        macd_data = calculate_macd(symbol_data, timeframe=interval)
        if "error" in macd_data:
            raise ValueError(macd_data["error"])

        return macd_data

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail="An unexpected error occurred")

@router.post("/bollinger_bands")
async def calculate_bollinger_bands_for_company(
    symbol: str,
    interval: str = 'daily',
    period: int = 20,
    deviation: int = 2,
    current_user: TokenData = Depends(get_current_user)
):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
        if interval not in ['daily', 'weekly', 'monthly']:
            raise ValueError("Invalid timeframe. Please use 'daily', 'weekly', or 'monthly'.")

        bollinger_bands_data = calculate_bollinger_bands(symbol_data, period=period, deviation=deviation, timeframe=interval)
        if "error" in bollinger_bands_data:
            raise ValueError(bollinger_bands_data["error"])

        return bollinger_bands_data

    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail="An unexpected error occurred")