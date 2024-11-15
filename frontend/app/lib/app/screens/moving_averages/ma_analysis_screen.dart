// ma_analysis_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ma_help_screen.dart';

class MAAnalysisScreen extends StatelessWidget {
  final Map<String, dynamic> movingAveragesData;

  const MAAnalysisScreen({Key? key, required this.movingAveragesData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insights, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.analysis,
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
            decoration: const BoxDecoration(
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
                  if (movingAveragesData.containsKey('moving_averages'))
                    _buildSection(
                      title: AppLocalizations.of(context)!.movingAverages,
                      icon: Icons.trending_up,
                      content: _buildMovingAveragesContent(context),
                    ),
                  if (movingAveragesData.containsKey('last_crossings') &&
                      (movingAveragesData['last_crossings'] as Map).isNotEmpty)
                    _buildSection(
                      title: AppLocalizations.of(context)!.lastCross,
                      icon: Icons.timeline,
                      content: _buildCrossingsContent(context),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovingAveragesContent(BuildContext context) {
    final entries = (movingAveragesData['moving_averages'] as Map).entries.map(
          (entry) => ListTile(
            title: Text(entry.key),
            subtitle: Text('${entry.value}'),
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: entries.toList(),
    );
  }

  Widget _buildCrossingsContent(BuildContext context) {
    final crossings = (movingAveragesData['last_crossings'] as Map).entries.map(
      (entry) {
        final crossingKey = entry.key;
        final type = entry.value['Type'];
        final date = entry.value['Date'];
        final value = entry.value['Value'];
        return ListTile(
          title: Text(crossingKey),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context)!.type}: ${_translateCrossType(context, type)}',
              ),
              Text('${AppLocalizations.of(context)!.date}: $date'),
              Text('${AppLocalizations.of(context)!.value}: $value'),
            ],
          ),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: crossings.toList(),
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

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
