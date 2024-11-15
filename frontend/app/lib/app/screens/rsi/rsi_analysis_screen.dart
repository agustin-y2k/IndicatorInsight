// rsi_analysis_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'rsi_help_screen.dart';

class RSIAnalysisScreen extends StatelessWidget {
  final Map<String, dynamic> rsiData;

  const RSIAnalysisScreen({Key? key, required this.rsiData}) : super(key: key);

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
              AppLocalizations.of(context)!.rsi,
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
                  builder: (context) => RSIHelpScreen(),
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
                  if (rsiData.containsKey('error'))
                    _buildErrorSection(context, rsiData['error']),
                  if (rsiData.containsKey('RSI'))
                    _buildSection(
                      title: AppLocalizations.of(context)!.rsiIndicatorDetails,
                      content: _buildRSIContent(context),
                    ),
                  if (rsiData.containsKey('Interpretation'))
                    _buildInterpretationSections(context),
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

  Widget _buildSection({required String title, required Widget content}) {
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

  Widget _buildRSIContent(BuildContext context) {
    final rsi = rsiData['RSI'];
    final rsiSma = rsiData['RSI_SMA'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.rsiValue}: $rsi'),
        Text('${AppLocalizations.of(context)!.rsiSmaValue}: $rsiSma'),
      ],
    );
  }

  Widget _buildInterpretationSections(BuildContext context) {
    final interpretation = rsiData['Interpretation'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSection(
          title: AppLocalizations.of(context)!.condition,
          content: Text(_translateInterpretation(
              context, interpretation['Condition'] ?? 'N/A')),
        ),
        _buildSection(
          title: AppLocalizations.of(context)!.trend,
          content: Text(_translateInterpretation(
              context, interpretation['Trend'] ?? 'N/A')),
        ),
        _buildSection(
          title: AppLocalizations.of(context)!.divergence,
          content: Text(_translateInterpretation(
              context, interpretation['Divergence'] ?? 'N/A')),
        ),
      ],
    );
  }

  String _translateInterpretation(BuildContext context, String interpretation) {
    switch (interpretation) {
      case 'Overbought':
        return AppLocalizations.of(context)!.rsioverbought;
      case 'Oversold':
        return AppLocalizations.of(context)!.rsioversold;
      case 'Neutral':
        return AppLocalizations.of(context)!.rsineutral;
      case 'Bullish Trend':
        return AppLocalizations.of(context)!.rsibullishTrend;
      case 'Bearish Trend':
        return AppLocalizations.of(context)!.rsibearishTrend;
      case 'Bullish Divergence':
        return AppLocalizations.of(context)!.rsibullishDivergence;
      case 'Bearish Divergence':
        return AppLocalizations.of(context)!.rsibearishDivergence;
      case 'No Clear Divergence':
        return AppLocalizations.of(context)!.rsinoClearDivergence;
      default:
        return interpretation;
    }
  }
}
