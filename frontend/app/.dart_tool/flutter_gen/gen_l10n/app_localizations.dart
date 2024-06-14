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

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

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

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad Request'**
  String get badRequest;

  /// No description provided for @emailOrPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get emailOrPasswordIncorrect;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @internalServerError.
  ///
  /// In en, this message translates to:
  /// **'Internal Server Error'**
  String get internalServerError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get unauthorized;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @userAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'User already exists'**
  String get userAlreadyExists;

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

  /// No description provided for @userRegisteredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'User registered successfully'**
  String get userRegisteredSuccessfully;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @pleaseEnterSymbol.
  ///
  /// In en, this message translates to:
  /// **'Please enter a symbol'**
  String get pleaseEnterSymbol;

  /// No description provided for @pleaseEnterPeriod.
  ///
  /// In en, this message translates to:
  /// **'Please enter a period'**
  String get pleaseEnterPeriod;

  /// No description provided for @failedToCalculate.
  ///
  /// In en, this message translates to:
  /// **'Failed to calculate: {error}'**
  String failedToCalculate(Object error);

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String errorOccurred(Object error);

  /// No description provided for @indicators.
  ///
  /// In en, this message translates to:
  /// **'Indicators'**
  String get indicators;

  /// No description provided for @oscillator.
  ///
  /// In en, this message translates to:
  /// **'Oscillator'**
  String get oscillator;

  /// No description provided for @movingAverages.
  ///
  /// In en, this message translates to:
  /// **'Moving Averages'**
  String get movingAverages;

  /// No description provided for @movingAveragesType.
  ///
  /// In en, this message translates to:
  /// **'Moving Averages Type'**
  String get movingAveragesType;

  /// No description provided for @enterPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period (comma separated)'**
  String get enterPeriod;

  /// No description provided for @stochasticOscillator.
  ///
  /// In en, this message translates to:
  /// **'Stochastic Oscillator'**
  String get stochasticOscillator;

  /// No description provided for @bollingerBands.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Bands'**
  String get bollingerBands;

  /// No description provided for @parabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'Parabolic SAR'**
  String get parabolicSAR;

  /// No description provided for @enterSymbol.
  ///
  /// In en, this message translates to:
  /// **'Enter Symbol'**
  String get enterSymbol;

  /// No description provided for @getRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Get Recommendation'**
  String get getRecommendation;

  /// No description provided for @viewChart.
  ///
  /// In en, this message translates to:
  /// **'View Chart'**
  String get viewChart;

  /// No description provided for @strategies.
  ///
  /// In en, this message translates to:
  /// **'Strategies'**
  String get strategies;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @recommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendation;

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

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get buy;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'SELL'**
  String get sell;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL'**
  String get neutral;

  /// No description provided for @strongBuy.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY'**
  String get strongBuy;

  /// No description provided for @strongSell.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL'**
  String get strongSell;

  /// No description provided for @overbought.
  ///
  /// In en, this message translates to:
  /// **'Overbought'**
  String get overbought;

  /// No description provided for @oversold.
  ///
  /// In en, this message translates to:
  /// **'Oversold'**
  String get oversold;

  /// No description provided for @strongOversold.
  ///
  /// In en, this message translates to:
  /// **'Strong Oversold'**
  String get strongOversold;

  /// No description provided for @strongOverbought.
  ///
  /// In en, this message translates to:
  /// **'Strong Overbought'**
  String get strongOverbought;

  /// No description provided for @noClearSignal.
  ///
  /// In en, this message translates to:
  /// **'No clear signal'**
  String get noClearSignal;

  /// No description provided for @signalStrength.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get signalStrength;

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

  /// No description provided for @divergence.
  ///
  /// In en, this message translates to:
  /// **'Divergence'**
  String get divergence;

  /// No description provided for @entryExitSignal.
  ///
  /// In en, this message translates to:
  /// **'Entry/Exit Signal'**
  String get entryExitSignal;

  /// No description provided for @histogram.
  ///
  /// In en, this message translates to:
  /// **'Histogram'**
  String get histogram;

  /// No description provided for @signalLine.
  ///
  /// In en, this message translates to:
  /// **'Signal Line'**
  String get signalLine;

  /// No description provided for @macdLine.
  ///
  /// In en, this message translates to:
  /// **'MACD Line'**
  String get macdLine;

  /// No description provided for @bullish.
  ///
  /// In en, this message translates to:
  /// **'Bullish'**
  String get bullish;

  /// No description provided for @bearish.
  ///
  /// In en, this message translates to:
  /// **'Bearish'**
  String get bearish;

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

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @crossingPoints.
  ///
  /// In en, this message translates to:
  /// **'Crossing Points'**
  String get crossingPoints;

  /// No description provided for @adxIndicatorDetails.
  ///
  /// In en, this message translates to:
  /// **'ADX Indicator Details'**
  String get adxIndicatorDetails;

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

  /// No description provided for @absenceOfClearTrend.
  ///
  /// In en, this message translates to:
  /// **'Absence of clear trend'**
  String get absenceOfClearTrend;

  /// No description provided for @clearBullishTrend.
  ///
  /// In en, this message translates to:
  /// **'Clear bullish trend'**
  String get clearBullishTrend;

  /// No description provided for @clearBearishTrend.
  ///
  /// In en, this message translates to:
  /// **'Clear bearish trend'**
  String get clearBearishTrend;

  /// No description provided for @sidewaysTrend.
  ///
  /// In en, this message translates to:
  /// **'Sideways trend'**
  String get sidewaysTrend;

  /// No description provided for @strongBullishTrend.
  ///
  /// In en, this message translates to:
  /// **'Strong bullish trend (possible peak)'**
  String get strongBullishTrend;

  /// No description provided for @strongBearishTrend.
  ///
  /// In en, this message translates to:
  /// **'Strong bearish trend (possible peak)'**
  String get strongBearishTrend;

  /// No description provided for @veryStrongTrend.
  ///
  /// In en, this message translates to:
  /// **'Very strong trend (trend peak)'**
  String get veryStrongTrend;

  /// No description provided for @understandingTheIndicator.
  ///
  /// In en, this message translates to:
  /// **'Understanding the indicator'**
  String get understandingTheIndicator;

  /// No description provided for @understandingADXDesc.
  ///
  /// In en, this message translates to:
  /// **'The ADX is a technical analysis indicator used to quantify the strength of a trend. It ranges from 0 to 100, with higher values indicating a stronger trend.'**
  String get understandingADXDesc;

  /// No description provided for @recommendationLogic.
  ///
  /// In en, this message translates to:
  /// **'Recommendation Logic:'**
  String get recommendationLogic;

  /// No description provided for @recommendationLogicDescAdx.
  ///
  /// In en, this message translates to:
  /// **'The ADX value helps determine the strength of the trend:\n- Below 25: Absence of clear trend.\n- 25 to 40: Clear trend (bullish or bearish).\n- 40 to 50: Strong trend (possible peak).\n- Above 50: Very strong trend (trend peak).'**
  String get recommendationLogicDescAdx;

  /// No description provided for @recommendationTypes.
  ///
  /// In en, this message translates to:
  /// **'Recommendation Types:'**
  String get recommendationTypes;

  /// No description provided for @buyRecommendationAdx.
  ///
  /// In en, this message translates to:
  /// **'BUY: ADX value is above 25 and the +DI crosses above the -DI, indicating a potential bullish trend.'**
  String get buyRecommendationAdx;

  /// No description provided for @sellRecommendationAdx.
  ///
  /// In en, this message translates to:
  /// **'SELL: ADX value is above 25 and the +DI crosses below the -DI, indicating a potential bearish trend.'**
  String get sellRecommendationAdx;

  /// No description provided for @neutralRecommendationAdx.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: ADX value is below 25, indicating a weak or absent trend.'**
  String get neutralRecommendationAdx;

  /// No description provided for @strongBuyRecommendationAdx.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: ADX value is above 50 and the +DI crosses above the -DI, indicating a very strong bullish trend.'**
  String get strongBuyRecommendationAdx;

  /// No description provided for @strongSellRecommendationAdx.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: ADX value is above 50 and the +DI crosses below the -DI, indicating a very strong bearish trend.'**
  String get strongSellRecommendationAdx;

  /// No description provided for @adxDivergenceDesc.
  ///
  /// In en, this message translates to:
  /// **'ADX divergence occurs when the price movement is not confirmed by the ADX indicator. For example, if the price is making new highs, but the ADX indicator is making lower highs, it may indicate a weakening trend, or potential reversal.'**
  String get adxDivergenceDesc;

  /// No description provided for @adxEntryExitSignalDesc.
  ///
  /// In en, this message translates to:
  /// **'Some traders use specific ADX threshold levels as entry or exit signals. For example, they may enter a trade when the ADX crosses above a certain value, indicating a strong trend, and exit when it falls below another threshold, suggesting a weakening trend. These threshold levels may vary depending on the trader\'s strategy and market conditions.'**
  String get adxEntryExitSignalDesc;

  /// No description provided for @understandingBollingerBandsDesc.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Bands are a type of statistical chart characterizing the prices and volatility over time of a financial instrument or commodity. They consist of a middle band (SMA) and two outer bands (standard deviations above and below the SMA).'**
  String get understandingBollingerBandsDesc;

  /// No description provided for @bollingerBandsLevels.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Bands Levels'**
  String get bollingerBandsLevels;

  /// No description provided for @bollingerBandsLevelsDesc.
  ///
  /// In en, this message translates to:
  /// **'The Bollinger Bands indicator consists of three lines: the upper band, middle band (SMA), and lower band. The position of the price relative to these bands can provide trading signals.'**
  String get bollingerBandsLevelsDesc;

  /// No description provided for @buyRecommendationBollinger.
  ///
  /// In en, this message translates to:
  /// **'BUY: The price is below the lower band - Oversold.'**
  String get buyRecommendationBollinger;

  /// No description provided for @strongBuyRecommendationBollinger.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: The price is below the lower band - Oversold with wide bands.'**
  String get strongBuyRecommendationBollinger;

  /// No description provided for @sellRecommendationBollinger.
  ///
  /// In en, this message translates to:
  /// **'SELL: The price is above the upper band - Overbought.'**
  String get sellRecommendationBollinger;

  /// No description provided for @strongSellRecommendationBollinger.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: The price is above the upper band - Overbought with wide bands.'**
  String get strongSellRecommendationBollinger;

  /// No description provided for @neutralRecommendationBollinger.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: Narrow bands - Neutral or within the Bollinger bands.'**
  String get neutralRecommendationBollinger;

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

  /// No description provided for @overboughtWideBands.
  ///
  /// In en, this message translates to:
  /// **'Price above Upper Band - Overbought with Wide Bands'**
  String get overboughtWideBands;

  /// No description provided for @bollingerBandsOverbought.
  ///
  /// In en, this message translates to:
  /// **'Price above Upper Band - Overbought'**
  String get bollingerBandsOverbought;

  /// No description provided for @oversoldWideBands.
  ///
  /// In en, this message translates to:
  /// **'Price below Lower Band - Oversold with Wide Bands'**
  String get oversoldWideBands;

  /// No description provided for @bollingerBandsOversold.
  ///
  /// In en, this message translates to:
  /// **'Price below Lower Band - Oversold'**
  String get bollingerBandsOversold;

  /// No description provided for @narrowBandsNeutral.
  ///
  /// In en, this message translates to:
  /// **'Narrow Bands - Neutral'**
  String get narrowBandsNeutral;

  /// No description provided for @withinBollingerBands.
  ///
  /// In en, this message translates to:
  /// **'Within Bollinger Bands'**
  String get withinBollingerBands;

  /// No description provided for @bollinger_band_squeeze_title.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Band Squeeze'**
  String get bollinger_band_squeeze_title;

  /// No description provided for @bollinger_band_squeeze_description.
  ///
  /// In en, this message translates to:
  /// **'The Bollinger Band Squeeze strategy is based on the principle that periods of low volatility are often followed by periods of high volatility. When the bands squeeze together, it indicates that the volatility is low and a breakout could occur. Traders watch for a price move above or below the bands as a signal for potential entry.'**
  String get bollinger_band_squeeze_description;

  /// No description provided for @bollinger_band_breakout_title.
  ///
  /// In en, this message translates to:
  /// **'Bollinger Band Breakout'**
  String get bollinger_band_breakout_title;

  /// No description provided for @bollinger_band_breakout_description.
  ///
  /// In en, this message translates to:
  /// **'The Bollinger Band Breakout strategy looks for price breaking out of the upper or lower bands. A breakout above the upper band can signal that the price is in a strong uptrend, while a breakout below the lower band can signal a strong downtrend. Traders often use this strategy to enter trades in the direction of the breakout.'**
  String get bollinger_band_breakout_description;

  /// No description provided for @reversion_to_mean_title.
  ///
  /// In en, this message translates to:
  /// **'Reversion to the Mean'**
  String get reversion_to_mean_title;

  /// No description provided for @reversion_to_mean_description.
  ///
  /// In en, this message translates to:
  /// **'This strategy assumes that price tends to return to the middle band (the simple moving average) after touching the upper or lower bands. When the price hits the upper band, traders might look for sell signals, anticipating that the price will revert back to the mean. Conversely, when the price hits the lower band, traders might look for buy signals.'**
  String get reversion_to_mean_description;

  /// No description provided for @double_bottoms_and_tops_title.
  ///
  /// In en, this message translates to:
  /// **'Double Bottoms and Tops'**
  String get double_bottoms_and_tops_title;

  /// No description provided for @double_bottoms_and_tops_description.
  ///
  /// In en, this message translates to:
  /// **'Double bottoms and tops are reversal patterns that can be identified using Bollinger Bands. A double bottom occurs when the price makes two lows around the same level, often with a lower low touching or going below the lower band, followed by a rally. A double top occurs when the price makes two highs around the same level, often with an upper high touching or exceeding the upper band, followed by a decline.'**
  String get double_bottoms_and_tops_description;

  /// No description provided for @belowMiddleBand.
  ///
  /// In en, this message translates to:
  /// **'Price below Middle Band\''**
  String get belowMiddleBand;

  /// No description provided for @aboveMiddleBand.
  ///
  /// In en, this message translates to:
  /// **'Price above Middle Band'**
  String get aboveMiddleBand;

  /// No description provided for @understandingMacdDesc.
  ///
  /// In en, this message translates to:
  /// **'The MACD is a trend-following momentum indicator that shows the relationship between two moving averages of a security’s price. It consists of the MACD line, signal line, and histogram.'**
  String get understandingMacdDesc;

  /// No description provided for @buyRecommendationMacd.
  ///
  /// In en, this message translates to:
  /// **'BUY: The MACD crosses above the signal line, indicating a bullish trend.'**
  String get buyRecommendationMacd;

  /// No description provided for @sellRecommendationMacd.
  ///
  /// In en, this message translates to:
  /// **'SELL: The MACD crosses below the signal line, indicating a bearish trend.'**
  String get sellRecommendationMacd;

  /// No description provided for @neutralRecommendationMacd.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: No clear signal is identified by the MACD indicator, possibly due to the proximity between the MACD and the signal line.'**
  String get neutralRecommendationMacd;

  /// No description provided for @strongBuyRecommendationMacd.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: The MACD crosses above the signal line with an increasing histogram, indicating a strong bullish trend.'**
  String get strongBuyRecommendationMacd;

  /// No description provided for @strongSellRecommendationMacd.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: The MACD crosses below the signal line with a decreasing histogram, indicating a strong bearish trend.'**
  String get strongSellRecommendationMacd;

  /// No description provided for @recommendationLogicDescMacd.
  ///
  /// In en, this message translates to:
  /// **'When the MACD line crosses above the signal line, it is considered a bullish signal, indicating a potential buy opportunity. Conversely, when the MACD line crosses below the signal line, it is considered a bearish signal, indicating a potential sell opportunity.'**
  String get recommendationLogicDescMacd;

  /// No description provided for @macdLineSignalCorss.
  ///
  /// In en, this message translates to:
  /// **'MACD Line and Signal Line Crossover'**
  String get macdLineSignalCorss;

  /// No description provided for @macdLineSignalCorssDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves identifying buy and sell signals based on the crossover of the MACD line and the signal line. A bullish crossover occurs when the MACD line crosses above the signal line, indicating a potential buy signal. Conversely, a bearish crossover occurs when the MACD line crosses below the signal line, indicating a potential sell signal.'**
  String get macdLineSignalCorssDesc;

  /// No description provided for @macdHistogram.
  ///
  /// In en, this message translates to:
  /// **'MACD Histogram'**
  String get macdHistogram;

  /// No description provided for @macdHistogramDesc.
  ///
  /// In en, this message translates to:
  /// **'In this strategy, traders look for changes in the MACD histogram. When the histogram moves from negative to positive territory, it suggests increasing bullish momentum. Conversely, when the histogram moves from positive to negative territory, it suggests increasing bearish momentum.'**
  String get macdHistogramDesc;

  /// No description provided for @macdDivergencePrice.
  ///
  /// In en, this message translates to:
  /// **'Divergence with Price'**
  String get macdDivergencePrice;

  /// No description provided for @macdDivergencePriceDesc.
  ///
  /// In en, this message translates to:
  /// **'Similar to RSI divergence, traders can use MACD divergence to identify potential trend reversals. A bullish divergence occurs when the price makes a lower low, but the MACD indicator forms a higher low. Conversely, a bearish divergence occurs when the price makes a higher high, but the MACD indicator forms a lower high.'**
  String get macdDivergencePriceDesc;

  /// No description provided for @bearishDivergence.
  ///
  /// In en, this message translates to:
  /// **'Bearish Divergence'**
  String get bearishDivergence;

  /// No description provided for @macdSignalBullish.
  ///
  /// In en, this message translates to:
  /// **'MACD and signal in bullish territory'**
  String get macdSignalBullish;

  /// No description provided for @conflictingSignals.
  ///
  /// In en, this message translates to:
  /// **'Conflicting signals'**
  String get conflictingSignals;

  /// No description provided for @bullishDivergence.
  ///
  /// In en, this message translates to:
  /// **'Bullish Divergence'**
  String get bullishDivergence;

  /// No description provided for @macdSignalBearish.
  ///
  /// In en, this message translates to:
  /// **'MACD and signal in bearish territory'**
  String get macdSignalBearish;

  /// No description provided for @currentParabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'Current Parabolic SAR'**
  String get currentParabolicSAR;

  /// No description provided for @previousParabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'Previous Parabolic SAR'**
  String get previousParabolicSAR;

  /// No description provided for @trendDirection.
  ///
  /// In en, this message translates to:
  /// **'Trend Direction'**
  String get trendDirection;

  /// No description provided for @upwardTrend.
  ///
  /// In en, this message translates to:
  /// **'Upward Trend'**
  String get upwardTrend;

  /// No description provided for @downwardTrend.
  ///
  /// In en, this message translates to:
  /// **'Downward Trend'**
  String get downwardTrend;

  /// No description provided for @noClearTrend.
  ///
  /// In en, this message translates to:
  /// **'No Clear Trend'**
  String get noClearTrend;

  /// No description provided for @buyRecommendationParabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'BUY: SAR is currently below the price, indicating a potential bullish trend.'**
  String get buyRecommendationParabolicSAR;

  /// No description provided for @strongBuyRecommendationParabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: SAR is significantly below the price, indicating a strong bullish trend.'**
  String get strongBuyRecommendationParabolicSAR;

  /// No description provided for @sellRecommendationParabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'SELL: SAR is currently above the price, indicating a potential bearish trend.'**
  String get sellRecommendationParabolicSAR;

  /// No description provided for @strongSellRecommendationParabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: SAR is significantly above the price, indicating a strong bearish trend.'**
  String get strongSellRecommendationParabolicSAR;

  /// No description provided for @neutralRecommendationParabolicSAR.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: SAR is not significantly above or below the price, suggesting a lack of clear trend direction.'**
  String get neutralRecommendationParabolicSAR;

  /// No description provided for @understandingParabolicSARDesc.
  ///
  /// In en, this message translates to:
  /// **'The Parabolic SAR (Stop and Reverse) is a technical indicator used to identify potential reversals in the price direction of an asset. It is represented by a series of dots above or below the price chart, indicating the potential direction of the trend.'**
  String get understandingParabolicSARDesc;

  /// No description provided for @recommendationLogicItem1.
  ///
  /// In en, this message translates to:
  /// **'If the current SAR value is greater than the previous SAR value and the current price is greater than the previous price, it indicates an uptrend and a possible buying opportunity.'**
  String get recommendationLogicItem1;

  /// No description provided for @recommendationLogicItem2.
  ///
  /// In en, this message translates to:
  /// **'If the current SAR value is lower than the previous SAR value and the current price is lower than the previous price, it indicates a bearish trend and a possible selling opportunity.'**
  String get recommendationLogicItem2;

  /// No description provided for @trendReversal.
  ///
  /// In en, this message translates to:
  /// **'Trend Reversal'**
  String get trendReversal;

  /// No description provided for @trailingStopLoss.
  ///
  /// In en, this message translates to:
  /// **'Trailing Stop Loss'**
  String get trailingStopLoss;

  /// No description provided for @trendFollowing.
  ///
  /// In en, this message translates to:
  /// **'Trend Following'**
  String get trendFollowing;

  /// No description provided for @trendReversalDescription.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves identifying potential trend reversals based on the movement of the Parabolic SAR indicator. A reversal from above the price to below the price suggests a potential bullish trend reversal, while a reversal from below the price to above the price suggests a potential bearish trend reversal.'**
  String get trendReversalDescription;

  /// No description provided for @trailingStopLossDescription.
  ///
  /// In en, this message translates to:
  /// **'In this strategy, traders use the Parabolic SAR as a trailing stop loss mechanism. As the price moves in favor of the trade, the Parabolic SAR moves closer to the price, acting as a dynamic stop loss level. If the price reverses and the Parabolic SAR crosses the price, it triggers a stop loss.'**
  String get trailingStopLossDescription;

  /// No description provided for @trendFollowingDescription.
  ///
  /// In en, this message translates to:
  /// **'Traders can use the Parabolic SAR to follow the trend by entering positions in the direction of the SAR. In an uptrend, traders look for buy signals when the SAR moves below the price, indicating bullish momentum. In a downtrend, traders look for sell signals when the SAR moves above the price, indicating bearish momentum.'**
  String get trendFollowingDescription;

  /// No description provided for @understandingRSIDesc.
  ///
  /// In en, this message translates to:
  /// **'The Relative Strength Index (RSI) is a momentum oscillator that measures the speed and change of price movements. It is primarily used to identify overbought or oversold conditions in a market.'**
  String get understandingRSIDesc;

  /// No description provided for @buyRecommendationRSI.
  ///
  /// In en, this message translates to:
  /// **'BUY: RSI < 30 and starts to rise, indicating an oversold condition and a potential buying opportunity.'**
  String get buyRecommendationRSI;

  /// No description provided for @strongBuyRecommendationRSI.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: RSI < 20 and starts to rise, indicating a very oversold condition and a strong buying opportunity.'**
  String get strongBuyRecommendationRSI;

  /// No description provided for @sellRecommendationRSI.
  ///
  /// In en, this message translates to:
  /// **'SELL: RSI > 70 and starts to fall, indicating an overbought condition and a potential selling opportunity.'**
  String get sellRecommendationRSI;

  /// No description provided for @strongSellRecommendationRSI.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: RSI > 80 and starts to fall, indicating a very overbought condition and a strong selling opportunity.'**
  String get strongSellRecommendationRSI;

  /// No description provided for @neutralRecommendationRSI.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: RSI between 30 and 70, indicating no clear overbought or oversold conditions.'**
  String get neutralRecommendationRSI;

  /// No description provided for @overboughtOversoldLevels.
  ///
  /// In en, this message translates to:
  /// **'Overbought/Oversold Levels'**
  String get overboughtOversoldLevels;

  /// No description provided for @overboughtOversoldLevelsRSIDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves identifying overbought and oversold conditions using the RSI indicator. When the RSI value exceeds 70, it\'s considered overbought, indicating a potential sell signal. Conversely, when the RSI value drops below 30, it\'s considered oversold, indicating a potential buy signal.'**
  String get overboughtOversoldLevelsRSIDesc;

  /// No description provided for @divergenceRSIDesc.
  ///
  /// In en, this message translates to:
  /// **'In this strategy, traders look for divergences between the price and the RSI indicator. A bullish divergence occurs when the price makes a lower low, but the RSI indicator forms a higher low, suggesting potential upward momentum. Conversely, a bearish divergence occurs when the price makes a higher high, but the RSI indicator forms a lower high, suggesting potential downward momentum.'**
  String get divergenceRSIDesc;

  /// No description provided for @trendConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Trend Confirmation'**
  String get trendConfirmation;

  /// No description provided for @trengConfirmationRSIDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves using the RSI indicator to confirm trends identified by other indicators or price action. When the RSI value confirms a bullish trend by staying above a certain threshold (e.g., 50), it reinforces the bullish bias. Similarly, when the RSI value confirms a bearish trend by staying below a certain threshold, it reinforces the bearish bias.'**
  String get trengConfirmationRSIDesc;

  /// No description provided for @understandingStochasticDesc.
  ///
  /// In en, this message translates to:
  /// **'The Stochastic Oscillator is a momentum indicator that compares a particular closing price of a security to a range of its prices over a certain period of time. It oscillates between 0 and 100 and is used to identify potential overbought or oversold conditions in a market.'**
  String get understandingStochasticDesc;

  /// No description provided for @buyRecommendationStochastic.
  ///
  /// In en, this message translates to:
  /// **'BUY: The stochastic indicator suggests a potential buying opportunity when SlowK and SlowD are low (below 20) and SlowK crosses above SlowD.'**
  String get buyRecommendationStochastic;

  /// No description provided for @strongBuyRecommendationStochastic.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: The stochastic indicator shows a strong buying signal when SlowK and SlowD are very low (below 10) and SlowK crosses above SlowD.'**
  String get strongBuyRecommendationStochastic;

  /// No description provided for @sellRecommendationStochastic.
  ///
  /// In en, this message translates to:
  /// **'SELL: The stochastic indicator suggests a potential selling opportunity when SlowK and SlowD are high (above 80) and SlowK crosses below SlowD.'**
  String get sellRecommendationStochastic;

  /// No description provided for @strongSellRecommendationStochastic.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: The stochastic indicator shows a strong selling signal when SlowK and SlowD are very high (above 90) and SlowK crosses below SlowD.'**
  String get strongSellRecommendationStochastic;

  /// No description provided for @neutralRecommendationStochastic.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: The stochastic indicator indicates a neutral condition when SlowK and SlowD are between 20 and 80, suggesting that there is no clear signal of overbought or oversold.'**
  String get neutralRecommendationStochastic;

  /// No description provided for @overboughtOversoldLevelsStochasticDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves identifying overbought and oversold conditions using the stochastic oscillator. When the %K line crosses above 80, it indicates overbought conditions and suggests a potential sell signal. Conversely, when the %K line crosses below 20, it indicates oversold conditions and suggests a potential buy signal.'**
  String get overboughtOversoldLevelsStochasticDesc;

  /// No description provided for @divergenceStochasticDesc.
  ///
  /// In en, this message translates to:
  /// **'In this strategy, traders look for divergences between the price and the stochastic oscillator. A bullish divergence occurs when the price makes a lower low, but the stochastic oscillator forms a higher low, suggesting potential upward momentum. Conversely, a bearish divergence occurs when the price makes a higher high, but the stochastic oscillator forms a lower high, suggesting potential downward momentum.'**
  String get divergenceStochasticDesc;

  /// No description provided for @trendConfirmationStochasticDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves using the stochastic oscillator to confirm trends identified by other indicators or price action. When the %K line confirms a bullish trend by staying above a certain threshold (e.g., 50), it reinforces the bullish bias. Similarly, when the %K line confirms a bearish trend by staying below a certain threshold, it reinforces the bearish bias.'**
  String get trendConfirmationStochasticDesc;

  /// No description provided for @understandingWilliamsRDesc.
  ///
  /// In en, this message translates to:
  /// **'The Williams %R (%R) indicator is a momentum oscillator that measures overbought or oversold levels. It oscillates between -100 and 0, where values above -20 are considered overbought and values below -80 are considered oversold.'**
  String get understandingWilliamsRDesc;

  /// No description provided for @buyRecommendationWilliamsR.
  ///
  /// In en, this message translates to:
  /// **'BUY: Williams %R is between -80 and -50, indicating an oversold condition and a potential buying opportunity.'**
  String get buyRecommendationWilliamsR;

  /// No description provided for @strongBuyRecommendationWilliamsR.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: Williams %R is below -80, indicating a very oversold condition and a strong buying opportunity.'**
  String get strongBuyRecommendationWilliamsR;

  /// No description provided for @sellRecommendationWilliamsR.
  ///
  /// In en, this message translates to:
  /// **'SELL: Williams %R is between -20 and -50, indicating an overbought condition and a potential selling opportunity.'**
  String get sellRecommendationWilliamsR;

  /// No description provided for @strongSellRecommendationWilliamsR.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: Williams %R is above -20, indicating a very overbought condition and a strong selling opportunity.'**
  String get strongSellRecommendationWilliamsR;

  /// No description provided for @neutralRecommendationWilliamsR.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: Williams %R doesn\'t present a clear signal of overbought or oversold conditions, suggesting a neutral condition.'**
  String get neutralRecommendationWilliamsR;

  /// No description provided for @overboughtOversoldLevelsWRDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves identifying overbought and oversold conditions using the Williams %R indicator. When the Williams %R value exceeds -20, it\'s considered overbought, indicating a potential sell signal. Conversely, when the Williams %R value drops below -80, it\'s considered oversold, indicating a potential buy signal.'**
  String get overboughtOversoldLevelsWRDesc;

  /// No description provided for @divergenceWRDesc.
  ///
  /// In en, this message translates to:
  /// **'In this strategy, traders look for divergences between the price and the Williams %R indicator. A bullish divergence occurs when the price makes a lower low, but the Williams %R indicator forms a higher low, suggesting potential upward momentum. Conversely, a bearish divergence occurs when the price makes a higher high, but the Williams %R indicator forms a lower high, suggesting potential downward momentum.'**
  String get divergenceWRDesc;

  /// No description provided for @trengConfirmationWRDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves using the Williams %R indicator to confirm trends identified by other indicators or price action. When the Williams %R value confirms a bullish trend by staying above a certain threshold (e.g., -50), it reinforces the bullish bias. Similarly, when the Williams %R value confirms a bearish trend by staying below a certain threshold, it reinforces the bearish bias.'**
  String get trengConfirmationWRDesc;

  /// No description provided for @movingAveragesCrossover.
  ///
  /// In en, this message translates to:
  /// **'Moving Averages Crossover'**
  String get movingAveragesCrossover;

  /// No description provided for @movingAveragesCrossoverDesc.
  ///
  /// In en, this message translates to:
  /// **'This strategy involves using two moving averages with different time periods. When the shorter moving average crosses above the longer one, it\'s considered a buy signal, indicating a possible uptrend. Conversely, when the shorter moving average crosses below the longer one, it\'s considered a sell signal, indicating a possible downtrend.'**
  String get movingAveragesCrossoverDesc;

  /// No description provided for @movingAveragesSupportResistance.
  ///
  /// In en, this message translates to:
  /// **'Moving Averages as Support and Resistance'**
  String get movingAveragesSupportResistance;

  /// No description provided for @movingAveragesSupportResistanceDesc.
  ///
  /// In en, this message translates to:
  /// **'In this strategy, a single moving average is used as a dynamic support or resistance level. When the price approaches the moving average from above, it may act as resistance, and when the price approaches from below, it may act as support. Traders may look for buying opportunities when the price bounces off the moving average from below and selling opportunities when the price bounces from above.'**
  String get movingAveragesSupportResistanceDesc;

  /// No description provided for @movingAveragesReversalSignal.
  ///
  /// In en, this message translates to:
  /// **'Moving Averages Reversal Signal'**
  String get movingAveragesReversalSignal;

  /// No description provided for @movingAveragesReversalSignalDesc.
  ///
  /// In en, this message translates to:
  /// **'Some traders use moving averages to identify potential reversal points in the market. For example, when the price significantly deviates from a particular moving average, it may indicate that the current trend is overextended and a reversal is likely. Traders may look for reversal signals when the price approaches the moving average again.'**
  String get movingAveragesReversalSignalDesc;

  /// No description provided for @simpleMovingAverage.
  ///
  /// In en, this message translates to:
  /// **'Simple Moving Average (SMA)'**
  String get simpleMovingAverage;

  /// No description provided for @simpleMovingAverageDesc.
  ///
  /// In en, this message translates to:
  /// **'The SMA is calculated by averaging the closing prices over a specified period. It smooths out price data to identify trends over a longer duration.'**
  String get simpleMovingAverageDesc;

  /// No description provided for @exponentialMovingAverage.
  ///
  /// In en, this message translates to:
  /// **'Exponential Moving Average (EMA)'**
  String get exponentialMovingAverage;

  /// No description provided for @exponentialMovingAverageDesc.
  ///
  /// In en, this message translates to:
  /// **'The EMA gives more weight to recent prices, making it more responsive to new information. It is useful for identifying short-term trends.'**
  String get exponentialMovingAverageDesc;

  /// No description provided for @weightedMovingAverage.
  ///
  /// In en, this message translates to:
  /// **'Weighted Moving Average (WMA)'**
  String get weightedMovingAverage;

  /// No description provided for @weightedMovingAverageDesc.
  ///
  /// In en, this message translates to:
  /// **'The WMA assigns different weights to each closing price within the given period, giving more importance to recent data points.'**
  String get weightedMovingAverageDesc;

  /// No description provided for @buyRecommendationMovingAverages.
  ///
  /// In en, this message translates to:
  /// **'BUY: If the last closing price is above the last moving average value.'**
  String get buyRecommendationMovingAverages;

  /// No description provided for @strongBuyRecommendationMovingAverages.
  ///
  /// In en, this message translates to:
  /// **'STRONG BUY: If the last closing price is more than 5% above the last moving average value.'**
  String get strongBuyRecommendationMovingAverages;

  /// No description provided for @sellRecommendationMovingAverages.
  ///
  /// In en, this message translates to:
  /// **'SELL: If the last closing price is below the last moving average value.'**
  String get sellRecommendationMovingAverages;

  /// No description provided for @strongSellRecommendationMovingAverages.
  ///
  /// In en, this message translates to:
  /// **'STRONG SELL: If the last closing price is more than 5% below the last moving average value.'**
  String get strongSellRecommendationMovingAverages;

  /// No description provided for @neutralRecommendationMovingAverages.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL: If the last closing price is equal to the last moving average value.'**
  String get neutralRecommendationMovingAverages;

  /// No description provided for @goldenCross.
  ///
  /// In en, this message translates to:
  /// **'Golden Cross'**
  String get goldenCross;

  /// No description provided for @goldenCrossDesc.
  ///
  /// In en, this message translates to:
  /// **'Golden Cross: Indicates a potential buy signal when the short-term moving average crosses above the long-term moving average.'**
  String get goldenCrossDesc;

  /// No description provided for @deathCross.
  ///
  /// In en, this message translates to:
  /// **'Death Cross'**
  String get deathCross;

  /// No description provided for @deathCrossDesc.
  ///
  /// In en, this message translates to:
  /// **'Death Cross: Indicates a potential sell signal when the short-term moving average crosses below the long-term moving average.'**
  String get deathCrossDesc;
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
