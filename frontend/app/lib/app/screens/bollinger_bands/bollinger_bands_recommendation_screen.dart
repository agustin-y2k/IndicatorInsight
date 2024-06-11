// bollinger_bands_recommendation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bollinger_bands_help_screen.dart';

class BollingerBandsRecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> bollingerBandsData;

  const BollingerBandsRecommendationScreen({
    Key? key,
    required this.bollingerBandsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.thumb_up, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.recommendation,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BollingerBandsHelpScreen(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (bollingerBandsData.containsKey('UpperBand'))
                    _buildBollingerBandsSection(
                      title: AppLocalizations.of(context)!.bollingerBands,
                      content: _buildBollingerBandsContent(context),
                    ),
                  if (bollingerBandsData.containsKey('Recommendation'))
                    _buildRecommendationSection(
                      title: AppLocalizations.of(context)!.recommendation,
                      content: _buildRecommendationContent(context),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBollingerBandsSection(
      {required String title, required Widget content}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildBollingerBandsContent(BuildContext context) {
    final upperBand = bollingerBandsData['UpperBand'];
    final middleBand = bollingerBandsData['MiddleBand'];
    final lowerBand = bollingerBandsData['LowerBand'];
    final bandWidth = bollingerBandsData['BandWidth'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.upperBand}: $upperBand'),
        SizedBox(height: 8),
        Text('${AppLocalizations.of(context)!.middleBand}: $middleBand'),
        SizedBox(height: 8),
        Text('${AppLocalizations.of(context)!.lowerBand}: $lowerBand'),
        SizedBox(height: 8),
        Text('${AppLocalizations.of(context)!.bandWidth}: $bandWidth'),
      ],
    );
  }

  Widget _buildRecommendationSection(
      {required String title, required Widget content}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationContent(BuildContext context) {
    final recommendation = bollingerBandsData['Recommendation'];
    final signalStrength = bollingerBandsData['SignalStrength'];
    final description = bollingerBandsData['Description'];

    IconData icon;
    Color color;
    String recommendationText =
        _translateRecommendation(context, recommendation);
    String signalStrengthText =
        _translateSignalStrength(context, signalStrength);
    String descriptionText = _translateDescription(context, description);

    switch (recommendation) {
      case 'BUY':
        icon = Icons.arrow_upward;
        color = Colors.green;
        break;
      case 'SELL':
        icon = Icons.arrow_downward;
        color = Colors.red;
        break;
      case 'STRONG BUY':
        icon = Icons.arrow_upward;
        color = Color.fromARGB(255, 0, 90, 5);
        break;
      case 'STRONG SELL':
        icon = Icons.arrow_downward;
        color = Color.fromARGB(255, 128, 0, 0);
        break;
      case 'NEUTRAL':
      default:
        icon = Icons.horizontal_rule;
        color = Colors.grey;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              recommendationText,
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
            '${AppLocalizations.of(context)!.signalStrength}: $signalStrengthText'),
        SizedBox(height: 8),
        Text('${AppLocalizations.of(context)!.description}: $descriptionText'),
      ],
    );
  }

  String _translateRecommendation(BuildContext context, String recommendation) {
    switch (recommendation) {
      case 'BUY':
        return AppLocalizations.of(context)!.buy;
      case 'SELL':
        return AppLocalizations.of(context)!.sell;
      case 'NEUTRAL':
        return AppLocalizations.of(context)!.neutral;
      case 'STRONG BUY':
        return AppLocalizations.of(context)!.strongBuy;
      case 'STRONG SELL':
        return AppLocalizations.of(context)!.strongSell;
      default:
        return recommendation;
    }
  }

  String _translateSignalStrength(BuildContext context, String signalStrength) {
    switch (signalStrength) {
      case 'Strong':
        return AppLocalizations.of(context)!.strongSignal;
      case 'Moderate':
        return AppLocalizations.of(context)!.moderateSignal;
      case 'Weak':
      default:
        return AppLocalizations.of(context)!.weakSignal;
    }
  }

  String _translateDescription(BuildContext context, String description) {
    // Aquí puedes implementar tu propia lógica para traducir las descripciones
    // en función de las cadenas proporcionadas.
    switch (description) {
      case 'Price above Upper Band - Overbought with Wide Bands':
        return AppLocalizations.of(context)!.overboughtWideBands;
      case 'Price above Upper Band - Overbought':
        return AppLocalizations.of(context)!.bollingerBandsOverbought;
      case 'Price below Lower Band - Oversold with Wide Bands':
        return AppLocalizations.of(context)!.oversoldWideBands;
      case 'Price below Lower Band - Oversold':
        return AppLocalizations.of(context)!.bollingerBandsOversold;
      case 'Narrow Bands - Neutral':
        return AppLocalizations.of(context)!.narrowBandsNeutral;
      case 'Within Bollinger Bands':
        return AppLocalizations.of(context)!.withinBollingerBands;
      default:
        return description;
    }
  }
}
