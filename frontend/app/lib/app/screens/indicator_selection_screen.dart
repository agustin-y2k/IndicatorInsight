// indicator_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'moving_averages/ma_input_screen.dart';
import 'rsi/rsi_input_screen.dart';
import 'adx/adx_input_screen.dart';
import 'macd/macd_input_screen.dart';
import 'bollinger_bands/bollinger_bands_input_screen.dart';

class IndicatorSelectionScreen extends StatelessWidget {
  const IndicatorSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.ads_click, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.indicators,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildIndicatorButton(
                    context,
                    AppLocalizations.of(context)!.movingAverages,
                    const MovingAveragesScreen(),
                  ),
                  SizedBox(height: 16),
                  _buildIndicatorButton(
                    context,
                    'RSI',
                    const RSIInputScreen(),
                  ),
                  SizedBox(height: 16),
                  _buildIndicatorButton(
                    context,
                    'ADX',
                    const ADXInputScreen(),
                  ),
                  SizedBox(height: 16),
                  _buildIndicatorButton(
                    context,
                    'MACD',
                    const MACDInputScreen(),
                  ),
                  SizedBox(height: 16),
                  _buildIndicatorButton(
                    context,
                    AppLocalizations.of(context)!.bollingerBands,
                    const BollingerBandsInputScreen(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorButton(
      BuildContext context, String text, Widget screen) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(text),
      ),
    );
  }
}
