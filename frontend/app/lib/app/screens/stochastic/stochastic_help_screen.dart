// stochasitc help screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StochasticHelpScreen extends StatelessWidget {
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
                  title:
                      AppLocalizations.of(context)!.understandingTheIndicator,
                  description:
                      AppLocalizations.of(context)!.understandingStochasticDesc,
                  icon: Icons.lightbulb_outline,
                ),
                HelpCard(
                  title: AppLocalizations.of(context)!.recommendationTypes,
                  items: [
                    AppLocalizations.of(context)!.buyRecommendationStochastic,
                    AppLocalizations.of(context)!
                        .strongBuyRecommendationStochastic,
                    AppLocalizations.of(context)!.sellRecommendationStochastic,
                    AppLocalizations.of(context)!
                        .strongSellRecommendationStochastic,
                    AppLocalizations.of(context)!
                        .neutralRecommendationStochastic,
                  ],
                  icon: Icons.lightbulb,
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

    if (item == AppLocalizations.of(context)!.buyRecommendationStochastic) {
      iconData = Icons.arrow_upward;
      iconColor = Colors.green;
    } else if (item ==
        AppLocalizations.of(context)!.sellRecommendationStochastic) {
      iconData = Icons.arrow_downward;
      iconColor = Colors.red;
    } else if (item ==
        AppLocalizations.of(context)!.strongBuyRecommendationStochastic) {
      iconData = Icons.arrow_upward;
      iconColor = Color.fromARGB(255, 0, 90, 5);
    } else if (item ==
        AppLocalizations.of(context)!.strongSellRecommendationStochastic) {
      iconData = Icons.arrow_downward;
      iconColor = Color.fromARGB(255, 128, 0, 0);
    } else {
      iconData = Icons.radio_button_unchecked;
      iconColor = Colors.blue;
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
