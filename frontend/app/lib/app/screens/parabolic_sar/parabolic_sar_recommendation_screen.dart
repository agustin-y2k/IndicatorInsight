// parabolic_sar_recommendation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'parabolic_sar_help_screen.dart';

class ParabolicSARRecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> parabolicSARData;

  const ParabolicSARRecommendationScreen({
    Key? key,
    required this.parabolicSARData,
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
                  builder: (context) => ParabolicSARHelpScreen(),
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
                  if (parabolicSARData.containsKey('current_sar'))
                    _buildSARSection(
                      title: AppLocalizations.of(context)!.currentParabolicSAR,
                      content: _buildSARContent(
                        '${parabolicSARData['current_sar']}',
                      ),
                    ),
                  if (parabolicSARData.containsKey('previous_sar'))
                    _buildSARSection(
                      title: AppLocalizations.of(context)!.previousParabolicSAR,
                      content: _buildSARContent(
                        '${parabolicSARData['previous_sar']}',
                      ),
                    ),
                  if (parabolicSARData.containsKey('trend_direction'))
                    _buildSARSection(
                      title: AppLocalizations.of(context)!.trendDirection,
                      content: Text(
                        _translateTrendDirection(
                          context,
                          parabolicSARData['trend_direction'],
                        ),
                      ),
                    ),
                  if (parabolicSARData.containsKey('recommendation'))
                    _buildSARSection(
                      title: AppLocalizations.of(context)!.recommendation,
                      content: _buildRecommendationContent(
                        context,
                        parabolicSARData['recommendation'],
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

  Widget _buildSARSection({required String title, required Widget content}) {
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

  Widget _buildSARContent(String value) {
    return Text(value);
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

  String _translateTrendDirection(BuildContext context, String trendDirection) {
    switch (trendDirection) {
      case 'Upward Trend':
        return AppLocalizations.of(context)!.upwardTrend;
      case 'Downward Trend':
        return AppLocalizations.of(context)!.downwardTrend;
      case 'No Clear Trend':
      default:
        return AppLocalizations.of(context)!.noClearTrend;
    }
  }
}
