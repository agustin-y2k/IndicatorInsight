// williamsr_recommendation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'williamsr_help_screen.dart';

class WilliamsRRecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> williamsRData;

  const WilliamsRRecommendationScreen({Key? key, required this.williamsRData})
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
                  builder: (context) => WilliamsRHelpScreen(),
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
                  if (williamsRData.containsKey('WilliamsR'))
                    _buildWilliamsRSection(
                      title: 'Williams %R',
                      content: _buildWilliamsRContent(),
                    ),
                  if (williamsRData.containsKey('Recommendation'))
                    _buildWilliamsRSection(
                      title: AppLocalizations.of(context)!.recommendation,
                      content: _buildRecommendationContent(
                        context,
                        williamsRData['Recommendation'],
                        williamsRData['Signal Strength'],
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

  Widget _buildWilliamsRSection(
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

  Widget _buildWilliamsRContent() {
    final williamsR = williamsRData['WilliamsR'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$williamsR'),
      ],
    );
  }

  Widget _buildRecommendationContent(
      BuildContext context, String recommendation, String signalStrength) {
    IconData icon;
    Color color;

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

    String translatedRecommendation =
        _translateRecommendation(context, recommendation);
    String translatedSignalStrength =
        _translateSignalStrength(context, signalStrength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              translatedRecommendation,
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
            '${AppLocalizations.of(context)!.signalStrength}: $translatedSignalStrength'),
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
      case 'Strong Oversold':
        return AppLocalizations.of(context)!.strongOversold;
      case 'Strong Overbought':
        return AppLocalizations.of(context)!.strongOverbought;
      case 'Moderate Oversold':
        return AppLocalizations.of(context)!.oversold;
      case 'Moderate Overbought':
        return AppLocalizations.of(context)!.overbought;
      case 'No clear signal':
      default:
        return AppLocalizations.of(context)!.noClearSignal;
    }
  }
}
