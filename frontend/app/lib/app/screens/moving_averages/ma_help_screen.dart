// ma_help_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MAHelpScreen extends StatelessWidget {
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
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildHelpSection(
                  context,
                  title: AppLocalizations.of(context)!.movingAverages,
                  icon: Icons.show_chart,
                  description: AppLocalizations.of(context)!.movingAveragesDesc,
                  items: [
                    AppLocalizations.of(context)!.smaDesc,
                    AppLocalizations.of(context)!.emaDesc,
                    AppLocalizations.of(context)!.wmaDesc,
                  ],
                ),
                _buildHelpSection(
                  context,
                  title: AppLocalizations.of(context)!.crossTypes,
                  icon: Icons.timeline,
                  description: AppLocalizations.of(context)!.crossTypesDesc,
                  items: [
                    AppLocalizations.of(context)!.goldenCrossDesc,
                    AppLocalizations.of(context)!.deathCrossDesc,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required List<String> items,
  }) {
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
            SizedBox(height: 10),
            ...items.map((item) => _buildListItem(context, item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String item) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 18,
            color: Colors.blueAccent,
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
