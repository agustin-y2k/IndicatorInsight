// bollinger_bands_input_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'bollinger_bands_analysis_screen.dart';
import 'bollinger_bands_chart_screen.dart';
import 'package:flutter_application/app/http_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/app/auth_token_provider.dart';

class BollingerBandsInputScreen extends StatefulWidget {
  const BollingerBandsInputScreen({Key? key}) : super(key: key);

  @override
  _BollingerBandsInputScreenState createState() =>
      _BollingerBandsInputScreenState();
}

class _BollingerBandsInputScreenState extends State<BollingerBandsInputScreen> {
  TextEditingController symbolController = TextEditingController();
  TextEditingController periodController = TextEditingController(text: '20');
  TextEditingController deviationController = TextEditingController(text: '2');
  String selectedInterval = 'daily';
  bool _isLoading = false;
  String? _error;

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                errorMessage,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> calculateBollingerBands(String symbol, String interval,
      int period, int deviation, String authToken) async {
    if (!_validateSymbol(symbol)) {
      return;
    }

    final url = Uri.parse(
        'http://127.0.0.1:8000/companies/$symbol/indicators/bollinger_bands?interval=$interval&period=$period&deviation=$deviation');

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response =
          await Provider.of<HttpService>(context, listen: false).post(
        url.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey("error")) {
          String errorMessage;
          switch (data["error"]) {
            case "No data found for the symbol":
              errorMessage = AppLocalizations.of(context)!.errorNoDataFound;
              break;
            default:
              errorMessage = AppLocalizations.of(context)!.errorUnexpected;
          }
          _showErrorSnackBar(errorMessage);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BollingerBandsAnalysisScreen(bollingerBandsData: data),
            ),
          );
        }
      } else {
        _showErrorSnackBar(
          AppLocalizations.of(context)!.calculateBBFailed +
              ": " +
              (response.reasonPhrase ?? ''),
        );
      }
    } catch (e) {
      _showErrorSnackBar(
        AppLocalizations.of(context)!.errorOccurred(e.toString()),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _validateSymbol(String symbol) {
    if (symbol.isEmpty) {
      _showErrorSnackBar(AppLocalizations.of(context)!.pleaseEnterSymbol);
      return false;
    }
    return true;
  }

  void _navigateToChartScreen(String symbol) {
    if (_validateSymbol(symbol)) {
      final period = int.tryParse(periodController.text) ?? 20;
      final deviation = int.tryParse(deviationController.text) ?? 2;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BollingerBandsChartScreen(
            symbol: symbol,
            interval: selectedInterval,
            period: period,
            deviation: deviation,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authTokenProvider = Provider.of<AuthTokenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insights, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.bollingerBands,
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
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: symbolController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.enterSymbol,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      prefixIcon:
                          Icon(Icons.search, color: Colors.white, size: 24),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    onChanged: (value) {
                      symbolController.text = value.toUpperCase();
                      symbolController.selection = TextSelection.fromPosition(
                        TextPosition(offset: symbolController.text.length),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedInterval,
                    items: [
                      DropdownMenuItem(
                        value: 'daily',
                        child:
                            Text(AppLocalizations.of(context)!.intervalDaily),
                      ),
                      DropdownMenuItem(
                        value: 'weekly',
                        child:
                            Text(AppLocalizations.of(context)!.intervalWeekly),
                      ),
                      DropdownMenuItem(
                        value: 'monthly',
                        child:
                            Text(AppLocalizations.of(context)!.intervalMonthly),
                      ),
                    ],
                    onChanged: (newValue) {
                      setState(() {
                        selectedInterval = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.selectInterval,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.black54,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: periodController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .enterBBPeriodWithDefault,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: deviationController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .enterBBStdDevWithDefault,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            final symbol = symbolController.text.toUpperCase();
                            final authToken = authTokenProvider.authToken ?? '';
                            final period =
                                int.tryParse(periodController.text) ?? 20;
                            final deviation =
                                int.tryParse(deviationController.text) ?? 2;
                            calculateBollingerBands(symbol, selectedInterval,
                                period, deviation, authToken);
                          },
                          child:
                              Text(AppLocalizations.of(context)!.viewAnalysis),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final symbol = symbolController.text.toUpperCase();
                      _navigateToChartScreen(symbol);
                    },
                    child: Text(AppLocalizations.of(context)!.viewChart),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  if (_error != null)
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        _error!,
                        style: TextStyle(color: Colors.red, fontSize: 18),
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
}
