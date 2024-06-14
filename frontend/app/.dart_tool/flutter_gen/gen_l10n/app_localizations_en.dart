import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get badRequest => 'Bad Request';

  @override
  String get emailOrPasswordIncorrect => 'Email or password is incorrect';

  @override
  String get userNotFound => 'User not found';

  @override
  String get internalServerError => 'Internal Server Error';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get unauthorized => 'Unauthorized';

  @override
  String get pleaseFillAllFields => 'Please fill all fields';

  @override
  String get userAlreadyExists => 'User already exists';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get invalidPasswordFormat => 'Password must be at least 8 characters long and contain at least one digit, one uppercase letter, one lowercase letter, and one special character';

  @override
  String get userRegisteredSuccessfully => 'User registered successfully';

  @override
  String get data => 'Data';

  @override
  String get pleaseEnterSymbol => 'Please enter a symbol';

  @override
  String get pleaseEnterPeriod => 'Please enter a period';

  @override
  String failedToCalculate(Object error) {
    return 'Failed to calculate: $error';
  }

  @override
  String errorOccurred(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get indicators => 'Indicators';

  @override
  String get oscillator => 'Oscillator';

  @override
  String get movingAverages => 'Moving Averages';

  @override
  String get movingAveragesType => 'Moving Averages Type';

  @override
  String get enterPeriod => 'Period (comma separated)';

  @override
  String get stochasticOscillator => 'Stochastic Oscillator';

  @override
  String get bollingerBands => 'Bollinger Bands';

  @override
  String get parabolicSAR => 'Parabolic SAR';

  @override
  String get enterSymbol => 'Enter Symbol';

  @override
  String get getRecommendation => 'Get Recommendation';

  @override
  String get viewChart => 'View Chart';

  @override
  String get strategies => 'Strategies';

  @override
  String get help => 'Help';

  @override
  String get recommendation => 'Recommendation';

  @override
  String get trendStrength => 'Trend Strength';

  @override
  String get lastCross => 'Last Cross';

  @override
  String get reason => 'Reason';

  @override
  String get description => 'Description';

  @override
  String get buy => 'BUY';

  @override
  String get sell => 'SELL';

  @override
  String get neutral => 'NEUTRAL';

  @override
  String get strongBuy => 'STRONG BUY';

  @override
  String get strongSell => 'STRONG SELL';

  @override
  String get overbought => 'Overbought';

  @override
  String get oversold => 'Oversold';

  @override
  String get strongOversold => 'Strong Oversold';

  @override
  String get strongOverbought => 'Strong Overbought';

  @override
  String get noClearSignal => 'No clear signal';

  @override
  String get signalStrength => 'Signal Strength';

  @override
  String get strongSignal => 'Strong Signal';

  @override
  String get moderateSignal => 'Moderate Signal';

  @override
  String get weakSignal => 'Weak Signal';

  @override
  String get bullishCross => 'Bullish Cross';

  @override
  String get bearishCross => 'Bearish Cross';

  @override
  String get divergence => 'Divergence';

  @override
  String get entryExitSignal => 'Entry/Exit Signal';

  @override
  String get histogram => 'Histogram';

  @override
  String get signalLine => 'Signal Line';

  @override
  String get macdLine => 'MACD Line';

  @override
  String get bullish => 'Bullish';

  @override
  String get bearish => 'Bearish';

  @override
  String get date => 'Date';

  @override
  String get value => 'Value';

  @override
  String get type => 'Type';

  @override
  String get crossingPoints => 'Crossing Points';

  @override
  String get adxIndicatorDetails => 'ADX Indicator Details';

  @override
  String get currentADX => 'Current ADX';

  @override
  String get currentDIPlus => 'Current +DI';

  @override
  String get currentDIMinus => 'Current -DI';

  @override
  String get absenceOfClearTrend => 'Absence of clear trend';

  @override
  String get clearBullishTrend => 'Clear bullish trend';

  @override
  String get clearBearishTrend => 'Clear bearish trend';

  @override
  String get sidewaysTrend => 'Sideways trend';

  @override
  String get strongBullishTrend => 'Strong bullish trend (possible peak)';

  @override
  String get strongBearishTrend => 'Strong bearish trend (possible peak)';

  @override
  String get veryStrongTrend => 'Very strong trend (trend peak)';

  @override
  String get understandingTheIndicator => 'Understanding the indicator';

  @override
  String get understandingADXDesc => 'The ADX is a technical analysis indicator used to quantify the strength of a trend. It ranges from 0 to 100, with higher values indicating a stronger trend.';

  @override
  String get recommendationLogic => 'Recommendation Logic:';

  @override
  String get recommendationLogicDescAdx => 'The ADX value helps determine the strength of the trend:\n- Below 25: Absence of clear trend.\n- 25 to 40: Clear trend (bullish or bearish).\n- 40 to 50: Strong trend (possible peak).\n- Above 50: Very strong trend (trend peak).';

  @override
  String get recommendationTypes => 'Recommendation Types:';

  @override
  String get buyRecommendationAdx => 'BUY: ADX value is above 25 and the +DI crosses above the -DI, indicating a potential bullish trend.';

  @override
  String get sellRecommendationAdx => 'SELL: ADX value is above 25 and the +DI crosses below the -DI, indicating a potential bearish trend.';

  @override
  String get neutralRecommendationAdx => 'NEUTRAL: ADX value is below 25, indicating a weak or absent trend.';

  @override
  String get strongBuyRecommendationAdx => 'STRONG BUY: ADX value is above 50 and the +DI crosses above the -DI, indicating a very strong bullish trend.';

  @override
  String get strongSellRecommendationAdx => 'STRONG SELL: ADX value is above 50 and the +DI crosses below the -DI, indicating a very strong bearish trend.';

  @override
  String get adxDivergenceDesc => 'ADX divergence occurs when the price movement is not confirmed by the ADX indicator. For example, if the price is making new highs, but the ADX indicator is making lower highs, it may indicate a weakening trend, or potential reversal.';

  @override
  String get adxEntryExitSignalDesc => 'Some traders use specific ADX threshold levels as entry or exit signals. For example, they may enter a trade when the ADX crosses above a certain value, indicating a strong trend, and exit when it falls below another threshold, suggesting a weakening trend. These threshold levels may vary depending on the trader\'s strategy and market conditions.';

  @override
  String get understandingBollingerBandsDesc => 'Bollinger Bands are a type of statistical chart characterizing the prices and volatility over time of a financial instrument or commodity. They consist of a middle band (SMA) and two outer bands (standard deviations above and below the SMA).';

  @override
  String get bollingerBandsLevels => 'Bollinger Bands Levels';

  @override
  String get bollingerBandsLevelsDesc => 'The Bollinger Bands indicator consists of three lines: the upper band, middle band (SMA), and lower band. The position of the price relative to these bands can provide trading signals.';

  @override
  String get buyRecommendationBollinger => 'BUY: The price is below the lower band - Oversold.';

  @override
  String get strongBuyRecommendationBollinger => 'STRONG BUY: The price is below the lower band - Oversold with wide bands.';

  @override
  String get sellRecommendationBollinger => 'SELL: The price is above the upper band - Overbought.';

  @override
  String get strongSellRecommendationBollinger => 'STRONG SELL: The price is above the upper band - Overbought with wide bands.';

  @override
  String get neutralRecommendationBollinger => 'NEUTRAL: Narrow bands - Neutral or within the Bollinger bands.';

  @override
  String get upperBand => 'Upper Band';

  @override
  String get middleBand => 'Middle Band';

  @override
  String get lowerBand => 'Lower Band';

  @override
  String get bandWidth => 'Band Width';

  @override
  String get overboughtWideBands => 'Price above Upper Band - Overbought with Wide Bands';

  @override
  String get bollingerBandsOverbought => 'Price above Upper Band - Overbought';

  @override
  String get oversoldWideBands => 'Price below Lower Band - Oversold with Wide Bands';

  @override
  String get bollingerBandsOversold => 'Price below Lower Band - Oversold';

  @override
  String get narrowBandsNeutral => 'Narrow Bands - Neutral';

  @override
  String get withinBollingerBands => 'Within Bollinger Bands';

  @override
  String get bollinger_band_squeeze_title => 'Bollinger Band Squeeze';

  @override
  String get bollinger_band_squeeze_description => 'The Bollinger Band Squeeze strategy is based on the principle that periods of low volatility are often followed by periods of high volatility. When the bands squeeze together, it indicates that the volatility is low and a breakout could occur. Traders watch for a price move above or below the bands as a signal for potential entry.';

  @override
  String get bollinger_band_breakout_title => 'Bollinger Band Breakout';

  @override
  String get bollinger_band_breakout_description => 'The Bollinger Band Breakout strategy looks for price breaking out of the upper or lower bands. A breakout above the upper band can signal that the price is in a strong uptrend, while a breakout below the lower band can signal a strong downtrend. Traders often use this strategy to enter trades in the direction of the breakout.';

  @override
  String get reversion_to_mean_title => 'Reversion to the Mean';

  @override
  String get reversion_to_mean_description => 'This strategy assumes that price tends to return to the middle band (the simple moving average) after touching the upper or lower bands. When the price hits the upper band, traders might look for sell signals, anticipating that the price will revert back to the mean. Conversely, when the price hits the lower band, traders might look for buy signals.';

  @override
  String get double_bottoms_and_tops_title => 'Double Bottoms and Tops';

  @override
  String get double_bottoms_and_tops_description => 'Double bottoms and tops are reversal patterns that can be identified using Bollinger Bands. A double bottom occurs when the price makes two lows around the same level, often with a lower low touching or going below the lower band, followed by a rally. A double top occurs when the price makes two highs around the same level, often with an upper high touching or exceeding the upper band, followed by a decline.';

  @override
  String get belowMiddleBand => 'Price below Middle Band\'';

  @override
  String get aboveMiddleBand => 'Price above Middle Band';

  @override
  String get understandingMacdDesc => 'The MACD is a trend-following momentum indicator that shows the relationship between two moving averages of a security’s price. It consists of the MACD line, signal line, and histogram.';

  @override
  String get buyRecommendationMacd => 'BUY: The MACD crosses above the signal line, indicating a bullish trend.';

  @override
  String get sellRecommendationMacd => 'SELL: The MACD crosses below the signal line, indicating a bearish trend.';

  @override
  String get neutralRecommendationMacd => 'NEUTRAL: No clear signal is identified by the MACD indicator, possibly due to the proximity between the MACD and the signal line.';

  @override
  String get strongBuyRecommendationMacd => 'STRONG BUY: The MACD crosses above the signal line with an increasing histogram, indicating a strong bullish trend.';

  @override
  String get strongSellRecommendationMacd => 'STRONG SELL: The MACD crosses below the signal line with a decreasing histogram, indicating a strong bearish trend.';

  @override
  String get recommendationLogicDescMacd => 'When the MACD line crosses above the signal line, it is considered a bullish signal, indicating a potential buy opportunity. Conversely, when the MACD line crosses below the signal line, it is considered a bearish signal, indicating a potential sell opportunity.';

  @override
  String get macdLineSignalCorss => 'MACD Line and Signal Line Crossover';

  @override
  String get macdLineSignalCorssDesc => 'This strategy involves identifying buy and sell signals based on the crossover of the MACD line and the signal line. A bullish crossover occurs when the MACD line crosses above the signal line, indicating a potential buy signal. Conversely, a bearish crossover occurs when the MACD line crosses below the signal line, indicating a potential sell signal.';

  @override
  String get macdHistogram => 'MACD Histogram';

  @override
  String get macdHistogramDesc => 'In this strategy, traders look for changes in the MACD histogram. When the histogram moves from negative to positive territory, it suggests increasing bullish momentum. Conversely, when the histogram moves from positive to negative territory, it suggests increasing bearish momentum.';

  @override
  String get macdDivergencePrice => 'Divergence with Price';

  @override
  String get macdDivergencePriceDesc => 'Similar to RSI divergence, traders can use MACD divergence to identify potential trend reversals. A bullish divergence occurs when the price makes a lower low, but the MACD indicator forms a higher low. Conversely, a bearish divergence occurs when the price makes a higher high, but the MACD indicator forms a lower high.';

  @override
  String get bearishDivergence => 'Bearish Divergence';

  @override
  String get macdSignalBullish => 'MACD and signal in bullish territory';

  @override
  String get conflictingSignals => 'Conflicting signals';

  @override
  String get bullishDivergence => 'Bullish Divergence';

  @override
  String get macdSignalBearish => 'MACD and signal in bearish territory';

  @override
  String get currentParabolicSAR => 'Current Parabolic SAR';

  @override
  String get previousParabolicSAR => 'Previous Parabolic SAR';

  @override
  String get trendDirection => 'Trend Direction';

  @override
  String get upwardTrend => 'Upward Trend';

  @override
  String get downwardTrend => 'Downward Trend';

  @override
  String get noClearTrend => 'No Clear Trend';

  @override
  String get buyRecommendationParabolicSAR => 'BUY: SAR is currently below the price, indicating a potential bullish trend.';

  @override
  String get strongBuyRecommendationParabolicSAR => 'STRONG BUY: SAR is significantly below the price, indicating a strong bullish trend.';

  @override
  String get sellRecommendationParabolicSAR => 'SELL: SAR is currently above the price, indicating a potential bearish trend.';

  @override
  String get strongSellRecommendationParabolicSAR => 'STRONG SELL: SAR is significantly above the price, indicating a strong bearish trend.';

  @override
  String get neutralRecommendationParabolicSAR => 'NEUTRAL: SAR is not significantly above or below the price, suggesting a lack of clear trend direction.';

  @override
  String get understandingParabolicSARDesc => 'The Parabolic SAR (Stop and Reverse) is a technical indicator used to identify potential reversals in the price direction of an asset. It is represented by a series of dots above or below the price chart, indicating the potential direction of the trend.';

  @override
  String get recommendationLogicItem1 => 'If the current SAR value is greater than the previous SAR value and the current price is greater than the previous price, it indicates an uptrend and a possible buying opportunity.';

  @override
  String get recommendationLogicItem2 => 'If the current SAR value is lower than the previous SAR value and the current price is lower than the previous price, it indicates a bearish trend and a possible selling opportunity.';

  @override
  String get trendReversal => 'Trend Reversal';

  @override
  String get trailingStopLoss => 'Trailing Stop Loss';

  @override
  String get trendFollowing => 'Trend Following';

  @override
  String get trendReversalDescription => 'This strategy involves identifying potential trend reversals based on the movement of the Parabolic SAR indicator. A reversal from above the price to below the price suggests a potential bullish trend reversal, while a reversal from below the price to above the price suggests a potential bearish trend reversal.';

  @override
  String get trailingStopLossDescription => 'In this strategy, traders use the Parabolic SAR as a trailing stop loss mechanism. As the price moves in favor of the trade, the Parabolic SAR moves closer to the price, acting as a dynamic stop loss level. If the price reverses and the Parabolic SAR crosses the price, it triggers a stop loss.';

  @override
  String get trendFollowingDescription => 'Traders can use the Parabolic SAR to follow the trend by entering positions in the direction of the SAR. In an uptrend, traders look for buy signals when the SAR moves below the price, indicating bullish momentum. In a downtrend, traders look for sell signals when the SAR moves above the price, indicating bearish momentum.';

  @override
  String get understandingRSIDesc => 'The Relative Strength Index (RSI) is a momentum oscillator that measures the speed and change of price movements. It is primarily used to identify overbought or oversold conditions in a market.';

  @override
  String get buyRecommendationRSI => 'BUY: RSI < 30 and starts to rise, indicating an oversold condition and a potential buying opportunity.';

  @override
  String get strongBuyRecommendationRSI => 'STRONG BUY: RSI < 20 and starts to rise, indicating a very oversold condition and a strong buying opportunity.';

  @override
  String get sellRecommendationRSI => 'SELL: RSI > 70 and starts to fall, indicating an overbought condition and a potential selling opportunity.';

  @override
  String get strongSellRecommendationRSI => 'STRONG SELL: RSI > 80 and starts to fall, indicating a very overbought condition and a strong selling opportunity.';

  @override
  String get neutralRecommendationRSI => 'NEUTRAL: RSI between 30 and 70, indicating no clear overbought or oversold conditions.';

  @override
  String get overboughtOversoldLevels => 'Overbought/Oversold Levels';

  @override
  String get overboughtOversoldLevelsRSIDesc => 'This strategy involves identifying overbought and oversold conditions using the RSI indicator. When the RSI value exceeds 70, it\'s considered overbought, indicating a potential sell signal. Conversely, when the RSI value drops below 30, it\'s considered oversold, indicating a potential buy signal.';

  @override
  String get divergenceRSIDesc => 'In this strategy, traders look for divergences between the price and the RSI indicator. A bullish divergence occurs when the price makes a lower low, but the RSI indicator forms a higher low, suggesting potential upward momentum. Conversely, a bearish divergence occurs when the price makes a higher high, but the RSI indicator forms a lower high, suggesting potential downward momentum.';

  @override
  String get trendConfirmation => 'Trend Confirmation';

  @override
  String get trengConfirmationRSIDesc => 'This strategy involves using the RSI indicator to confirm trends identified by other indicators or price action. When the RSI value confirms a bullish trend by staying above a certain threshold (e.g., 50), it reinforces the bullish bias. Similarly, when the RSI value confirms a bearish trend by staying below a certain threshold, it reinforces the bearish bias.';

  @override
  String get understandingStochasticDesc => 'The Stochastic Oscillator is a momentum indicator that compares a particular closing price of a security to a range of its prices over a certain period of time. It oscillates between 0 and 100 and is used to identify potential overbought or oversold conditions in a market.';

  @override
  String get buyRecommendationStochastic => 'BUY: The stochastic indicator suggests a potential buying opportunity when SlowK and SlowD are low (below 20) and SlowK crosses above SlowD.';

  @override
  String get strongBuyRecommendationStochastic => 'STRONG BUY: The stochastic indicator shows a strong buying signal when SlowK and SlowD are very low (below 10) and SlowK crosses above SlowD.';

  @override
  String get sellRecommendationStochastic => 'SELL: The stochastic indicator suggests a potential selling opportunity when SlowK and SlowD are high (above 80) and SlowK crosses below SlowD.';

  @override
  String get strongSellRecommendationStochastic => 'STRONG SELL: The stochastic indicator shows a strong selling signal when SlowK and SlowD are very high (above 90) and SlowK crosses below SlowD.';

  @override
  String get neutralRecommendationStochastic => 'NEUTRAL: The stochastic indicator indicates a neutral condition when SlowK and SlowD are between 20 and 80, suggesting that there is no clear signal of overbought or oversold.';

  @override
  String get overboughtOversoldLevelsStochasticDesc => 'This strategy involves identifying overbought and oversold conditions using the stochastic oscillator. When the %K line crosses above 80, it indicates overbought conditions and suggests a potential sell signal. Conversely, when the %K line crosses below 20, it indicates oversold conditions and suggests a potential buy signal.';

  @override
  String get divergenceStochasticDesc => 'In this strategy, traders look for divergences between the price and the stochastic oscillator. A bullish divergence occurs when the price makes a lower low, but the stochastic oscillator forms a higher low, suggesting potential upward momentum. Conversely, a bearish divergence occurs when the price makes a higher high, but the stochastic oscillator forms a lower high, suggesting potential downward momentum.';

  @override
  String get trendConfirmationStochasticDesc => 'This strategy involves using the stochastic oscillator to confirm trends identified by other indicators or price action. When the %K line confirms a bullish trend by staying above a certain threshold (e.g., 50), it reinforces the bullish bias. Similarly, when the %K line confirms a bearish trend by staying below a certain threshold, it reinforces the bearish bias.';

  @override
  String get understandingWilliamsRDesc => 'The Williams %R (%R) indicator is a momentum oscillator that measures overbought or oversold levels. It oscillates between -100 and 0, where values above -20 are considered overbought and values below -80 are considered oversold.';

  @override
  String get buyRecommendationWilliamsR => 'BUY: Williams %R is between -80 and -50, indicating an oversold condition and a potential buying opportunity.';

  @override
  String get strongBuyRecommendationWilliamsR => 'STRONG BUY: Williams %R is below -80, indicating a very oversold condition and a strong buying opportunity.';

  @override
  String get sellRecommendationWilliamsR => 'SELL: Williams %R is between -20 and -50, indicating an overbought condition and a potential selling opportunity.';

  @override
  String get strongSellRecommendationWilliamsR => 'STRONG SELL: Williams %R is above -20, indicating a very overbought condition and a strong selling opportunity.';

  @override
  String get neutralRecommendationWilliamsR => 'NEUTRAL: Williams %R doesn\'t present a clear signal of overbought or oversold conditions, suggesting a neutral condition.';

  @override
  String get overboughtOversoldLevelsWRDesc => 'This strategy involves identifying overbought and oversold conditions using the Williams %R indicator. When the Williams %R value exceeds -20, it\'s considered overbought, indicating a potential sell signal. Conversely, when the Williams %R value drops below -80, it\'s considered oversold, indicating a potential buy signal.';

  @override
  String get divergenceWRDesc => 'In this strategy, traders look for divergences between the price and the Williams %R indicator. A bullish divergence occurs when the price makes a lower low, but the Williams %R indicator forms a higher low, suggesting potential upward momentum. Conversely, a bearish divergence occurs when the price makes a higher high, but the Williams %R indicator forms a lower high, suggesting potential downward momentum.';

  @override
  String get trengConfirmationWRDesc => 'This strategy involves using the Williams %R indicator to confirm trends identified by other indicators or price action. When the Williams %R value confirms a bullish trend by staying above a certain threshold (e.g., -50), it reinforces the bullish bias. Similarly, when the Williams %R value confirms a bearish trend by staying below a certain threshold, it reinforces the bearish bias.';

  @override
  String get movingAveragesCrossover => 'Moving Averages Crossover';

  @override
  String get movingAveragesCrossoverDesc => 'This strategy involves using two moving averages with different time periods. When the shorter moving average crosses above the longer one, it\'s considered a buy signal, indicating a possible uptrend. Conversely, when the shorter moving average crosses below the longer one, it\'s considered a sell signal, indicating a possible downtrend.';

  @override
  String get movingAveragesSupportResistance => 'Moving Averages as Support and Resistance';

  @override
  String get movingAveragesSupportResistanceDesc => 'In this strategy, a single moving average is used as a dynamic support or resistance level. When the price approaches the moving average from above, it may act as resistance, and when the price approaches from below, it may act as support. Traders may look for buying opportunities when the price bounces off the moving average from below and selling opportunities when the price bounces from above.';

  @override
  String get movingAveragesReversalSignal => 'Moving Averages Reversal Signal';

  @override
  String get movingAveragesReversalSignalDesc => 'Some traders use moving averages to identify potential reversal points in the market. For example, when the price significantly deviates from a particular moving average, it may indicate that the current trend is overextended and a reversal is likely. Traders may look for reversal signals when the price approaches the moving average again.';

  @override
  String get simpleMovingAverage => 'Simple Moving Average (SMA)';

  @override
  String get simpleMovingAverageDesc => 'The SMA is calculated by averaging the closing prices over a specified period. It smooths out price data to identify trends over a longer duration.';

  @override
  String get exponentialMovingAverage => 'Exponential Moving Average (EMA)';

  @override
  String get exponentialMovingAverageDesc => 'The EMA gives more weight to recent prices, making it more responsive to new information. It is useful for identifying short-term trends.';

  @override
  String get weightedMovingAverage => 'Weighted Moving Average (WMA)';

  @override
  String get weightedMovingAverageDesc => 'The WMA assigns different weights to each closing price within the given period, giving more importance to recent data points.';

  @override
  String get buyRecommendationMovingAverages => 'BUY: If the last closing price is above the last moving average value.';

  @override
  String get strongBuyRecommendationMovingAverages => 'STRONG BUY: If the last closing price is more than 5% above the last moving average value.';

  @override
  String get sellRecommendationMovingAverages => 'SELL: If the last closing price is below the last moving average value.';

  @override
  String get strongSellRecommendationMovingAverages => 'STRONG SELL: If the last closing price is more than 5% below the last moving average value.';

  @override
  String get neutralRecommendationMovingAverages => 'NEUTRAL: If the last closing price is equal to the last moving average value.';

  @override
  String get goldenCross => 'Golden Cross';

  @override
  String get goldenCrossDesc => 'Golden Cross: Indicates a potential buy signal when the short-term moving average crosses above the long-term moving average.';

  @override
  String get deathCross => 'Death Cross';

  @override
  String get deathCrossDesc => 'Death Cross: Indicates a potential sell signal when the short-term moving average crosses below the long-term moving average.';
}
