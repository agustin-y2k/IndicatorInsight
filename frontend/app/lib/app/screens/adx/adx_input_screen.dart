// adx_input_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'adx_recommendation_screen.dart';
import 'adx_chart_screen.dart';
import 'adx_strategies_screen.dart';
import 'package:flutter_application/app/http_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/app/auth_token_provider.dart';

class ADXInputScreen extends StatefulWidget {
  const ADXInputScreen({Key? key}) : super(key: key);

  @override
  _ADXInputScreenState createState() => _ADXInputScreenState();
}

class _ADXInputScreenState extends State<ADXInputScreen> {
  TextEditingController symbolController = TextEditingController();
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

  Future<void> calculateADX(String symbol, String authToken) async {
    // Añadimos authToken como parámetro
    if (!_validateSymbol(symbol)) {
      return;
    }

    final url =
        Uri.parse('http://192.168.18.4:8000/companies/$symbol/indicators/adx');

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
          'Authorization':
              'Bearer $authToken', // Usamos el token de autenticación
        },
      );

      if (response.statusCode == 200) {
        final adxData = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ADXRecommendationScreen(adxData: adxData),
          ),
        );
      } else {
        _showErrorSnackBar(AppLocalizations.of(context)!
            .failedToCalculate(response.reasonPhrase ?? ''));
      }
    } catch (e) {
      _showErrorSnackBar(
          AppLocalizations.of(context)!.errorOccurred(e.toString()));
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ADXChartScreen(symbol: symbol),
        ),
      );
    }
  }

  void _navigateToStrategiesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ADXStrategiesScreen(),
      ),
    );
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
              'ADX',
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
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            final symbol = symbolController.text.toUpperCase();
                            final authToken = authTokenProvider.authToken ?? '';
                            calculateADX(symbol, authToken);
                          },
                          child: Text(
                              AppLocalizations.of(context)!.getRecommendation),
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
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _navigateToStrategiesScreen,
                    child: Text(AppLocalizations.of(context)!.strategies),
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
