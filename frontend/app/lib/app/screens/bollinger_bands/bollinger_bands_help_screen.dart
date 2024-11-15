// bollinger_bands_help_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BollingerBandsHelpScreen extends StatelessWidget {
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
                  title: AppLocalizations.of(context)!.bollingerBandsLevels,
                  description:
                      AppLocalizations.of(context)!.bollingerBandsLevelsDesc,
                  icon: Icons.equalizer,
                ),
                HelpCard(
                  title: AppLocalizations.of(context)!.recommendationTypes,
=======
                  title: AppLocalizations.of(context)!.bollingerBands,
                  description: AppLocalizations.of(context)!.bollingerBandsDesc,
                  icon: Icons.insights,
                ),
                HelpCard(
                  title: AppLocalizations.of(context)!.analysis,
>>>>>>> develop
                  items: [
                    AppLocalizations.of(context)!.bBoverboughtHighVolatility,
                    AppLocalizations.of(context)!.bBoverbought,
                    AppLocalizations.of(context)!.bBoversoldHighVolatility,
                    AppLocalizations.of(context)!.bBoversold,
                    AppLocalizations.of(context)!.bBpotentialBreakout,
                    AppLocalizations.of(context)!.bBextendedNarrowBands,
                    AppLocalizations.of(context)!.bBwithinBands,
                  ],
<<<<<<< HEAD
                  icon: Icons.recommend,
=======
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

    if (item == AppLocalizations.of(context)!.bBoverbought ||
        item == AppLocalizations.of(context)!.bBoverboughtHighVolatility) {
      iconData = Icons.trending_up;
      iconColor = Colors.green;
    } else if (item == AppLocalizations.of(context)!.bBoversold ||
        item == AppLocalizations.of(context)!.bBoversoldHighVolatility) {
      iconData = Icons.trending_down;
      iconColor = Colors.red;
    } else if (item == AppLocalizations.of(context)!.bBpotentialBreakout ||
        item == AppLocalizations.of(context)!.bBextendedNarrowBands) {
      iconData = Icons.trending_flat;
      iconColor = Colors.orange;
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
