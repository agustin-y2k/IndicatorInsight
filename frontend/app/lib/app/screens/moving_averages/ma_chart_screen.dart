// ma_chart_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_universal/webview_universal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';

class MAChartScreen extends StatefulWidget {
  final String symbol;
  final String interval;
  final List<int> smaPeriods;
  final List<int> emaPeriods;
  final List<int> wmaPeriods;

  const MAChartScreen({
    Key? key,
    required this.symbol,
    required this.interval,
    required this.smaPeriods,
    required this.emaPeriods,
    required this.wmaPeriods,
  }) : super(key: key);

  @override
  _MAChartScreenState createState() => _MAChartScreenState();
}

class _MAChartScreenState extends State<MAChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.show_chart, color: Colors.white),
            SizedBox(width: 10),
            Text(
              '${widget.symbol} - ${AppLocalizations.of(context)!.providedByTradingView}',
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
      body: TradingViewChart(
        symbol: widget.symbol,
        interval: widget.interval,
        smaPeriods: widget.smaPeriods,
        emaPeriods: widget.emaPeriods,
        wmaPeriods: widget.wmaPeriods,
      ),
    );
  }
}

class TradingViewChart extends StatefulWidget {
  final String symbol;
  final String interval;
  final List<int> smaPeriods;
  final List<int> emaPeriods;
  final List<int> wmaPeriods;

  TradingViewChart({
    required this.symbol,
    required this.interval,
    required this.smaPeriods,
    required this.emaPeriods,
    required this.wmaPeriods,
  });

  @override
  _TradingViewChartState createState() => _TradingViewChartState();
}

class _TradingViewChartState extends State<TradingViewChart> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..init(
        context: context,
        setState: setState,
        uri: Uri.dataFromString(
          _getTradingViewHtml(
            widget.symbol,
            widget.interval,
            widget.smaPeriods,
            widget.emaPeriods,
            widget.wmaPeriods,
          ),
          mimeType: 'text/html',
        ),
      );
  }

  String _getTradingViewHtml(String symbol, String interval,
      List<int> smaPeriods, List<int> emaPeriods, List<int> wmaPeriods) {
    final studies = _buildStudies(smaPeriods, emaPeriods, wmaPeriods);

    final intervalMap = {
      'daily': 'D',
      'weekly': 'W',
      'monthly': 'M',
    };
    final tvInterval = intervalMap[interval] ?? 'D';

    return '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
          <style>
            body, html, #tradingview_chart {
              margin: 0;
              padding: 0;
              height: 100%;
              width: 100%;
            }
          </style>
        </head>
        <body>
          <div id="tradingview_chart"></div>
          <script type="text/javascript">
            new TradingView.widget({
              "container_id": "tradingview_chart",
              "autosize": true,
              "symbol": "$symbol",
              "interval": "$tvInterval",
              "timezone": "Etc/UTC",
              "theme": "light",
              "style": "1",
              "locale": "es",
              "toolbar_bg": "#f1f3f6",
              "enable_publishing": false,
              "withdateranges": true,
              "hide_side_toolbar": false,
              "allow_symbol_change": true,
              "save_image": false,
              "details": true,
              "hotlist": true,
              "calendar": true,
              "studies": ${jsonEncode(studies)}
            });
          </script>
        </body>
      </html>
    ''';
  }

  List<Map<String, dynamic>> _buildStudies(
      List<int> smaPeriods, List<int> emaPeriods, List<int> wmaPeriods) {
    final studies = <Map<String, dynamic>>[];

    for (var period in smaPeriods) {
      studies.add({
        "id": "MASimple@tv-basicstudies",
        "inputs": {"length": period}
      });
    }

    for (var period in emaPeriods) {
      studies.add({
        "id": "MAExp@tv-basicstudies",
        "inputs": {"length": period}
      });
    }

    for (var period in wmaPeriods) {
      studies.add({
        "id": "MAWeighted@tv-basicstudies",
        "inputs": {"length": period}
      });
    }

    return studies;
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      controller: webViewController,
    );
  }
}
