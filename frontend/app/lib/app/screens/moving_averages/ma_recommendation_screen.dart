// ma_recommendation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ma_help_screen.dart';

class MARecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> movingAveragesData;

  const MARecommendationScreen({Key? key, required this.movingAveragesData})
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
                  builder: (context) => MAHelpScreen(),
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
                  if (movingAveragesData.containsKey('moving_averages') ||
                      movingAveragesData.containsKey('recommendation'))
                    _buildCombinedSection(
                      title: AppLocalizations.of(context)!.recommendation,
                      icon: Icons.show_chart,
                      content: _buildCombinedContent(context),
                    ),
                  if (movingAveragesData.containsKey('last_crossing') &&
                      (movingAveragesData['last_crossing'] as Map).isNotEmpty)
                    _buildSection(
                      title: AppLocalizations.of(context)!.lastCross,
                      icon: Icons.timeline,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: movingAveragesData['last_crossing']
                            .entries
                            .map<Widget>((entry) {
                          final type = entry.value['Type'];
                          final date = entry.value['Date'];
                          final value = entry.value['Value'];
                          return ListTile(
                            title: Text(_translateCrossType(context, type)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.date}: $date',
                                ),
                                Text(
                                  '${AppLocalizations.of(context)!.value}: $value',
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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

  String _translateCrossType(BuildContext context, String crossType) {
    switch (crossType) {
      case 'Golden Cross':
        return AppLocalizations.of(context)!.goldenCross;
      case 'Death Cross':
        return AppLocalizations.of(context)!.deathCross;
      default:
        return crossType;
    }
  }

  Widget _buildCombinedSection(
      {required String title,
      required IconData icon,
      required Widget content}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedContent(BuildContext context) {
    List<Widget> combinedEntries = [];

    movingAveragesData['moving_averages'].forEach((key, value) {
      combinedEntries.add(ListTile(
        title: Text('$key'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$value'),
            if (movingAveragesData['recommendation'].containsKey(key))
              _buildRecommendationContent(
                  context, movingAveragesData['recommendation'][key]),
          ],
        ),
      ));
    });

    movingAveragesData['recommendation'].forEach((key, value) {
      if (!movingAveragesData['moving_averages'].containsKey(key)) {
        combinedEntries.add(ListTile(
          title: Text('$key'),
          subtitle: _buildRecommendationContent(context, value),
        ));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: combinedEntries,
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

  Widget _buildSection(
      {required String title,
      required IconData icon,
      required Widget content}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
}
