// adx_recommendation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'adx_help_screen.dart';

class ADXRecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> adxData;

  const ADXRecommendationScreen({Key? key, required this.adxData})
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
                  builder: (context) => ADXHelpScreen(),
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
                  if (adxData.containsKey('current_adx'))
                    _buildADXSection(
                      title: AppLocalizations.of(context)!.adxIndicatorDetails,
                      content: _buildADXContent(context),
                    ),
                  if (adxData.containsKey('trend_strength'))
                    _buildADXSection(
                      title: AppLocalizations.of(context)!.trendStrength,
                      content: Text(_translateTrendStrength(
                          context, adxData['trend_strength'])),
                    ),
                  if (adxData.containsKey('last_cross'))
                    _buildADXSection(
                      title: AppLocalizations.of(context)!.lastCross,
                      content: Text(
                        '${_translateCrossType(context, adxData['last_cross']['Type'])} - ${adxData['last_cross']['Date']}',
                      ),
                    ),
                  if (adxData.containsKey('recommendation'))
                    _buildADXSection(
                      title: AppLocalizations.of(context)!.recommendation,
                      content: _buildRecommendationContent(
                          context, adxData['recommendation']),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _translateTrendStrength(BuildContext context, String trendStrength) {
    switch (trendStrength) {
      case 'Absence of clear trend':
        return AppLocalizations.of(context)!.absenceOfClearTrend;
      case 'Clear bullish trend':
        return AppLocalizations.of(context)!.clearBullishTrend;
      case 'Sideways trend':
        return AppLocalizations.of(context)!.sidewaysTrend;
      case 'Strong bullish trend (possible peak)':
        return AppLocalizations.of(context)!.strongBullishTrend;
      case 'Strong bearish trend (possible peak)':
        return AppLocalizations.of(context)!.strongBearishTrend;
      case 'Very strong trend (trend peak)':
        return AppLocalizations.of(context)!.veryStrongTrend;
      default:
        return trendStrength;
    }
  }

  String _translateCrossType(BuildContext context, String crossType) {
    switch (crossType) {
      case 'Bullish Cross':
        return AppLocalizations.of(context)!.bullishCross;
      case 'Bearish Cross':
        return AppLocalizations.of(context)!.bearishCross;
      default:
        return crossType;
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

  Widget _buildADXSection({required String title, required Widget content}) {
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

  Widget _buildADXContent(BuildContext context) {
    final currentADX = adxData['current_adx'];
    final currentDIPlus = adxData['current_di_plus'];
    final currentDIMinus = adxData['current_di_minus'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.currentADX}: $currentADX'),
        Text('${AppLocalizations.of(context)!.currentDIPlus}: $currentDIPlus'),
        Text(
            '${AppLocalizations.of(context)!.currentDIMinus}: $currentDIMinus'),
      ],
    );
  }

  Widget _buildRecommendationContent(
      BuildContext context, String recommendation) {
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

    return Row(
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
    );
  }
}
