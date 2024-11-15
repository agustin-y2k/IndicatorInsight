import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get analysis => 'Analysis';

  @override
  String get help => 'Help';

  @override
  String get indicators => 'Indicators';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get pleaseFillAllFields => 'Please fill all fields';

  @override
  String get userRegisteredSuccessfully => 'User registered successfully';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get invalidPasswordFormat => 'Password must be at least 8 characters long and contain at least one digit, one uppercase letter, one lowercase letter, and one special character';

  @override
  String get unknownError => 'An unknown error occurred';

  @override
  String get userAlreadyExists => 'User already exists';

  @override
  String get internalServerError => 'Internal server error';

  @override
  String get badRequest => 'Bad request';

  @override
  String get emailOrPasswordIncorrect => 'Email or password incorrect';

  @override
  String get userNotFound => 'User not found';

  @override
  String get noAccountRegister => 'Don\'t have an account? Register';

  @override
  String get alreadyHaveAccountLogin => 'Already have an account? Login';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get resetLinkSent => 'A reset link has been sent to your email';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get passwordResetFailed => 'Password reset failed';

  @override
  String get passwordResetSuccess => 'Password reset successful';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get enterResetCode => 'Enter the reset code sent to your email';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get invalidResetCode => 'Invalid reset code';

  @override
  String get sendResetCode => 'Send Reset Code';

  @override
  String get enterSymbol => 'Enter Symbol';

  @override
  String get selectInterval => 'Select Interval';

  @override
  String get intervalDaily => 'Daily';

  @override
  String get intervalWeekly => 'Weekly';

  @override
  String get intervalMonthly => 'Monthly';

  @override
  String get viewAnalysis => 'View Analysis';

  @override
  String get viewChart => 'View Chart';

  @override
  String get pleaseEnterSymbol => 'Please enter a symbol';

  @override
  String failedToCalculate(Object reason) {
    return 'Failed to calculate. $reason';
  }

  @override
  String errorOccurred(Object errorMessage) {
    return 'An error occurred: $errorMessage';
  }

  @override
  String get adx => 'ADX';

  @override
  String get values => 'Valores';

  @override
  String get enterADXPeriodWithDefault => 'Enter ADX Period (Default is 14)';

  @override
  String get trendStrength => 'Trend Strength';

  @override
  String get lastCross => 'Last Cross';

  @override
  String get currentADX => 'Current ADX';

  @override
  String get currentDIPlus => 'Current +DI';

  @override
  String get currentDIMinus => 'Current -DI';

  @override
  String get noSignificantTrend => 'No significant trend detected';

  @override
  String get moderateBullishTrend => 'Moderate bullish trend observed';

  @override
  String get moderateBearishTrend => 'Moderate bearish trend observed';

  @override
  String get sidewaysModerate => 'Sideways trend with moderate strength';

  @override
  String get strongBullishPeak => 'Strong bullish trend detected, possible peak';

  @override
  String get strongBearishPeak => 'Strong bearish trend detected, possible peak';

  @override
  String get veryStrongTrendNearPeak => 'Very strong trend detected, near peak strength';

  @override
  String get bullishCross => 'Bullish Cross';

  @override
  String get bearishCross => 'Bearish Cross';

  @override
  String get adxExplanation => 'ADX Explanation';

  @override
  String get adxExplanationDesc => 'The ADX (Average Directional Index) is a technical indicator used to quantify trend strength.';

  @override
  String get crossTypes => 'Cross Types';

  @override
  String get bollingerBands => 'Bollinger Bands';

  @override
  String get enterBBPeriodWithDefault => 'Enter Bollinger Bands Period (Default is 20)';

  @override
  String get enterBBStdDevWithDefault => 'Enter Bollinger Bands Standard Deviation (Default is 2)';

  @override
  String get upperBand => 'Upper Band';

  @override
  String get middleBand => 'Middle Band';

  @override
  String get lowerBand => 'Lower Band';

  @override
  String get bandWidth => 'Band Width';

  @override
  String get signalStrength => 'Signal Strength';

  @override
  String get description => 'Description';

  @override
  String get strongSignal => 'Strong Signal';

  @override
  String get moderateSignal => 'Moderate Signal';

  @override
  String get weakSignal => 'Weak Signal';

  @override
  String get bollingerBandsDesc => 'Bollinger Bands are a volatility indicator used in technical analysis to measure price fluctuations of a financial asset. This indicator consists of three lines: the middle line, a simple moving average, and two bands above and below, representing standard deviations. The bands expand and contract based on the asset\'s volatility. When the price nears the upper band, the asset may be overbought; when it approaches the lower band, it may be oversold. Traders use Bollinger Bands to identify potential buy and sell points, periods of high or low volatility, and to anticipate price breakouts when bands remain narrow for an extended period.';

  @override
  String get calculateBBFailed => 'Failed to calculate Bollinger Bands';

  @override
  String get bBoverboughtHighVolatility => 'The price is above the upper band, indicating a possible overbought condition with high volatility.';

  @override
  String get bBoverbought => 'The price is above the upper band, which may suggest a potential overbought condition.';

  @override
  String get bBoversoldHighVolatility => 'The price is below the lower band, indicating a possible oversold condition with high volatility.';

  @override
  String get bBoversold => 'The price is below the lower band, which may suggest a potential oversold condition.';

  @override
  String get bBpotentialBreakout => 'The bands are narrow, suggesting low volatility and a possible breakout pattern.';

  @override
  String get bBextendedNarrowBands => 'The bands have remained narrow over an extended period, indicating low volatility with a high breakout potential.';

  @override
  String get bBwithinBands => 'The price is within the Bollinger bands, indicating typical price movement within a neutral range.';

  @override
  String get mildUpwardTrend => 'The price is above the middle band, indicating a mild upward trend.';

  @override
  String get mildDownwardTrend => 'The price is below the middle band, indicating a mild downward trend.';

  @override
  String get macd => 'MACD';

  @override
  String get macdLine => 'MACD Line';

  @override
  String get signalLine => 'Signal Line';

  @override
  String get histogram => 'Histogram';

  @override
  String get trendAnalysis => 'Trend Analysis';

  @override
  String get divergence => 'Divergence';

  @override
  String get histogramAnalysis => 'Histogram Analysis';

  @override
  String get macdbullishTrend => 'Bullish - MACD line is above the Signal line';

  @override
  String get macdbearishTrend => 'Bearish - MACD line is below the Signal line';

  @override
  String get macdneutralTrend => 'Neutral - MACD line is equal to the Signal line';

  @override
  String get macdbullishDivergence => 'Bullish Divergence - MACD decreasing while price is increasing';

  @override
  String get macdbearishDivergence => 'Bearish Divergence - MACD increasing while price is decreasing';

  @override
  String get noDivergence => 'No significant divergence detected';

  @override
  String get histogramExpanding => 'Histogram expanding - trend strengthening';

  @override
  String get histogramContracting => 'Histogram contracting - trend weakening';

  @override
  String get histogramStable => 'Histogram stable - steady trend';

  @override
  String get macdLineDesc => 'The MACD line is calculated as the difference between the 12-day and 26-day exponential moving averages, showing trend direction and momentum.';

  @override
  String get signalLineDesc => 'The Signal line is the 9-day EMA of the MACD line, helping to identify potential buy and sell signals through crossovers.';

  @override
  String get histogramDesc => 'The histogram displays the difference between the MACD and Signal lines, visualizing the trend’s strength.';

  @override
  String get macdTrendAnalysisDesc => 'The MACD Trend Analysis assesses the relationship between the MACD and Signal lines to indicate if the trend is bullish, bearish, or neutral.';

  @override
  String get divergenceDesc => 'Divergence occurs when MACD and price move in opposite directions, signaling a potential trend reversal.';

  @override
  String get histogramAnalysisDesc => 'Histogram analysis examines size changes in the histogram to assess if the trend is strengthening, weakening, or stable.';

  @override
  String get movingAverages => 'Moving Averages';

  @override
  String get movingAveragesDesc => 'Moving averages (MA) are indicators that help smooth price data to identify trends. Here are common types:';

  @override
  String get smaPeriods => 'SMA Periods (comma-separated)';

  @override
  String get emaPeriods => 'EMA Periods (comma-separated)';

  @override
  String get wmaPeriods => 'WMA Periods (comma-separated)';

  @override
  String get goldenCross => 'Golden Cross';

  @override
  String get deathCross => 'Death Cross';

  @override
  String get type => 'Type';

  @override
  String get date => 'Date';

  @override
  String get value => 'Value';

  @override
  String get smaDesc => 'SMA (Simple Moving Average): Average of prices over a specified period.';

  @override
  String get emaDesc => 'EMA (Exponential Moving Average): Gives more weight to recent prices, making it more responsive to new information.';

  @override
  String get wmaDesc => 'WMA (Weighted Moving Average): Assigns higher weights to recent prices for a balanced trend indication.';

  @override
  String get crossTypesDesc => 'Crosses between moving averages can indicate potential changes in trend direction.';

  @override
  String get goldenCrossDesc => 'Golden Cross: Occurs when a short-term MA crosses above a long-term MA, signaling a potential upward trend.';

  @override
  String get deathCrossDesc => 'Death Cross: Occurs when a short-term MA crosses below a long-term MA, signaling a potential downward trend.';

  @override
  String get enterRSIPeriodWithDefault => 'Ingrese el Período RSI (Predeterminado es 14)';

  @override
  String get rsi => 'RSI';

  @override
  String get rsiIndicatorDetails => 'Detalles del Indicador RSI';

  @override
  String get rsiExplanationDesc => 'El Índice de Fuerza Relativa (RSI) es un oscilador de momentum que mide la velocidad y el cambio en los movimientos de precios. Los valores de RSI van de 0 a 100, y se utiliza comúnmente para identificar condiciones de sobrecompra o sobreventa.';

  @override
  String get rsiValue => 'Valor RSI';

  @override
  String get rsiSmaValue => 'Valor SMA del RSI';

  @override
  String get interpretation => 'Interpretación';

  @override
  String get condition => 'Condición';

  @override
  String get trend => 'Tendencia';

  @override
  String get rsioverbought => 'Sobrecomprado';

  @override
  String get rsioversold => 'Sobrevendido';

  @override
  String get rsineutral => 'Neutral';

  @override
  String get rsibullishTrend => 'Tendencia Alcista';

  @override
  String get rsibearishTrend => 'Tendencia Bajista';

  @override
  String get rsiSmaDescription => 'Promedio Móvil Simple del RSI para suavizar la tendencia';

  @override
  String get rsinoClearDivergence => 'Sin Divergencia Clara';

  @override
  String get rsibullishDivergence => 'Divergencia Alcista - RSI subiendo mientras el precio cae';

  @override
  String get rsibearishDivergence => 'Divergencia Bajista - RSI bajando mientras el precio sube';

  @override
  String get conditionDescription => 'Condition is based on RSI levels: overbought (>= 70), oversold (<= 30), and neutral (between 30 and 70).';

  @override
  String get trendDescription => 'Trend is determined by the RSI level: bullish if above 50, bearish if below 50, or neutral if near 50.';

  @override
  String get divergenceDescription => 'Divergence compares RSI and price direction. Bullish divergence occurs when the price falls while RSI rises, and bearish divergence occurs when the price rises while RSI falls.';

  @override
  String get errorNoDataFound => 'No data found for the symbol';

  @override
  String get errorInsufficientData => 'Insufficient data to calculate ADX';

  @override
  String get errorUnexpected => 'An unexpected error occurred';

  @override
  String get providedByTradingView => 'Provided by TradingView';
}
