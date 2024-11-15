import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @indicators.
  ///
  /// In en, this message translates to:
  /// **'Indicators'**
  String get indicators;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @userRegisteredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'User registered successfully'**
  String get userRegisteredSuccessfully;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormat;

  /// No description provided for @invalidPasswordFormat.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long and contain at least one digit, one uppercase letter, one lowercase letter, and one special character'**
  String get invalidPasswordFormat;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// No description provided for @userAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'User already exists'**
  String get userAlreadyExists;

  /// No description provided for @internalServerError.
  ///
  /// In en, this message translates to:
  /// **'Internal server error'**
  String get internalServerError;

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad request'**
  String get badRequest;

  /// No description provided for @emailOrPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Email or password incorrect'**
  String get emailOrPasswordIncorrect;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @noAccountRegister.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get noAccountRegister;

  /// No description provided for @alreadyHaveAccountLogin.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get alreadyHaveAccountLogin;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'A reset link has been sent to your email'**
  String get resetLinkSent;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @passwordResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Password reset failed'**
  String get passwordResetFailed;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successful'**
  String get passwordResetSuccess;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @enterResetCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the reset code sent to your email'**
  String get enterResetCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @invalidResetCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid reset code'**
  String get invalidResetCode;

  /// No description provided for @sendResetCode.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Code'**
  String get sendResetCode;

  /// No description provided for @enterSymbol.
  ///
  /// In en, this message translates to:
  /// **'Enter Symbol'**
  String get enterSymbol;

  /// No description provided for @selectInterval.
  ///
  /// In en, this message translates to:
  /// **'Select Interval'**
  String get selectInterval;

  /// No description provided for @intervalDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get intervalDaily;

  /// No description provided for @intervalWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get intervalWeekly;

  /// No description provided for @intervalMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get intervalMonthly;

  /// No description provided for @viewAnalysis.
  ///
  /// In en, this message translates to:
  /// **'View Analysis'**
  String get viewAnalysis;

  /// No description provided for @viewChart.
  ///
  /// In en, this message translates to:
  /// **'View Chart'**
  String get viewChart;

  /// No description provided for @pleaseEnterSymbol.
  ///
  /// In en, this message translates to:
  /// **'Please enter a symbol'**
  String get pleaseEnterSymbol;

  /// No description provided for @failedToCalculate.
  ///
  /// In en, this message translates to:
  /// **'Failed to calculate. {reason}'**
  String failedToCalculate(Object reason);

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {errorMessage}'**
  String errorOccurred(Object errorMessage);

  /// No description provided for @adx.
  ///
  /// In en, this message translates to:
  /// **'ADX'**
  String get adx;

  /// No description provided for @values.
  ///
  /// In en, this message translates to:
  /// **'Valores'**
  String get values;

  /// No description provided for @enterADXPeriodWithDefault.
  ///
  /// In en, this message translates to:
  /// **'Enter ADX Period (Default is 14)'**
  String get enterADXPeriodWithDefault;

  /// No description provided for @trendStrength.
  ///
  /// In en, this message translates to:
  /// **'Trend Strength'**
  String get trendStrength;

  /// No description provided for @lastCross.
  ///
  /// In en, this message translates to:
  /// **'Last Cross'**
  String get lastCross;

  /// No description provided for @currentADX.
  ///
  /// In en, this message translates to:
  /// **'Current ADX'**
  String get currentADX;

  /// No description provided for @currentDIPlus.
  ///
  /// In en, this message translates to:
  /// **'Current +DI'**
  String get currentDIPlus;

  /// No description provided for @currentDIMinus.
  ///
  /// In en, this message translates to:
  /// **'Current -DI'**
  String get currentDIMinus;

  /// No description provided for @noSignificantTrend.
  ///
  /// In en, this message translates to:
  /// **'No significant trend detected'**
  String get noSignificantTrend;

  /// No description provided for @moderateBullishTrend.
  ///
  /// In en, this message translates to:
  /// **'Moderate bullish trend observed'**
  String get moderateBullishTrend;

  /// No description provided for @moderateBearishTrend.
  ///
  /// In en, this message translates to:
  /// **'Moderate bearish trend observed'**
  String get moderateBearishTrend;

  /// No description provided for @sidewaysModerate.
  ///
  /// In en, this message translates to:
  /// **'Sideways trend with moderate strength'**
  String get sidewaysModerate;

  /// No description provided for @strongBullishPeak.
  ///
  /// In en, this message translates to:
  /// **'Strong bullish trend detected, possible peak'**
  String get strongBullishPeak;

  /// No description provided for @strongBearishPeak.
  ///
  /// In en, this message translates to:
  /// **'Strong bearish trend detected, possible peak'**
  String get strongBearishPeak;

  /// No description provided for @veryStrongTrendNearPeak.
  ///
  /// In en, this message translates to:
  /// **'Very strong trend detected, near peak strength'**
  String get veryStrongTrendNearPeak;

  /// No description provided for @bullishCross.
  ///
  /// In en, this message translates to:
  /// **'Bullish Cross'**
  String get bullishCross;

  /// No description provided for @bearishCross.
  ///
  /// In en, this message translates to:
  /// **'Bearish Cross'**
  String get bearishCross;

  /// No description provided for @adxExplanation.
  ///
  /// In en, this message translates to:
  /// **'ADX Explanation'**
  String get adxExplanation;

  /// No description provided for @adxExplanationDesc.
  ///
  /// In en, this message translates to:
  /// **'The ADX (Average Directional Index) is a technical indicator used to quantify trend strength.'**
  String get adxExplanationDesc;

  /// No description provided for @crossTypes.
  ///
  /// In en, this message translates to:
  /// **'Cross Types'**
  String get crossTypes;

  /// No description provided for @bollingerBands.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Bands'**
  String get bollingerBands;

  /// No description provided for @enterBBPeriodWithDefault.
  ///
  /// In en, this message translates to:
  /// **'Enter Bollinger Bands Period (Default is 20)'**
  String get enterBBPeriodWithDefault;

  /// No description provided for @enterBBStdDevWithDefault.
  ///
  /// In en, this message translates to:
  /// **'Enter Bollinger Bands Standard Deviation (Default is 2)'**
  String get enterBBStdDevWithDefault;

  /// No description provided for @upperBand.
  ///
  /// In en, this message translates to:
  /// **'Upper Band'**
  String get upperBand;

  /// No description provided for @middleBand.
  ///
  /// In en, this message translates to:
  /// **'Middle Band'**
  String get middleBand;

  /// No description provided for @lowerBand.
  ///
  /// In en, this message translates to:
  /// **'Lower Band'**
  String get lowerBand;

  /// No description provided for @bandWidth.
  ///
  /// In en, this message translates to:
  /// **'Band Width'**
  String get bandWidth;

  /// No description provided for @signalStrength.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get signalStrength;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @strongSignal.
  ///
  /// In en, this message translates to:
  /// **'Strong Signal'**
  String get strongSignal;

  /// No description provided for @moderateSignal.
  ///
  /// In en, this message translates to:
  /// **'Moderate Signal'**
  String get moderateSignal;

  /// No description provided for @weakSignal.
  ///
  /// In en, this message translates to:
  /// **'Weak Signal'**
  String get weakSignal;

  /// No description provided for @bollingerBandsDesc.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Bands are a volatility indicator used in technical analysis to measure price fluctuations of a financial asset. This indicator consists of three lines: the middle line, a simple moving average, and two bands above and below, representing standard deviations. The bands expand and contract based on the asset\'s volatility. When the price nears the upper band, the asset may be overbought; when it approaches the lower band, it may be oversold. Traders use Bollinger Bands to identify potential buy and sell points, periods of high or low volatility, and to anticipate price breakouts when bands remain narrow for an extended period.'**
  String get bollingerBandsDesc;

  /// No description provided for @calculateBBFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to calculate Bollinger Bands'**
  String get calculateBBFailed;

  /// No description provided for @bBoverboughtHighVolatility.
  ///
  /// In en, this message translates to:
  /// **'The price is above the upper band, indicating a possible overbought condition with high volatility.'**
  String get bBoverboughtHighVolatility;

  /// No description provided for @bBoverbought.
  ///
  /// In en, this message translates to:
  /// **'The price is above the upper band, which may suggest a potential overbought condition.'**
  String get bBoverbought;

  /// No description provided for @bBoversoldHighVolatility.
  ///
  /// In en, this message translates to:
  /// **'The price is below the lower band, indicating a possible oversold condition with high volatility.'**
  String get bBoversoldHighVolatility;

  /// No description provided for @bBoversold.
  ///
  /// In en, this message translates to:
  /// **'The price is below the lower band, which may suggest a potential oversold condition.'**
  String get bBoversold;

  /// No description provided for @bBpotentialBreakout.
  ///
  /// In en, this message translates to:
  /// **'The bands are narrow, suggesting low volatility and a possible breakout pattern.'**
  String get bBpotentialBreakout;

  /// No description provided for @bBextendedNarrowBands.
  ///
  /// In en, this message translates to:
  /// **'The bands have remained narrow over an extended period, indicating low volatility with a high breakout potential.'**
  String get bBextendedNarrowBands;

  /// No description provided for @bBwithinBands.
  ///
  /// In en, this message translates to:
  /// **'The price is within the Bollinger bands, indicating typical price movement within a neutral range.'**
  String get bBwithinBands;

  /// No description provided for @mildUpwardTrend.
  ///
  /// In en, this message translates to:
  /// **'The price is above the middle band, indicating a mild upward trend.'**
  String get mildUpwardTrend;

  /// No description provided for @mildDownwardTrend.
  ///
  /// In en, this message translates to:
  /// **'The price is below the middle band, indicating a mild downward trend.'**
  String get mildDownwardTrend;

  /// No description provided for @macd.
  ///
  /// In en, this message translates to:
  /// **'MACD'**
  String get macd;

  /// No description provided for @macdLine.
  ///
  /// In en, this message translates to:
  /// **'MACD Line'**
  String get macdLine;

  /// No description provided for @signalLine.
  ///
  /// In en, this message translates to:
  /// **'Signal Line'**
  String get signalLine;

  /// No description provided for @histogram.
  ///
  /// In en, this message translates to:
  /// **'Histogram'**
  String get histogram;

  /// No description provided for @trendAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Trend Analysis'**
  String get trendAnalysis;

  /// No description provided for @divergence.
  ///
  /// In en, this message translates to:
  /// **'Divergence'**
  String get divergence;

  /// No description provided for @histogramAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Histogram Analysis'**
  String get histogramAnalysis;

  /// No description provided for @macdbullishTrend.
  ///
  /// In en, this message translates to:
  /// **'Bullish - MACD line is above the Signal line'**
  String get macdbullishTrend;

  /// No description provided for @macdbearishTrend.
  ///
  /// In en, this message translates to:
  /// **'Bearish - MACD line is below the Signal line'**
  String get macdbearishTrend;

  /// No description provided for @macdneutralTrend.
  ///
  /// In en, this message translates to:
  /// **'Neutral - MACD line is equal to the Signal line'**
  String get macdneutralTrend;

  /// No description provided for @macdbullishDivergence.
  ///
  /// In en, this message translates to:
  /// **'Bullish Divergence - MACD decreasing while price is increasing'**
  String get macdbullishDivergence;

  /// No description provided for @macdbearishDivergence.
  ///
  /// In en, this message translates to:
  /// **'Bearish Divergence - MACD increasing while price is decreasing'**
  String get macdbearishDivergence;

  /// No description provided for @noDivergence.
  ///
  /// In en, this message translates to:
  /// **'No significant divergence detected'**
  String get noDivergence;

  /// No description provided for @histogramExpanding.
  ///
  /// In en, this message translates to:
  /// **'Histogram expanding - trend strengthening'**
  String get histogramExpanding;

  /// No description provided for @histogramContracting.
  ///
  /// In en, this message translates to:
  /// **'Histogram contracting - trend weakening'**
  String get histogramContracting;

  /// No description provided for @histogramStable.
  ///
  /// In en, this message translates to:
  /// **'Histogram stable - steady trend'**
  String get histogramStable;

  /// No description provided for @macdLineDesc.
  ///
  /// In en, this message translates to:
  /// **'The MACD line is calculated as the difference between the 12-day and 26-day exponential moving averages, showing trend direction and momentum.'**
  String get macdLineDesc;

  /// No description provided for @signalLineDesc.
  ///
  /// In en, this message translates to:
  /// **'The Signal line is the 9-day EMA of the MACD line, helping to identify potential buy and sell signals through crossovers.'**
  String get signalLineDesc;

  /// No description provided for @histogramDesc.
  ///
  /// In en, this message translates to:
  /// **'The histogram displays the difference between the MACD and Signal lines, visualizing the trend’s strength.'**
  String get histogramDesc;

  /// No description provided for @macdTrendAnalysisDesc.
  ///
  /// In en, this message translates to:
  /// **'The MACD Trend Analysis assesses the relationship between the MACD and Signal lines to indicate if the trend is bullish, bearish, or neutral.'**
  String get macdTrendAnalysisDesc;

  /// No description provided for @divergenceDesc.
  ///
  /// In en, this message translates to:
  /// **'Divergence occurs when MACD and price move in opposite directions, signaling a potential trend reversal.'**
  String get divergenceDesc;

  /// No description provided for @histogramAnalysisDesc.
  ///
  /// In en, this message translates to:
  /// **'Histogram analysis examines size changes in the histogram to assess if the trend is strengthening, weakening, or stable.'**
  String get histogramAnalysisDesc;

  /// No description provided for @movingAverages.
  ///
  /// In en, this message translates to:
  /// **'Moving Averages'**
  String get movingAverages;

  /// No description provided for @movingAveragesDesc.
  ///
  /// In en, this message translates to:
  /// **'Moving averages (MA) are indicators that help smooth price data to identify trends. Here are common types:'**
  String get movingAveragesDesc;

  /// No description provided for @smaPeriods.
  ///
  /// In en, this message translates to:
  /// **'SMA Periods (comma-separated)'**
  String get smaPeriods;

  /// No description provided for @emaPeriods.
  ///
  /// In en, this message translates to:
  /// **'EMA Periods (comma-separated)'**
  String get emaPeriods;

  /// No description provided for @wmaPeriods.
  ///
  /// In en, this message translates to:
  /// **'WMA Periods (comma-separated)'**
  String get wmaPeriods;

  /// No description provided for @goldenCross.
  ///
  /// In en, this message translates to:
  /// **'Golden Cross'**
  String get goldenCross;

  /// No description provided for @deathCross.
  ///
  /// In en, this message translates to:
  /// **'Death Cross'**
  String get deathCross;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @smaDesc.
  ///
  /// In en, this message translates to:
  /// **'SMA (Simple Moving Average): Average of prices over a specified period.'**
  String get smaDesc;

  /// No description provided for @emaDesc.
  ///
  /// In en, this message translates to:
  /// **'EMA (Exponential Moving Average): Gives more weight to recent prices, making it more responsive to new information.'**
  String get emaDesc;

  /// No description provided for @wmaDesc.
  ///
  /// In en, this message translates to:
  /// **'WMA (Weighted Moving Average): Assigns higher weights to recent prices for a balanced trend indication.'**
  String get wmaDesc;

  /// No description provided for @crossTypesDesc.
  ///
  /// In en, this message translates to:
  /// **'Crosses between moving averages can indicate potential changes in trend direction.'**
  String get crossTypesDesc;

  /// No description provided for @goldenCrossDesc.
  ///
  /// In en, this message translates to:
  /// **'Golden Cross: Occurs when a short-term MA crosses above a long-term MA, signaling a potential upward trend.'**
  String get goldenCrossDesc;

  /// No description provided for @deathCrossDesc.
  ///
  /// In en, this message translates to:
  /// **'Death Cross: Occurs when a short-term MA crosses below a long-term MA, signaling a potential downward trend.'**
  String get deathCrossDesc;

  /// No description provided for @enterRSIPeriodWithDefault.
  ///
  /// In en, this message translates to:
  /// **'Ingrese el Período RSI (Predeterminado es 14)'**
  String get enterRSIPeriodWithDefault;

  /// No description provided for @rsi.
  ///
  /// In en, this message translates to:
  /// **'RSI'**
  String get rsi;

  /// No description provided for @rsiIndicatorDetails.
  ///
  /// In en, this message translates to:
  /// **'Detalles del Indicador RSI'**
  String get rsiIndicatorDetails;

  /// No description provided for @rsiExplanationDesc.
  ///
  /// In en, this message translates to:
  /// **'El Índice de Fuerza Relativa (RSI) es un oscilador de momentum que mide la velocidad y el cambio en los movimientos de precios. Los valores de RSI van de 0 a 100, y se utiliza comúnmente para identificar condiciones de sobrecompra o sobreventa.'**
  String get rsiExplanationDesc;

  /// No description provided for @rsiValue.
  ///
  /// In en, this message translates to:
  /// **'Valor RSI'**
  String get rsiValue;

  /// No description provided for @rsiSmaValue.
  ///
  /// In en, this message translates to:
  /// **'Valor SMA del RSI'**
  String get rsiSmaValue;

  /// No description provided for @interpretation.
  ///
  /// In en, this message translates to:
  /// **'Interpretación'**
  String get interpretation;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Condición'**
  String get condition;

  /// No description provided for @trend.
  ///
  /// In en, this message translates to:
  /// **'Tendencia'**
  String get trend;

  /// No description provided for @rsioverbought.
  ///
  /// In en, this message translates to:
  /// **'Sobrecomprado'**
  String get rsioverbought;

  /// No description provided for @rsioversold.
  ///
  /// In en, this message translates to:
  /// **'Sobrevendido'**
  String get rsioversold;

  /// No description provided for @rsineutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get rsineutral;

  /// No description provided for @rsibullishTrend.
  ///
  /// In en, this message translates to:
  /// **'Tendencia Alcista'**
  String get rsibullishTrend;

  /// No description provided for @rsibearishTrend.
  ///
  /// In en, this message translates to:
  /// **'Tendencia Bajista'**
  String get rsibearishTrend;

  /// No description provided for @rsiSmaDescription.
  ///
  /// In en, this message translates to:
  /// **'Promedio Móvil Simple del RSI para suavizar la tendencia'**
  String get rsiSmaDescription;

  /// No description provided for @rsinoClearDivergence.
  ///
  /// In en, this message translates to:
  /// **'Sin Divergencia Clara'**
  String get rsinoClearDivergence;

  /// No description provided for @rsibullishDivergence.
  ///
  /// In en, this message translates to:
  /// **'Divergencia Alcista - RSI subiendo mientras el precio cae'**
  String get rsibullishDivergence;

  /// No description provided for @rsibearishDivergence.
  ///
  /// In en, this message translates to:
  /// **'Divergencia Bajista - RSI bajando mientras el precio sube'**
  String get rsibearishDivergence;

  /// No description provided for @conditionDescription.
  ///
  /// In en, this message translates to:
  /// **'Condition is based on RSI levels: overbought (>= 70), oversold (<= 30), and neutral (between 30 and 70).'**
  String get conditionDescription;

  /// No description provided for @trendDescription.
  ///
  /// In en, this message translates to:
  /// **'Trend is determined by the RSI level: bullish if above 50, bearish if below 50, or neutral if near 50.'**
  String get trendDescription;

  /// No description provided for @divergenceDescription.
  ///
  /// In en, this message translates to:
  /// **'Divergence compares RSI and price direction. Bullish divergence occurs when the price falls while RSI rises, and bearish divergence occurs when the price rises while RSI falls.'**
  String get divergenceDescription;

  /// No description provided for @errorNoDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found for the symbol'**
  String get errorNoDataFound;

  /// No description provided for @errorInsufficientData.
  ///
  /// In en, this message translates to:
  /// **'Insufficient data to calculate ADX'**
  String get errorInsufficientData;

  /// No description provided for @errorUnexpected.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get errorUnexpected;

  /// No description provided for @providedByTradingView.
  ///
  /// In en, this message translates to:
  /// **'Provided by TradingView'**
  String get providedByTradingView;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
