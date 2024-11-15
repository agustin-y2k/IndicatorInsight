# indicator_routes.py
<<<<<<< HEAD
from fastapi import APIRouter, Depends, HTTPException
=======
from fastapi import APIRouter, Depends, HTTPException, Query
>>>>>>> develop
from utils.get_data import get_data
from utils.auth import TokenData, get_current_user
from utils.indicators.ma_indicator import calculate_moving_averages
from utils.indicators.adx_indicator import calculate_adx
from utils.indicators.rsi_indicator import calculate_rsi
from utils.indicators.macd_indicator import calculate_macd
<<<<<<< HEAD
from utils.indicators.stochastic_indicator import calculate_stochastic
from utils.indicators.willims_r_indicator import calculate_williams_r
from utils.indicators.bollinger_bands_indicator import calculate_bollinger_bands
from utils.indicators.parabolic_sar_indicator import calculate_parabolic_sar

=======
from utils.indicators.bollinger_bands_indicator import calculate_bollinger_bands
>>>>>>> develop

router = APIRouter()

NO_DATA_ERROR = "No data found for the symbol"

@router.post("/moving_averages")
<<<<<<< HEAD
async def calculate_moving_averages_for_company(symbol: str, moving_average_input: dict, current_user: TokenData = Depends(get_current_user)):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        moving_average_type = moving_average_input.get("moving_average_type")
        periods = moving_average_input.get("periods", [])
        if not moving_average_type:
            raise ValueError("Moving average type is required in the request body")
        moving_averages_data = calculate_moving_averages(symbol_data, moving_average_type, periods)
        return moving_averages_data
=======
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
>>>>>>> develop
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/adx")
<<<<<<< HEAD
async def calculate_adx_for_company(symbol: str, current_user: TokenData = Depends(get_current_user)):
=======
async def calculate_adx_for_company(
    symbol: str,
    interval: str = 'daily',
    period: int = 14,
    current_user: TokenData = Depends(get_current_user)
):
>>>>>>> develop
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
<<<<<<< HEAD

        adx_data = calculate_adx(symbol_data)
        return adx_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/rsi")
async def calculate_rsi_for_company(symbol: str, current_user: TokenData = Depends(get_current_user)):
=======
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
>>>>>>> develop
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
<<<<<<< HEAD

        rsi_data = calculate_rsi(symbol_data)
        return rsi_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/macd")
async def calculate_macd_for_company(symbol: str, current_user: TokenData = Depends(get_current_user)):
=======
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
>>>>>>> develop
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
<<<<<<< HEAD

        macd_data = calculate_macd(symbol_data)
        return macd_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/stochastic")
async def calculate_stochastic_for_company(symbol: str, current_user: TokenData = Depends(get_current_user)):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        stochastic_data = calculate_stochastic(symbol_data)
        return stochastic_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/williams_r")
async def calculate_williams_r_for_company(symbol: str, current_user: TokenData = Depends(get_current_user)):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        williams_r_data = calculate_williams_r(symbol_data)
        return williams_r_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/bollinger_bands")
async def calculate_bollinger_bands_for_company(symbol: str, current_user: TokenData = Depends(get_current_user)):
=======
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
>>>>>>> develop
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)
<<<<<<< HEAD

        bollinger_bands_data = calculate_bollinger_bands(symbol_data)
        return bollinger_bands_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/parabolic_sar")
async def calculate_parabolic_sar_for_company(symbol: str, current_user: TokenData = Depends(get_current_user)):
    try:
        symbol = symbol.upper()
        symbol_data = get_data(symbol)
        if not symbol_data:
            raise ValueError(NO_DATA_ERROR)

        parabolic_sar_data = calculate_parabolic_sar(symbol_data)
        return parabolic_sar_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
=======
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
>>>>>>> develop
