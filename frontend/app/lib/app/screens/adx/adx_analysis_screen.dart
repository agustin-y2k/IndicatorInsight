// adx_analysis_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'adx_help_screen.dart';

class ADXAnalysisScreen extends StatelessWidget {
  final Map<String, dynamic> adxData;

  const ADXAnalysisScreen({Key? key, required this.adxData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.analytics, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.adx,
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
                  if (adxData.containsKey('error'))
                    _buildErrorSection(context, adxData['error']),
                  if (adxData.containsKey('current_adx'))
                    _buildADXSection(
                      title: AppLocalizations.of(context)!.values,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection(BuildContext context, String error) {
    return Card(
      color: Colors.redAccent,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          AppLocalizations.of(context)!.errorOccurred(error),
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _translateTrendStrength(BuildContext context, String trendStrength) {
    switch (trendStrength) {
      case 'No significant trend detected':
        return AppLocalizations.of(context)!.noSignificantTrend;
      case 'Moderate bullish trend observed':
        return AppLocalizations.of(context)!.moderateBullishTrend;
      case 'Moderate bearish trend observed':
        return AppLocalizations.of(context)!.moderateBearishTrend;
      case 'Sideways trend with moderate strength':
        return AppLocalizations.of(context)!.sidewaysModerate;
      case 'Strong bullish trend detected, possible peak':
        return AppLocalizations.of(context)!.strongBullishPeak;
      case 'Strong bearish trend detected, possible peak':
        return AppLocalizations.of(context)!.strongBearishPeak;
      case 'Very strong trend detected, near peak strength':
        return AppLocalizations.of(context)!.veryStrongTrendNearPeak;
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
}
