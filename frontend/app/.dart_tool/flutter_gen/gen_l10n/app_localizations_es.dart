import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get register => 'Registro';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get badRequest => 'Solicitud incorrecta';

  @override
  String get emailOrPasswordIncorrect => 'Correo electrónico o contraseña incorrectos';

  @override
  String get userNotFound => 'Usuario no encontrado';

  @override
  String get internalServerError => 'Error interno del servidor';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String get unauthorized => 'No autorizado';

  @override
  String get pleaseFillAllFields => 'Por favor, complete todos los campos';

  @override
  String get userAlreadyExists => 'El usuario ya existe';

  @override
  String get invalidEmailFormat => 'Formato de correo electrónico inválido';

  @override
  String get invalidPasswordFormat => 'La contraseña debe tener al menos 8 caracteres y contener al menos un dígito, una letra mayúscula, una letra minúscula y un carácter especial';

  @override
  String get userRegisteredSuccessfully => 'Usuario registrado con éxito';

  @override
  String get data => 'Datos';

  @override
  String get pleaseEnterSymbol => 'Por favor, ingrese un símbolo';

  @override
  String get pleaseEnterPeriod => 'Por favor, ingrese al menos un período';

  @override
  String failedToCalculate(Object error) {
    return 'Error al calcular: $error';
  }

  @override
  String errorOccurred(Object error) {
    return 'Ocurrió un error: $error';
  }

  @override
  String get indicators => 'Indicadores';

  @override
  String get oscillator => 'Oscilador';

  @override
  String get movingAverages => 'Medias Móviles';

  @override
  String get movingAveragesType => 'Tipo de Medias Móviles';

  @override
  String get enterPeriod => 'Períodos (separados por comas)';

  @override
  String get stochasticOscillator => 'Oscilador Estocástico';

  @override
  String get bollingerBands => 'Bandas de Bollinger';

  @override
  String get parabolicSAR => 'SAR Parabólico';

  @override
  String get enterSymbol => 'Ingrese el símbolo';

  @override
  String get getRecommendation => 'Obtener Recomendación';

  @override
  String get viewChart => 'Ver Gráfico';

  @override
  String get strategies => 'Estrategias';

  @override
  String get help => 'Ayuda';

  @override
  String get recommendation => 'Recomendación';

  @override
  String get trendStrength => 'Fuerza de la Tendencia';

  @override
  String get lastCross => 'Último Cruce';

  @override
  String get reason => 'Razón';

  @override
  String get description => 'Descripción';

  @override
  String get buy => 'COMPRA';

  @override
  String get sell => 'VENTA';

  @override
  String get neutral => 'NEUTRAL';

  @override
  String get strongBuy => 'COMPRA FUERTE';

  @override
  String get strongSell => 'VENTA FUERTE';

  @override
  String get overbought => 'Sobrecompra';

  @override
  String get oversold => 'Sobreventa';

  @override
  String get strongOversold => 'Sobreventa Fuerte';

  @override
  String get strongOverbought => 'Sobrecompra Fuerte';

  @override
  String get noClearSignal => 'No hay una señal clara';

  @override
  String get signalStrength => 'Fuerza de la Señal';

  @override
  String get strongSignal => 'Señal Fuerte';

  @override
  String get moderateSignal => 'Señal Moderada';

  @override
  String get weakSignal => 'Señal Débil';

  @override
  String get bullishCross => 'Cruce Alcista';

  @override
  String get bearishCross => 'Cruce Bajista';

  @override
  String get divergence => 'Divergencia';

  @override
  String get entryExitSignal => 'Señal de Entrada/Salida';

  @override
  String get histogram => 'Histograma';

  @override
  String get signalLine => 'Línea de Señal';

  @override
  String get macdLine => 'Línea MACD';

  @override
  String get bullish => 'Alcista';

  @override
  String get bearish => 'Bajista';

  @override
  String get date => 'Fecha';

  @override
  String get value => 'Valor';

  @override
  String get type => 'Tipo';

  @override
  String get crossingPoints => 'Puntos de Cruce';

  @override
  String get adxIndicatorDetails => 'Detalles del Indicador ADX';

  @override
  String get currentADX => 'ADX Actual';

  @override
  String get currentDIPlus => 'DI+ Actual';

  @override
  String get currentDIMinus => 'DI- Actual';

  @override
  String get absenceOfClearTrend => 'Ausencia de una tendencia clara';

  @override
  String get clearBullishTrend => 'Tendencia alcista clara';

  @override
  String get clearBearishTrend => 'Tendencia bajista clara';

  @override
  String get sidewaysTrend => 'Tendencia lateral';

  @override
  String get strongBullishTrend => 'Tendencia alcista fuerte (posible pico)';

  @override
  String get strongBearishTrend => 'Tendencia bajista fuerte (posible pico)';

  @override
  String get veryStrongTrend => 'Tendencia muy fuerte (pico de tendencia)';

  @override
  String get understandingTheIndicator => 'Entendiendo el indicador';

  @override
  String get understandingADXDesc => 'El ADX es un indicador de análisis técnico utilizado para cuantificar la fuerza de una tendencia. Va de 0 a 100, con valores más altos indicando una tendencia más fuerte.';

  @override
  String get recommendationLogic => 'Lógica de la Recomendación:';

  @override
  String get recommendationLogicDescAdx => 'El valor ADX ayuda a determinar la fuerza de la tendencia:\n- Por debajo de 25: Ausencia de tendencia clara.\n- 25 a 40: Tendencia clara (alcista o bajista).\n- 40 a 50: Tendencia fuerte (posible pico).\n- Más de 50: Tendencia muy fuerte (pico de tendencia).';

  @override
  String get recommendationTypes => 'Tipos de Recomendación:';

  @override
  String get buyRecommendationAdx => 'COMPRA: El valor de ADX está por encima de 25 y el +DI cruza por encima del -DI, indicando una posible tendencia alcista.';

  @override
  String get sellRecommendationAdx => 'VENTA: El valor de ADX está por encima de 25 y el +DI cruza por debajo del -DI, indicando una posible tendencia bajista.';

  @override
  String get neutralRecommendationAdx => 'NEUTRAL: El valor de ADX está por debajo de 25, indicando una tendencia débil o ausente.';

  @override
  String get strongBuyRecommendationAdx => 'COMPRA FUERTE: El valor de ADX está por encima de 50 y el +DI cruza por encima del -DI, indicando una tendencia alcista muy fuerte.';

  @override
  String get strongSellRecommendationAdx => 'VENTA FUERTE: El valor de ADX está por encima de 50 y el +DI cruza por debajo del -DI, indicando una tendencia bajista muy fuerte.';

  @override
  String get adxDivergenceDesc => 'La divergencia del ADX ocurre cuando el movimiento del precio no es confirmado por el indicador ADX. Por ejemplo, si el precio está alcanzando nuevos máximos, pero el indicador ADX está alcanzando máximos más bajos, puede indicar una tendencia debilitada o una posible reversión.';

  @override
  String get adxEntryExitSignalDesc => 'Algunos operadores utilizan niveles de umbral ADX específicos como señales de entrada o salida. Por ejemplo, pueden ingresar a una operación cuando el ADX cruza por encima de cierto valor, lo que indica una tendencia fuerte, y salir cuando cae por debajo de otro umbral, lo que sugiere una tendencia debilitada. Estos niveles de umbral pueden variar según la estrategia del comerciante y las condiciones del mercado.';

  @override
  String get understandingBollingerBandsDesc => 'Las Bandas de Bollinger son un indicador de análisis técnico que consiste en tres líneas: la banda superior, la banda media (SMA) y la banda inferior. La posición del precio en relación con estas bandas puede proporcionar señales comerciales.';

  @override
  String get bollingerBandsLevels => 'Niveles de Bandas de Bollinger';

  @override
  String get bollingerBandsLevelsDesc => 'Las Bandas de Bollinger consisten en tres niveles:\n- Banda Superior: 2 desviaciones estándar por encima de la SMA.\n- Banda Media (SMA): Media Móvil Simple del precio.\n- Banda Inferior: 2 desviaciones estándar por debajo de la SMA.';

  @override
  String get buyRecommendationBollinger => 'COMPRA: El precio está por debajo de la banda inferior - Sobrevendido.';

  @override
  String get strongBuyRecommendationBollinger => 'COMPRA FUERTE: El precio está por debajo de la banda inferior - Sobrevendido con bandas anchas.';

  @override
  String get sellRecommendationBollinger => 'VENTA: El precio está por encima de la banda superior - Sobrecomprado.';

  @override
  String get strongSellRecommendationBollinger => 'VENTA FUERTE: El precio está por encima de la banda superior - Sobrecomprado con bandas anchas.';

  @override
  String get neutralRecommendationBollinger => 'NEUTRAL: Bandas estrechas - Neutral o Dentro de las bandas de Bollinger.';

  @override
  String get upperBand => 'Banda Superior';

  @override
  String get middleBand => 'Banda Media';

  @override
  String get lowerBand => 'Banda Inferior';

  @override
  String get bandWidth => 'Ancho de Banda';

  @override
  String get overboughtWideBands => 'Precio por encima de la banda superior - Sobrecompra con bandas anchas';

  @override
  String get bollingerBandsOverbought => 'Precio por encima de la banda superior - Sobrecompra';

  @override
  String get oversoldWideBands => 'Precio por debajo de la banda inferior - Sobreventa con bandas anchas';

  @override
  String get bollingerBandsOversold => 'Precio por debajo de la banda inferior - Sobreventa';

  @override
  String get narrowBandsNeutral => 'Precio cerca de la banda media - Sin una señal clara';

  @override
  String get withinBollingerBands => 'Precio dentro de las bandas - Sin una señal clara';

  @override
  String get bollinger_band_squeeze_title => 'Apretón de la banda de Bollinger';

  @override
  String get bollinger_band_squeeze_description => 'La estrategia de apreton de bandas de Bollinger se basa en el principio de que los períodos de baja volatilidad suelen ir seguidos de períodos de alta volatilidad. Cuando las bandas se juntan, indica que la volatilidad es baja y podría ocurrir una ruptura. Los operadores observan un movimiento de precios por encima o por debajo de las bandas como señal de una posible entrada.';

  @override
  String get bollinger_band_breakout_title => 'Ruptura de la banda de Bollinger';

  @override
  String get bollinger_band_breakout_description => 'La estrategia de ruptura de las bandas Bollinger busca que el precio rompa las bandas superior o inferior. Una ruptura por encima de la banda superior puede indicar que el precio se encuentra en una fuerte tendencia alcista, mientras que una ruptura por debajo de la banda inferior puede indicar una fuerte tendencia a la baja. Los operadores suelen utilizar esta estrategia para realizar operaciones en la dirección de la ruptura.';

  @override
  String get reversion_to_mean_title => 'Reversión a la media';

  @override
  String get reversion_to_mean_description => 'Esta estrategia supone que el precio tiende a volver a la banda media (la media móvil simple) después de tocar las bandas superior o inferior. Cuando el precio alcanza la banda superior, los operadores pueden buscar señales de venta, anticipando que el precio volverá a la media. Por el contrario, cuando el precio alcanza la banda inferior, los operadores pueden buscar señales de compra.';

  @override
  String get double_bottoms_and_tops_title => 'Dobles suelos y techos';

  @override
  String get double_bottoms_and_tops_description => 'Los dobles suelos y techos son patrones de inversión que se pueden identificar utilizando las Bandas de Bollinger. Un doble suelo ocurre cuando el precio alcanza dos mínimos alrededor del mismo nivel, a menudo con un mínimo más bajo tocando o yendo por debajo de la banda inferior, seguido de un repunte. Un doble techo ocurre cuando el precio alcanza dos máximos alrededor del mismo nivel, a menudo con un máximo superior tocando o superando la banda superior, seguido de una caída.';

  @override
  String get belowMiddleBand => 'Precio por debajo de la Banda Media';

  @override
  String get aboveMiddleBand => 'Precio por encima de la Banda Media';

  @override
  String get understandingMacdDesc => 'El MACD es un indicador de impulso que sigue la tendencia y muestra la relación entre dos promedios móviles del precio de un valor. Consta de la línea MACD, la línea de señal y el histograma.';

  @override
  String get buyRecommendationMacd => 'COMPRA: El MACD cruza por encima de la línea de señal, indicando una tendencia alcista';

  @override
  String get sellRecommendationMacd => 'VENTA: El MACD cruza por debajo de la línea de señal, indicando una tendencia bajista';

  @override
  String get neutralRecommendationMacd => 'NEUTRAL: No se identifica una señal clara por el indicador MACD, posiblemente debido a la proximidad entre el MACD y la línea de señal.';

  @override
  String get strongBuyRecommendationMacd => 'COMPRA FUERTE: El MACD cruza por encima de la línea de señal con un histograma creciente, indicando una fuerte tendencia alcista.';

  @override
  String get strongSellRecommendationMacd => 'VENTA FUERTE: El MACD cruza por debajo de la línea de señal con un histograma decreciente, indicando una fuerte tendencia bajista.';

  @override
  String get recommendationLogicDescMacd => 'Cuando la línea MACD cruza por encima de la línea de señal, se considera una señal alcista, lo que indica una posible oportunidad de compra. Por el contrario, cuando la línea MACD cruza por debajo de la línea de señal, se considera una señal bajista, lo que indica una posible oportunidad de venta.';

  @override
  String get macdLineSignalCorss => 'Cruce de Línea MACD y Línea de Señal';

  @override
  String get macdLineSignalCorssDesc => 'Esta estrategia implica identificar señales de compra y venta basadas en el cruce de la línea MACD y la línea de señal. Un cruce alcista ocurre cuando la línea MACD cruza por encima de la línea de señal, lo que indica una señal de compra potencial. Por el contrario, una señal bajista El cruce se produce cuando la línea MACD cruza por debajo de la línea de señal, lo que indica una posible señal de venta.';

  @override
  String get macdHistogram => 'Histograma MACD';

  @override
  String get macdHistogramDesc => 'En esta estrategia, los operadores buscan cambios en el histograma MACD. Cuando el histograma pasa de territorio negativo a positivo, sugiere un creciente impulso alcista. Por el contrario, cuando el histograma pasa de territorio positivo a negativo, sugiere un impulso bajista creciente.';

  @override
  String get macdDivergencePrice => 'Divergencia de Precio';

  @override
  String get macdDivergencePriceDesc => 'De manera similar a la divergencia del RSI, los operadores pueden utilizar la divergencia del MACD para identificar posibles cambios de tendencia. Se produce una divergencia alcista cuando el precio alcanza un mínimo más bajo, pero el indicador MACD forma un mínimo más alto. Por el contrario, se produce una divergencia bajista cuando el precio alcanza un máximo más alto, pero el indicador MACD forma un máximo más bajo.';

  @override
  String get bearishDivergence => 'Divergencia Bajista';

  @override
  String get macdSignalBullish => 'MACD y señal en territorio alcista';

  @override
  String get conflictingSignals => 'Señales Conflictivas';

  @override
  String get bullishDivergence => 'Divergencia Alcista';

  @override
  String get macdSignalBearish => 'MACD y señal en territorio bajista';

  @override
  String get currentParabolicSAR => 'SAR Parabólico Actual';

  @override
  String get previousParabolicSAR => 'SAR Parabólico Anterior';

  @override
  String get trendDirection => 'Dirección de la Tendencia';

  @override
  String get upwardTrend => 'Tendencia Alcista';

  @override
  String get downwardTrend => 'Tendencia Bajista';

  @override
  String get noClearTrend => 'Sin Tendencia Clara';

  @override
  String get buyRecommendationParabolicSAR => 'COMPRA: SAR está actualmente por debajo del precio, lo que indica una posible tendencia alcista.';

  @override
  String get strongBuyRecommendationParabolicSAR => 'COMPRA FUERTE: SAR está significativamente por debajo del precio, lo que indica una fuerte tendencia alcista.';

  @override
  String get sellRecommendationParabolicSAR => 'VENTA: SAR está actualmente por encima del precio, lo que indica una posible tendencia bajista.';

  @override
  String get strongSellRecommendationParabolicSAR => 'VENTA FUERTE: SAR está significativamente por encima del precio, lo que indica una fuerte tendencia bajista.';

  @override
  String get neutralRecommendationParabolicSAR => 'NEUTRAL: SAR no está significativamente por encima ni por debajo del precio, lo que sugiere la falta de una dirección clara de la tendencia.';

  @override
  String get understandingParabolicSARDesc => 'El SAR Parabólico (Stop and Reverse) es un indicador técnico que se utiliza para identificar posibles reversiones en la dirección del precio de un activo. Está representado por una serie de puntos encima o debajo del gráfico de precios, que indican la dirección potencial de la tendencia.';

  @override
  String get recommendationLogicItem1 => 'Si el valor SAR actual es mayor que el valor SAR anterior y el precio actual es mayor que el precio anterior, indica una tendencia alcista y una posible oportunidad de compra.';

  @override
  String get recommendationLogicItem2 => 'Si el valor SAR actual es menor que el valor SAR anterior y el precio actual es menor que el precio anterior, indica una tendencia bajista y una posible oportunidad de venta.';

  @override
  String get trendReversal => 'Reversión de Tendencia';

  @override
  String get trailingStopLoss => 'Stop Loss Dinámico';

  @override
  String get trendFollowing => 'Seguimiento de Tendencia';

  @override
  String get trendReversalDescription => 'Esta estrategia implica identificar posibles cambios de tendencia en función del movimiento del indicador Parabolic SAR. Una reversión desde arriba del precio hacia debajo del precio sugiere una posible reversión de la tendencia alcista, mientras que una reversión desde debajo del precio hasta por encima del precio sugiere una posible reversión de la tendencia bajista.';

  @override
  String get trailingStopLossDescription => 'En esta estrategia, los operadores utilizan el SAR Parabólico como mecanismo de stop loss dinámico. A medida que el precio se mueve a favor de la operación, el SAR Parabólico se acerca al precio, actuando como un nivel dinámico de parada de pérdidas. Si el precio se revierte y el SAR Parabólico cruza el precio, se activa un stop loss.';

  @override
  String get trendFollowingDescription => 'Los operadores pueden utilizar el SAR Parabólico para seguir la tendencia ingresando posiciones en la dirección del SAR. En una tendencia alcista, los operadores buscan señales de compra cuando el SAR se mueve por debajo del precio, lo que indica un impulso alcista. En una tendencia bajista, los operadores buscan señales de venta cuando el SAR se mueve por encima del precio, lo que indica un impulso bajista.';

  @override
  String get understandingRSIDesc => 'El índice de fuerza relativa (RSI) es un oscilador de impulso que mide la velocidad y el cambio de los movimientos de precios. Se utiliza principalmente para identificar condiciones de sobrecompra o sobreventa en un mercado.';

  @override
  String get buyRecommendationRSI => 'COMPRA: RSI < 30, indicando una condición de sobreventa y una posible oportunidad de compra.';

  @override
  String get strongBuyRecommendationRSI => 'COMPRA FUERTE: RSI < 20, indicando una condición muy sobrevendida y una fuerte oportunidad de compra.';

  @override
  String get sellRecommendationRSI => 'VENTA: RSI > 70, indicando una condición de sobrecompra y una posible oportunidad de venta.';

  @override
  String get strongSellRecommendationRSI => 'VENTA FUERTE: RSI > 80, indicando una condición muy sobrecomprada y una fuerte oportunidad de venta.';

  @override
  String get neutralRecommendationRSI => 'NEUTRAL: RSI entre 30 y 70, sin una señal clara.';

  @override
  String get overboughtOversoldLevels => 'Niveles de Sobrecompra/Sobreventa';

  @override
  String get overboughtOversoldLevelsRSIDesc => 'Esta estrategia implica identificar condiciones de sobrecompra y sobreventa utilizando el indicador RSI. Cuando el valor del RSI supera 70, se considera sobrecompra, lo que indica una posible señal de venta. Por el contrario, cuando el valor del RSI cae por debajo de 30, se considera sobrevendido, lo que indica una posible señal de compra.';

  @override
  String get divergenceRSIDesc => 'En esta estrategia, los operadores buscan divergencias entre el precio y el indicador RSI. Se produce una divergencia alcista cuando el precio alcanza un mínimo más bajo, pero el indicador RSI forma un mínimo más alto, lo que sugiere un posible impulso alcista. Por el contrario, se produce una divergencia bajista cuando el precio alcanza un máximo más alto, pero el indicador RSI forma un máximo más bajo, lo que sugiere un posible impulso a la baja.';

  @override
  String get trendConfirmation => 'Confirmación de Tendencia';

  @override
  String get trengConfirmationRSIDesc => 'Esta estrategia implica el uso del indicador RSI para confirmar las tendencias identificadas por otros indicadores o la acción del precio. Cuando el valor del RSI confirma una tendencia alcista manteniéndose por encima de un cierto umbral (por ejemplo, 50), refuerza el sesgo alcista. De manera similar, cuando el valor del RSI confirma una tendencia bajista al mantenerse por debajo de cierto umbral, refuerza el sesgo bajista.';

  @override
  String get understandingStochasticDesc => 'El oscilador estocástico es un indicador de impulso que compara un precio de cierre particular de un valor con un rango de sus precios durante un período de tiempo determinado. Oscila entre 0 y 100 y se utiliza para identificar posibles condiciones de sobrecompra o sobreventa en un mercado.';

  @override
  String get buyRecommendationStochastic => 'COMPRA: El indicador estocástico sugiere una posible oportunidad de compra cuando SlowK y SlowD son bajos (por debajo de 20) y SlowK cruza por encima de SlowD.';

  @override
  String get strongBuyRecommendationStochastic => 'COMPRA FUERTE: El indicador estocástico muestra una fuerte señal de compra cuando SlowK y SlowD son muy bajos (por debajo de 10) y SlowK cruza por encima de SlowD.';

  @override
  String get sellRecommendationStochastic => 'VENTA: El indicador estocástico sugiere una posible oportunidad de venta cuando SlowK y SlowD son altos (por encima de 80) y SlowK cruza por debajo de SlowD.';

  @override
  String get strongSellRecommendationStochastic => 'VENTA FUERTE: El indicador estocástico muestra una fuerte señal de venta cuando SlowK y SlowD son muy altos (por encima de 90) y SlowK cruza por debajo de SlowD.';

  @override
  String get neutralRecommendationStochastic => 'NEUTRAL: El indicador estocástico indica una condición neutral cuando SlowK y SlowD están entre 20 y 80, lo que sugiere que no hay una clara señal de sobrecompra o sobreventa.';

  @override
  String get overboughtOversoldLevelsStochasticDesc => 'Esta estrategia implica identificar condiciones de sobrecompra y sobreventa utilizando el oscilador estocástico. Cuando la línea %K cruza por encima de 80, indica condiciones de sobrecompra y sugiere una posible señal de venta. Por el contrario, cuando la línea %K cruza por debajo de 20, indica condiciones de sobreventa y sugiere una posible señal de compra.';

  @override
  String get divergenceStochasticDesc => 'En esta estrategia, los operadores buscan divergencias entre el precio y el oscilador estocástico. Se produce una divergencia alcista cuando el precio alcanza un mínimo más bajo, pero el oscilador estocástico forma un mínimo más alto, lo que sugiere un posible impulso alcista. Por el contrario, se produce una divergencia bajista cuando el precio alcanza un máximo más alto, pero el oscilador estocástico forma un máximo más bajo, lo que sugiere un posible impulso a la baja.';

  @override
  String get trendConfirmationStochasticDesc => 'Esta estrategia implica el uso del oscilador estocástico para confirmar tendencias identificadas por otros indicadores o la acción del precio. Cuando la línea %K confirma una tendencia alcista manteniéndose por encima de un cierto umbral (por ejemplo, 50), refuerza el sesgo alcista. De manera similar, cuando la línea %K confirma una tendencia bajista al permanecer por debajo de cierto umbral, refuerza el sesgo bajista.';

  @override
  String get understandingWilliamsRDesc => 'El indicador Williams %R (%R) es un oscilador de impulso que mide los niveles de sobrecompra o sobreventa. Oscila entre -100 y 0, donde los valores superiores a -20 se consideran sobrecomprados y los valores inferiores a -80 se consideran sobrevendidos. ';

  @override
  String get buyRecommendationWilliamsR => 'COMPRA: Williams %R se encuentra entre -80 y -50, indicando una condición de sobreventa y una posible oportunidad de compra.';

  @override
  String get strongBuyRecommendationWilliamsR => 'COMPRA FUERTE: Williams %R es inferior a -80, indicando una condición muy sobrevendida y una fuerte oportunidad de compra.';

  @override
  String get sellRecommendationWilliamsR => 'VENTA: Williams %R se encuentra entre -20 y -50, indicando una condición de sobrecompra y una posible oportunidad de venta.';

  @override
  String get strongSellRecommendationWilliamsR => 'VENTA FUERTE: Williams %R es superior a -20, indicando una condición muy sobrecomprada y una fuerte oportunidad de venta.';

  @override
  String get neutralRecommendationWilliamsR => 'NEUTRAL: Williams %R no presenta una señal clara de sobrecompra o sobreventa, lo que sugiere una condición neutral.';

  @override
  String get overboughtOversoldLevelsWRDesc => 'Esta estrategia implica identificar condiciones de sobrecompra y sobreventa utilizando el indicador Williams %R. Cuando el valor Williams %R supera -20, se considera sobrecomprado, lo que indica una posible señal de venta. Por el contrario, cuando el valor Williams %R cae por debajo de -80, se considera sobrevendido, lo que indica una posible señal de compra.';

  @override
  String get divergenceWRDesc => 'En esta estrategia, los operadores buscan divergencias entre el precio y el indicador Williams %R. Se produce una divergencia alcista cuando el precio alcanza un mínimo más bajo, pero el indicador Williams %R forma un mínimo más alto, lo que sugiere un potencial impulso alcista. Por el contrario, se produce una divergencia bajista cuando el precio alcanza un máximo más alto, pero el indicador Williams %R forma un máximo más bajo, lo que sugiere un posible impulso a la baja.';

  @override
  String get trengConfirmationWRDesc => 'Esta estrategia implica el uso del indicador Williams %R para confirmar las tendencias identificadas por otros indicadores o la acción del precio. Cuando el valor Williams %R confirma una tendencia alcista manteniéndose por encima de un cierto umbral (por ejemplo, -50), refuerza el sesgo alcista. De manera similar, cuando el valor Williams %R confirma una tendencia bajista al permanecer por debajo de cierto umbral, refuerza el sesgo bajista.';

  @override
  String get movingAveragesCrossover => 'Cruce de Medias Móviles';

  @override
  String get movingAveragesCrossoverDesc => 'Esta estrategia implica el uso de dos medias móviles con diferentes períodos de tiempo. Cuando la media móvil más corta cruza por encima de la más larga, se considera una señal de compra, lo que indica una posible tendencia alcista. Por el contrario, cuando la media móvil más corta cruza por debajo de la más larga, se considera una señal de venta, lo que indica una posible tendencia bajista.';

  @override
  String get movingAveragesSupportResistance => 'Medias Móviles como Soporte/Resistencia';

  @override
  String get movingAveragesSupportResistanceDesc => 'En esta estrategia, se utiliza una única media móvil como nivel de soporte o resistencia dinámico. Cuando el precio se acerca a la media móvil desde arriba, puede actuar como resistencia, y cuando el precio se acerca desde abajo, puede actuar como soporte. Los operadores pueden buscar oportunidades de compra cuando el precio rebota en el promedio móvil desde abajo y oportunidades de venta cuando el precio rebota desde arriba.';

  @override
  String get movingAveragesReversalSignal => 'Señal de Reversión de Medias Móviles';

  @override
  String get movingAveragesReversalSignalDesc => 'Algunos operadores utilizan promedios móviles para identificar posibles puntos de reversión en el mercado. Por ejemplo, cuando el precio se desvía significativamente de una media móvil particular, puede indicar que la tendencia actual está demasiado extendida y es probable que se produzca una reversión. Los operadores pueden buscar señales de reversión cuando el precio se acerque nuevamente a la media móvil.';

  @override
  String get simpleMovingAverage => 'Media Móvil Simple (SMA)';

  @override
  String get simpleMovingAverageDesc => 'La SMA se calcula promediando los precios de cierre durante un período específico. Suaviza los datos de precios para identificar tendencias a largo plazo.';

  @override
  String get exponentialMovingAverage => 'Media Móvil Exponencial (EMA)';

  @override
  String get exponentialMovingAverageDesc => 'La EMA da más peso a los precios recientes, lo que la hace más receptiva a la nueva información. Es útil para identificar tendencias a corto plazo.';

  @override
  String get weightedMovingAverage => 'Media Móvil Ponderada (WMA)';

  @override
  String get weightedMovingAverageDesc => 'La WMA asigna diferentes ponderaciones a cada precio de cierre dentro del período determinado, dando más importancia a los datos recientes.';

  @override
  String get buyRecommendationMovingAverages => 'COMPRA: Si el último precio de cierre está por encima del último valor del promedio móvil.';

  @override
  String get strongBuyRecommendationMovingAverages => 'COMPRA FUERTE: Si el último precio de cierre está más de un 5% por encima del último valor del promedio móvil.';

  @override
  String get sellRecommendationMovingAverages => 'VENTA: Si el último precio de cierre está por debajo del último valor del promedio móvil.';

  @override
  String get strongSellRecommendationMovingAverages => 'VENTA FUERTE: Si el último precio de cierre está más de un 5% por debajo del último valor del promedio móvil.';

  @override
  String get neutralRecommendationMovingAverages => 'NEUTRAL: Si el último precio de cierre es igual al último valor del promedio móvil.';

  @override
  String get goldenCross => 'Cruz Dorada';

  @override
  String get goldenCrossDesc => 'Cruz Dorada: Indica una señal de compra potencial cuando el promedio móvil de corto plazo cruza por encima del promedio móvil de largo plazo.';

  @override
  String get deathCross => 'Cruz de la Muerte';

  @override
  String get deathCrossDesc => 'Cruz de la Muerte: Indica una señal de venta potencial cuando el promedio móvil de corto plazo cruza por debajo del promedio móvil de largo plazo.';
}
