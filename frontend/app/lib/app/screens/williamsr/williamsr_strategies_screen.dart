// williamsr_strategies_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WilliamsRStrategiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.strategies,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                StrategyCard(
                  title:
                      AppLocalizations.of(context)!.understandingTheIndicator,
                  description:
                      AppLocalizations.of(context)!.understandingWilliamsRDesc,
                  icon: Icons.lightbulb_outline,
                ),
                StrategyCard(
                  title: AppLocalizations.of(context)!.overboughtOversoldLevels,
                  description: AppLocalizations.of(context)!
                      .overboughtOversoldLevelsWRDesc,
                  icon: Icons.analytics,
                ),
                StrategyCard(
                  title: AppLocalizations.of(context)!.divergence,
                  description: AppLocalizations.of(context)!.divergenceWRDesc,
                  icon: Icons.analytics,
                ),
                StrategyCard(
                  title: AppLocalizations.of(context)!.trendConfirmation,
                  description:
                      AppLocalizations.of(context)!.trengConfirmationWRDesc,
                  icon: Icons.analytics,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StrategyCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  StrategyCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
