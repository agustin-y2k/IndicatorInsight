// rsi_help_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RSIHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.help_outline, color: Colors.white),
            SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.help,
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
            decoration: BoxDecoration(
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
                HelpCard(
<<<<<<< HEAD
                  title: AppLocalizations.of(context)!.recommendationTypes,
=======
                  title: AppLocalizations.of(context)!.rsiIndicatorDetails,
                  description: AppLocalizations.of(context)!.rsiExplanationDesc,
                  icon: Icons.show_chart,
                ),
                HelpCard(
                  title: AppLocalizations.of(context)!.condition,
                  description:
                      AppLocalizations.of(context)!.conditionDescription,
>>>>>>> develop
                  items: [
                    AppLocalizations.of(context)!.rsioverbought,
                    AppLocalizations.of(context)!.rsioversold,
                    AppLocalizations.of(context)!.rsineutral,
                  ],
<<<<<<< HEAD
                  icon: Icons.recommend,
=======
                  icon: Icons.thermostat,
                ),
                HelpCard(
                  title: AppLocalizations.of(context)!.trend,
                  description: AppLocalizations.of(context)!.trendDescription,
                  items: [
                    AppLocalizations.of(context)!.rsibullishTrend,
                    AppLocalizations.of(context)!.rsibearishTrend,
                    AppLocalizations.of(context)!.rsineutral,
                  ],
                  icon: Icons.trending_up,
                ),
                HelpCard(
                  title: AppLocalizations.of(context)!.divergence,
                  description:
                      AppLocalizations.of(context)!.divergenceDescription,
                  items: [
                    AppLocalizations.of(context)!.rsibullishDivergence,
                    AppLocalizations.of(context)!.rsibearishDivergence,
                    AppLocalizations.of(context)!.rsinoClearDivergence,
                  ],
                  icon: Icons.compare_arrows,
>>>>>>> develop
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HelpCard extends StatelessWidget {
  final String title;
  final String? description;
  final List<String>? items;
  final IconData icon;

  HelpCard({
    required this.title,
    this.description,
    this.items,
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
            if (description != null) ...[
              SizedBox(height: 10),
              Text(
                description!,
                style: TextStyle(fontSize: 16),
              ),
            ],
            if (items != null)
              ...items!.map((item) => _buildListItem(context, item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String item) {
    IconData iconData;
    Color iconColor;

    if (item == AppLocalizations.of(context)!.rsibullishTrend ||
        item == AppLocalizations.of(context)!.rsibullishDivergence) {
      iconData = Icons.arrow_upward;
      iconColor = Colors.green;
    } else if (item == AppLocalizations.of(context)!.rsibearishTrend ||
        item == AppLocalizations.of(context)!.rsibearishDivergence) {
      iconData = Icons.arrow_downward;
      iconColor = Colors.red;
    } else if (item == AppLocalizations.of(context)!.rsioverbought) {
      iconData = Icons.trending_up;
      iconColor = Colors.orange;
    } else if (item == AppLocalizations.of(context)!.rsioversold) {
      iconData = Icons.trending_down;
      iconColor = Colors.blueAccent;
    } else {
      iconData = Icons.radio_button_unchecked;
      iconColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: 18,
            color: iconColor,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
