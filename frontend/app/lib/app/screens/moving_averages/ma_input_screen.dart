// ma_input_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'ma_recommendation_screen.dart';
import 'ma_chart_screen.dart';
import 'ma_strategies_screen.dart';
import 'package:flutter_application/app/http_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/app/auth_token_provider.dart';

class MovingAveragesScreen extends StatefulWidget {
  const MovingAveragesScreen({Key? key}) : super(key: key);

  @override
  MovingAveragesScreenState createState() => MovingAveragesScreenState();
}

class MovingAveragesScreenState extends State<MovingAveragesScreen> {
  TextEditingController symbolController = TextEditingController();
  String selectedMovingAverageType = 'SMA';
  TextEditingController periodsController = TextEditingController();
  Map<String, dynamic> movingAveragesData = {};
  bool _isLoading = false;
  String? _error;

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Text(
              errorMessage,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> calculateMovingAverages(String symbol, String movingAverageType,
      List<int> periods, String authToken) async {
    if (!_validateInput(symbol, periods)) {
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final url = Uri.parse(
        'http://192.168.18.4:8000/companies/$symbol/indicators/moving_averages');

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
        setState(() {
          movingAveragesData = jsonDecode(response.body);
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MARecommendationScreen(movingAveragesData: movingAveragesData),
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

  bool _validateInput(String symbol, List<int> periods) {
    if (symbol.isEmpty) {
      _showErrorSnackBar(AppLocalizations.of(context)!.pleaseEnterSymbol);
      return false;
    } else if (periods.isEmpty) {
      _showErrorSnackBar(AppLocalizations.of(context)!.pleaseEnterPeriod);
      return false;
    }
    return true;
  }

  void _navigateToChartScreen(
      String symbol, String movingAverageType, List<int> periods) {
    if (_validateInput(symbol, periods)) {
      final studies = periods.map((period) {
        String id;
        if (movingAverageType == 'SMA') {
          id = 'MASimple@tv-basicstudies';
        } else if (movingAverageType == 'MMA') {
          id = 'MAExp@tv-basicstudies';
        } else {
          id = 'MAWeighted@tv-basicstudies';
        }
        return {
          'id': id,
          'inputs': {'length': period}
        };
      }).toList();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TradingViewChart(
            symbol: symbol,
            studies: studies,
          ),
        ),
      );
    }
  }

  void _navigateToStrategiesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MAStrategiesScreen(),
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
              AppLocalizations.of(context)!.movingAverages,
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
                  DropdownButtonFormField<String>(
                    value: selectedMovingAverageType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMovingAverageType = newValue!;
                      });
                    },
                    items: <String>['SMA', 'MMA', 'WMA']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.movingAveragesType,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.trending_up,
                          color: Colors.white, size: 24),
                    ),
                    dropdownColor: Colors.grey[800],
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: periodsController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.enterPeriod,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon:
                          Icon(Icons.timeline, color: Colors.white, size: 24),
                    ),
                  ),
                  SizedBox(height: 16),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            final symbol = symbolController.text.toUpperCase();
                            final movingAverageType = selectedMovingAverageType;
                            final authToken = authTokenProvider.authToken ?? '';
                            final periods = periodsController.text
                                .split(',')
                                .map((e) => int.tryParse(e.trim()) ?? 0)
                                .where((element) => element > 0)
                                .toList();
                            calculateMovingAverages(
                                symbol, movingAverageType, periods, authToken);
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
                      final movingAverageType = selectedMovingAverageType;
                      final periods = periodsController.text
                          .split(',')
                          .map((e) => int.tryParse(e.trim()) ?? 0)
                          .where((element) => element > 0)
                          .toList();
                      _navigateToChartScreen(
                          symbol, movingAverageType, periods);
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
