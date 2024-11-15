// bollinger_bands_analysis_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bollinger_bands_help_screen.dart';

class BollingerBandsAnalysisScreen extends StatelessWidget {
  final Map<String, dynamic> bollingerBandsData;

  const BollingerBandsAnalysisScreen({
    Key? key,
    required this.bollingerBandsData,
  }) : super(key: key);

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
              AppLocalizations.of(context)!.bollingerBands,
              style: TextStyle(
                fontSize: 24,
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
                  builder: (context) => BollingerBandsHelpScreen(),
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
                  if (bollingerBandsData.containsKey('UpperBand'))
                    _buildSection(
                      title: AppLocalizations.of(context)!.values,
                      content: _buildBollingerBandsContent(context),
                    ),
                  if (bollingerBandsData.containsKey('SignalStrength'))
                    _buildSection(
                      title: AppLocalizations.of(context)!.signalStrength,
                      content: _buildSignalStrengthContent(context),
                    ),
                  if (bollingerBandsData.containsKey('Description'))
                    _buildSection(
                      title: AppLocalizations.of(context)!.analysis,
                      content: _buildAnalysisContent(context),
                    ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildBollingerBandsContent(BuildContext context) {
    final upperBand = bollingerBandsData['UpperBand'] ?? 'N/A';
    final middleBand = bollingerBandsData['MiddleBand'] ?? 'N/A';
    final lowerBand = bollingerBandsData['LowerBand'] ?? 'N/A';
    final bandWidth = bollingerBandsData['BandWidth'] ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context)!.upperBand}: $upperBand'),
        SizedBox(height: 8),
        Text('${AppLocalizations.of(context)!.middleBand}: $middleBand'),
        SizedBox(height: 8),
        Text('${AppLocalizations.of(context)!.lowerBand}: $lowerBand'),
        SizedBox(height: 8),
        Text('${AppLocalizations.of(context)!.bandWidth}: $bandWidth'),
      ],
    );
  }

  Widget _buildSignalStrengthContent(BuildContext context) {
    final signalStrength = bollingerBandsData['SignalStrength'] ?? 'N/A';
    String signalStrengthText =
        _translateSignalStrength(context, signalStrength);

    return Text(
      signalStrengthText,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildAnalysisContent(BuildContext context) {
    final description = bollingerBandsData['Description'] ?? 'N/A';
    String descriptionText = _translateDescription(context, description);

    return Text(
      descriptionText,
      style: TextStyle(fontSize: 16),
    );
  }

  String _translateSignalStrength(BuildContext context, String signalStrength) {
    switch (signalStrength) {
      case 'Strong':
        return AppLocalizations.of(context)!.strongSignal;
      case 'Moderate':
        return AppLocalizations.of(context)!.moderateSignal;
      case 'Weak':
      default:
        return AppLocalizations.of(context)!.weakSignal;
    }
  }

  String _translateDescription(BuildContext context, String description) {
    switch (description) {
      case 'The price is above the upper band, indicating possible overbought condition with high volatility.':
        return AppLocalizations.of(context)!.bBoverboughtHighVolatility;
      case 'The price is above the upper band, which may suggest a potential overbought condition.':
        return AppLocalizations.of(context)!.bBoverbought;
      case 'The price is below the lower band, indicating possible oversold condition with high volatility.':
        return AppLocalizations.of(context)!.bBoversoldHighVolatility;
      case 'The price is below the lower band, which may suggest a potential oversold condition.':
        return AppLocalizations.of(context)!.bBoversold;
      case 'The price is above the middle band, indicating a mild upward trend.':
        return AppLocalizations.of(context)!.mildUpwardTrend;
      case 'The price is below the middle band, indicating a mild downward trend.':
        return AppLocalizations.of(context)!.mildDownwardTrend;
      case 'The bands have been narrow for a prolonged period, suggesting low volatility and a potential breakout pattern.':
        return AppLocalizations.of(context)!.bBextendedNarrowBands;
      case 'The price is within the Bollinger bands, indicating typical price movement within a neutral range.':
        return AppLocalizations.of(context)!.bBwithinBands;
      default:
        return description;
    }
  }
}
