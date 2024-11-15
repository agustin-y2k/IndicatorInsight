// ma_input_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'ma_analysis_screen.dart';
import 'ma_chart_screen.dart';
<<<<<<< HEAD
import 'ma_strategies_screen.dart';
=======
>>>>>>> develop
import 'package:flutter_application/app/http_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/app/auth_token_provider.dart';

class MovingAveragesScreen extends StatefulWidget {
  const MovingAveragesScreen({Key? key}) : super(key: key);

  @override
  _MovingAveragesScreenState createState() => _MovingAveragesScreenState();
}

class _MovingAveragesScreenState extends State<MovingAveragesScreen> {
  final TextEditingController symbolController = TextEditingController();
  final TextEditingController smaController = TextEditingController();
  final TextEditingController emaController = TextEditingController();
  final TextEditingController wmaController = TextEditingController();
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
              child: Text(errorMessage, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

<<<<<<< HEAD
  Future<void> calculateMovingAverages(String symbol, String movingAverageType,
      List<int> periods, String authToken) async {
    if (!_validateInput(symbol, periods)) {
=======
  Future<void> calculateMovingAverages(
      String symbol, String interval, String authToken) async {
    if (!_validateInput(symbol)) {
>>>>>>> develop
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final url = Uri.parse(
<<<<<<< HEAD
        'http://localhost:8000/companies/$symbol/indicators/moving_averages');

    try {
=======
        'http://127.0.0.1:8000/companies/$symbol/indicators/moving_averages?interval=$interval');
    try {
      final smaPeriods = _parsePeriods(smaController.text);
      final emaPeriods = _parsePeriods(emaController.text);
      final wmaPeriods = _parsePeriods(wmaController.text);

>>>>>>> develop
      final response =
          await Provider.of<HttpService>(context, listen: false).post(
        url.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
<<<<<<< HEAD
          'moving_average_type': movingAverageType,
          'periods': periods,
=======
          'sma_periods': smaPeriods,
          'ema_periods': emaPeriods,
          'wma_periods': wmaPeriods,
>>>>>>> develop
        }),
      );

      if (response.statusCode == 200) {
        final movingAveragesData = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MAAnalysisScreen(movingAveragesData: movingAveragesData),
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

  bool _validateInput(String symbol) {
    if (symbol.isEmpty) {
      _showErrorSnackBar(AppLocalizations.of(context)!.pleaseEnterSymbol);
      return false;
    }
    return true;
  }

  List<int> _parsePeriods(String periods) {
    return periods
        .split(',')
        .map((e) => int.tryParse(e.trim()) ?? 0)
        .where((element) => element > 0)
        .toList();
  }

  void _navigateToChartScreen(String symbol) {
    if (_validateInput(symbol)) {
      final smaPeriods = _parsePeriods(smaController.text);
      final emaPeriods = _parsePeriods(emaController.text);
      final wmaPeriods = _parsePeriods(wmaController.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MAChartScreen(
            symbol: symbol,
            interval: selectedInterval,
            smaPeriods: smaPeriods,
            emaPeriods: emaPeriods,
            wmaPeriods: wmaPeriods,
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
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      prefixIcon:
                          Icon(Icons.search, color: Colors.white, size: 24),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    onChanged: (value) {
                      symbolController.text = value.toUpperCase();
                      symbolController.selection = TextSelection.fromPosition(
                          TextPosition(offset: symbolController.text.length));
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
                  _buildPeriodsInput(
                      AppLocalizations.of(context)!.smaPeriods, smaController),
                  SizedBox(height: 16),
                  _buildPeriodsInput(
                      AppLocalizations.of(context)!.emaPeriods, emaController),
                  SizedBox(height: 16),
                  _buildPeriodsInput(
                      AppLocalizations.of(context)!.wmaPeriods, wmaController),
                  SizedBox(height: 16),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            final symbol = symbolController.text.toUpperCase();
<<<<<<< HEAD
                            final movingAverageType = selectedMovingAverageType;
                            final authToken = authTokenProvider.authToken ?? '';
                            final periods = periodsController.text
                                .split(',')
                                .map((e) => int.tryParse(e.trim()) ?? 0)
                                .where((element) => element > 0)
                                .toList();
                            calculateMovingAverages(
                                symbol, movingAverageType, periods, authToken);
=======
                            final authToken = authTokenProvider.authToken ?? '';
                            calculateMovingAverages(
                                symbol, selectedInterval, authToken);
>>>>>>> develop
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

  Widget _buildPeriodsInput(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 18),
        border: OutlineInputBorder(),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        prefixIcon: Icon(Icons.timeline, color: Colors.white, size: 24),
      ),
    );
  }
}
