// macd_analysis_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'macd_help_screen.dart';

class MACDAnalysisScreen extends StatelessWidget {
  final Map<String, dynamic> macdData;

  const MACDAnalysisScreen({Key? key, required this.macdData})
      : super(key: key);

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
              AppLocalizations.of(context)!.macd,
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
                  builder: (context) => MACDHelpScreen(),
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
                  if (macdData.containsKey('macd_line'))
                    _buildMACDSection(
                      title: AppLocalizations.of(context)!.macdLine,
                      content: _buildMACDContent(context),
                    ),
                  if (macdData.containsKey('trend_analysis'))
                    _buildMACDSection(
                      title: AppLocalizations.of(context)!.trendAnalysis,
                      content: Text(
                          _translateTrend(context, macdData['trend_analysis'])),
                    ),
                  if (macdData.containsKey('divergence'))
                    _buildMACDSection(
                      title: AppLocalizations.of(context)!.divergence,
                      content: Text(_translateDivergence(
                          context, macdData['divergence'])),
                    ),
                  if (macdData.containsKey('histogram_analysis'))
                    _buildMACDSection(
                      title: AppLocalizations.of(context)!.histogramAnalysis,
                      content: Text(_translateHistogram(
                          context, macdData['histogram_analysis'])),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMACDSection({required String title, required Widget content}) {
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

  Widget _buildMACDContent(BuildContext context) {
    final macdLine = macdData['macd_line'];
    final signalLine = macdData['signal_line'];
    final histogram = macdData['histogram'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.macdLine}: $macdLine'),
        Text('${AppLocalizations.of(context)!.signalLine}: $signalLine'),
        Text('${AppLocalizations.of(context)!.histogram}: $histogram'),
      ],
    );
  }

  String _translateTrend(BuildContext context, String trend) {
    switch (trend) {
      case 'Bullish - MACD line is above the Signal line':
        return AppLocalizations.of(context)!.macdbullishTrend;
      case 'Bearish - MACD line is below the Signal line':
        return AppLocalizations.of(context)!.macdbearishTrend;
      case 'Neutral - MACD line is equal to the Signal line':
      default:
        return AppLocalizations.of(context)!.macdneutralTrend;
    }
  }

  String _translateDivergence(BuildContext context, String divergence) {
    switch (divergence) {
      case 'Bullish Divergence - MACD falling while price is rising':
        return AppLocalizations.of(context)!.macdbullishDivergence;
      case 'Bearish Divergence - MACD rising while price is falling':
        return AppLocalizations.of(context)!.macdbearishDivergence;
      default:
        return AppLocalizations.of(context)!.noDivergence;
    }
  }

  String _translateHistogram(BuildContext context, String histogram) {
    switch (histogram) {
      case 'Histogram expanding - trend strengthening':
        return AppLocalizations.of(context)!.histogramExpanding;
      case 'Histogram contracting - trend weakening':
        return AppLocalizations.of(context)!.histogramContracting;
      default:
        return AppLocalizations.of(context)!.histogramStable;
    }
  }
}
