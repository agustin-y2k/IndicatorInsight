import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get analysis => 'Análisis';

  @override
  String get help => 'Ayuda';

  @override
  String get indicators => 'Indicadores';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get pleaseFillAllFields => 'Por favor, complete todos los campos';

  @override
  String get userRegisteredSuccessfully => 'Usuario registrado exitosamente';

  @override
  String get invalidEmailFormat => 'Formato de correo electrónico inválido';

  @override
  String get invalidPasswordFormat => 'La contraseña debe tener al menos 8 caracteres, incluir un dígito, una letra mayúscula, una letra minúscula y un carácter especial';

  @override
  String get unknownError => 'Ocurrió un error desconocido';

  @override
  String get userAlreadyExists => 'El usuario ya existe';

  @override
  String get internalServerError => 'Error interno del servidor';

  @override
  String get badRequest => 'Solicitud incorrecta';

  @override
  String get emailOrPasswordIncorrect => 'Correo electrónico o contraseña incorrectos';

  @override
  String get userNotFound => 'Usuario no encontrado';

  @override
  String get noAccountRegister => '¿No tienes una cuenta? Regístrate';

  @override
  String get alreadyHaveAccountLogin => '¿Ya tienes una cuenta? Iniciar sesión';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get pleaseEnterEmail => 'Por favor, ingrese su correo electrónico';

  @override
  String get resetLinkSent => 'Se ha enviado un enlace de restablecimiento a su correo electrónico';

  @override
  String get sendResetLink => 'Enviar enlace de restablecimiento';

  @override
  String get passwordResetFailed => 'Fallo en el restablecimiento de contraseña';

  @override
  String get passwordResetSuccess => 'Restablecimiento de contraseña exitoso';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get resetPassword => 'Restablecer contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get enterResetCode => 'Ingrese el código de restablecimiento';

  @override
  String get verifyCode => 'Verificar código';

  @override
  String get invalidResetCode => 'Código de restablecimiento inválido';

  @override
  String get sendResetCode => 'Enviar código de restablecimiento';

  @override
  String get enterSymbol => 'Ingrese el Símbolo';

  @override
  String get selectInterval => 'Seleccione el Intervalo';

  @override
  String get intervalDaily => 'Diario';

  @override
  String get intervalWeekly => 'Semanal';

  @override
  String get intervalMonthly => 'Mensual';

  @override
  String get viewAnalysis => 'Ver Análisis';

  @override
  String get viewChart => 'Ver Gráfico';

  @override
  String get pleaseEnterSymbol => 'Por favor, ingrese un símbolo';

  @override
  String failedToCalculate(Object reason) {
    return 'Error al calcular. $reason';
  }

  @override
  String errorOccurred(Object errorMessage) {
    return 'Ocurrió un error: $errorMessage';
  }

  @override
  String get adx => 'ADX';

  @override
  String get values => 'Valores';

  @override
  String get enterADXPeriodWithDefault => 'Ingrese el Periodo ADX (Por defecto es 14)';

  @override
  String get trendStrength => 'Fuerza de la Tendencia';

  @override
  String get lastCross => 'Último Cruce';

  @override
  String get currentADX => 'ADX Actual';

  @override
  String get currentDIPlus => '+DI Actual';

  @override
  String get currentDIMinus => '-DI Actual';

  @override
  String get noSignificantTrend => 'No se detecta una tendencia significativa';

  @override
  String get moderateBullishTrend => 'Tendencia alcista moderada observada';

  @override
  String get moderateBearishTrend => 'Tendencia bajista moderada observada';

  @override
  String get sidewaysModerate => 'Tendencia lateral con fuerza moderada';

  @override
  String get strongBullishPeak => 'Tendencia alcista fuerte detectada, posible pico';

  @override
  String get strongBearishPeak => 'Tendencia bajista fuerte detectada, posible pico';

  @override
  String get veryStrongTrendNearPeak => 'Tendencia muy fuerte detectada, cerca del pico';

  @override
  String get bullishCross => 'Cruce Alcista';

  @override
  String get bearishCross => 'Cruce Bajista';

  @override
  String get adxExplanation => 'Explicación de ADX';

  @override
  String get adxExplanationDesc => 'El ADX (Índice Direccional Medio) es un indicador técnico utilizado para cuantificar la fuerza de la tendencia.';

  @override
  String get crossTypes => 'Tipos de Cruce';

  @override
  String get bollingerBands => 'Bandas de Bollinger';

  @override
  String get enterBBPeriodWithDefault => 'Ingrese el periodo de Bandas de Bollinger (por defecto es 20)';

  @override
  String get enterBBStdDevWithDefault => 'Ingrese la desviación estándar de Bandas de Bollinger (por defecto es 2)';

  @override
  String get upperBand => 'Banda Superior';

  @override
  String get middleBand => 'Banda Media';

  @override
  String get lowerBand => 'Banda Inferior';

  @override
  String get bandWidth => 'Ancho de Banda';

  @override
  String get signalStrength => 'Fuerza de Señal';

  @override
  String get description => 'Descripción';

  @override
  String get strongSignal => 'Señal Fuerte';

  @override
  String get moderateSignal => 'Señal Moderada';

  @override
  String get weakSignal => 'Señal Débil';

  @override
  String get bollingerBandsDesc => 'Las Bandas de Bollinger son un indicador de volatilidad utilizado en el análisis técnico para medir las fluctuaciones de precio de un activo financiero. Este indicador consiste en tres líneas: una línea media, que es una media móvil simple, y dos bandas por encima y por debajo que representan desviaciones estándar. Las bandas se expanden y contraen según la volatilidad del activo. Cuando el precio se acerca a la banda superior, el activo puede estar sobrecomprado; cuando se acerca a la banda inferior, puede estar sobrevendido. Los operadores utilizan las Bandas de Bollinger para identificar posibles puntos de compra y venta, períodos de alta o baja volatilidad, y para anticipar rupturas de precio cuando las bandas permanecen estrechas por un periodo prolongado.';

  @override
  String get calculateBBFailed => 'No se pudo calcular las Bandas de Bollinger';

  @override
  String get bBoverboughtHighVolatility => 'El precio está por encima de la banda superior, indicando una posible condición de sobrecompra con alta volatilidad.';

  @override
  String get bBoverbought => 'El precio está por encima de la banda superior, lo cual puede sugerir una condición de sobrecompra potencial.';

  @override
  String get bBoversoldHighVolatility => 'El precio está por debajo de la banda inferior, indicando una posible condición de sobreventa con alta volatilidad.';

  @override
  String get bBoversold => 'El precio está por debajo de la banda inferior, lo cual puede sugerir una condición de sobreventa potencial.';

  @override
  String get bBpotentialBreakout => 'Las bandas están estrechas, lo que sugiere baja volatilidad y un posible patrón de ruptura.';

  @override
  String get bBextendedNarrowBands => 'Las bandas han estado estrechas durante un período prolongado, lo que sugiere baja volatilidad con un alto potencial de ruptura.';

  @override
  String get bBwithinBands => 'El precio se encuentra dentro de las Bandas de Bollinger, indicando un movimiento de precio típico dentro de un rango neutral.';

  @override
  String get mildUpwardTrend => 'El precio está por encima de la banda media, indicando una leve tendencia al alza.';

  @override
  String get mildDownwardTrend => 'El precio está por debajo de la banda media, indicando una leve tendencia a la baja.';

  @override
  String get macd => 'MACD';

  @override
  String get macdLine => 'Línea MACD';

  @override
  String get signalLine => 'Línea de Señal';

  @override
  String get histogram => 'Histograma';

  @override
  String get trendAnalysis => 'Análisis de Tendencia';

  @override
  String get divergence => 'Divergencia';

  @override
  String get histogramAnalysis => 'Análisis del Histograma';

  @override
  String get macdbullishTrend => 'Alcista - La línea MACD está por encima de la línea de señal';

  @override
  String get macdbearishTrend => 'Bajista - La línea MACD está por debajo de la línea de señal';

  @override
  String get macdneutralTrend => 'Neutral - La línea MACD es igual a la línea de señal';

  @override
  String get macdbullishDivergence => 'Divergencia Alcista - La MACD disminuye mientras el precio aumenta';

  @override
  String get macdbearishDivergence => 'Divergencia Bajista - La MACD aumenta mientras el precio disminuye';

  @override
  String get noDivergence => 'No se detectó una divergencia significativa';

  @override
  String get histogramExpanding => 'El histograma se expande - la tendencia se fortalece';

  @override
  String get histogramContracting => 'El histograma se contrae - la tendencia se debilita';

  @override
  String get histogramStable => 'El histograma está estable - la tendencia permanece constante';

  @override
  String get macdLineDesc => 'La línea MACD se calcula como la diferencia entre las medias móviles exponenciales de 12 y 26 días, mostrando la dirección y el impulso de la tendencia.';

  @override
  String get signalLineDesc => 'La línea de señal es la media móvil exponencial de 9 días de la línea MACD, utilizada para identificar posibles señales de compra y venta mediante cruces.';

  @override
  String get histogramDesc => 'El histograma muestra la diferencia entre las líneas MACD y de señal, visualizando la fuerza de la tendencia.';

  @override
  String get macdTrendAnalysisDesc => 'El análisis de tendencia de MACD evalúa la relación entre las líneas MACD y de señal para indicar si la tendencia es alcista, bajista o neutral.';

  @override
  String get divergenceDesc => 'La divergencia ocurre cuando MACD y el precio se mueven en direcciones opuestas, señalando un posible cambio de tendencia.';

  @override
  String get histogramAnalysisDesc => 'El análisis del histograma examina los cambios en el tamaño del histograma para evaluar si la tendencia se fortalece, debilita o permanece estable.';

  @override
  String get movingAverages => 'Medias Móviles';

  @override
  String get movingAveragesDesc => 'Las medias móviles (MA) son indicadores que ayudan a suavizar los datos de precios para identificar tendencias. Aquí están los tipos comunes:';

  @override
  String get smaPeriods => 'Períodos SMA (separados por comas)';

  @override
  String get emaPeriods => 'Períodos EMA (separados por comas)';

  @override
  String get wmaPeriods => 'Períodos WMA (separados por comas)';

  @override
  String get goldenCross => 'Cruce Dorado';

  @override
  String get deathCross => 'Cruce de la Muerte';

  @override
  String get type => 'Tipo';

  @override
  String get date => 'Fecha';

  @override
  String get value => 'Valor';

  @override
  String get smaDesc => 'SMA (Media Móvil Simple): Promedio de precios durante un período específico.';

  @override
  String get emaDesc => 'EMA (Media Móvil Exponencial): Da más peso a los precios recientes, siendo más sensible a la nueva información.';

  @override
  String get wmaDesc => 'WMA (Media Móvil Ponderada): Asigna mayor peso a los precios recientes para una indicación de tendencia equilibrada.';

  @override
  String get crossTypesDesc => 'Los cruces entre medias móviles pueden indicar posibles cambios en la dirección de la tendencia.';

  @override
  String get goldenCrossDesc => 'Cruz Dorada: Ocurre cuando una MA de corto plazo cruza por encima de una MA de largo plazo, señalando una posible tendencia al alza.';

  @override
  String get deathCrossDesc => 'Cruz de la Muerte: Ocurre cuando una MA de corto plazo cruza por debajo de una MA de largo plazo, señalando una posible tendencia a la baja.';

  @override
  String get enterRSIPeriodWithDefault => 'Ingrese el Período RSI (Predeterminado es 14)';

  @override
  String get rsi => 'RSI';

  @override
  String get rsiIndicatorDetails => 'Detalles del Indicador RSI';

  @override
  String get rsiExplanationDesc => 'El Índice de Fuerza Relativa (RSI) es un oscilador de impulso que mide la velocidad y el cambio en los movimientos de precios. Los valores de RSI van de 0 a 100 y se usa comúnmente para identificar condiciones de sobrecompra o sobreventa.';

  @override
  String get rsiValue => 'Valor del RSI';

  @override
  String get rsiSmaValue => 'Valor del SMA del RSI';

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
  String get conditionDescription => 'La condición se basa en los niveles del RSI: sobrecompra (>= 70), sobreventa (<= 30) y neutral (entre 30 y 70).';

  @override
  String get trendDescription => 'La tendencia se determina por el nivel del RSI: alcista si está por encima de 50, bajista si está por debajo de 50 o neutral si está cerca de 50.';

  @override
  String get divergenceDescription => 'La divergencia compara la dirección del RSI y del precio. La divergencia alcista ocurre cuando el precio cae mientras el RSI sube, y la divergencia bajista ocurre cuando el precio sube mientras el RSI cae.';

  @override
  String get errorNoDataFound => 'No se encontraron datos para el símbolo';

  @override
  String get errorInsufficientData => 'Datos insuficientes para calcular el ADX';

  @override
  String get errorUnexpected => 'Ocurrió un error inesperado';

  @override
  String get providedByTradingView => 'Proporcionado por TradingView';
}
