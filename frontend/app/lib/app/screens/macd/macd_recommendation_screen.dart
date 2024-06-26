// macd_recommendation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'macd_help_screen.dart';

class MACDRecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> macdData;

  const MACDRecommendationScreen({Key? key, required this.macdData})
      : super(key: key);

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
                fontSize: 20,
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
                  builder: (context) => MACDHelpScreen(),
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
                  if (macdData.containsKey('macd_line'))
                    _buildMACDSection(
                      title: AppLocalizations.of(context)!.data,
                      content: _buildMACDContent(context),
                    ),
                  if (macdData.containsKey('recommendation'))
                    _buildMACDSection(
                      title: AppLocalizations.of(context)!.recommendation,
                      content: _buildRecommendationContent(
                        context,
                        macdData['recommendation'],
                        macdData['description'],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _translateDescription(BuildContext context, String description) {
    switch (description) {
      case 'Bearish Divergence':
        return AppLocalizations.of(context)!.bearishDivergence;
      case 'MACD and signal in bullish territory':
        return AppLocalizations.of(context)!.macdSignalBullish;
      case 'Conflicting signals':
        return AppLocalizations.of(context)!.conflictingSignals;
      case 'Bullish Divergence':
        return AppLocalizations.of(context)!.bullishDivergence;
      case 'MACD and signal in bearish territory':
        return AppLocalizations.of(context)!.macdSignalBearish;
      case 'Neutral':
        return AppLocalizations.of(context)!.neutral;
      default:
        return description;
    }
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

  Widget _buildMACDSection({required String title, required Widget content}) {
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

  Widget _buildMACDContent(BuildContext context) {
    final macdLine = macdData['macd_line'];
    final signalLine = macdData['signal_line'];
    final histogram = macdData['histogram'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.macdLine}: $macdLine'),
        Text('${AppLocalizations.of(context)!.signalLine}: $signalLine'),
        Text('${AppLocalizations.of(context)!.histogram}: $histogram'),
      ],
    );
  }

  Widget _buildRecommendationContent(
      BuildContext context, String recommendation, String description) {
    IconData icon;
    Color color;
    String recommendationText =
        _translateRecommendation(context, recommendation);
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
        Text('${AppLocalizations.of(context)!.description}: $descriptionText'),
      ],
    );
  }
}
