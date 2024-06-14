// ma_chart_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_universal/webview_universal.dart';
import 'dart:convert';

class MAChartScreen extends StatefulWidget {
  const MAChartScreen({Key? key}) : super(key: key);

  @override
  _MAChartScreenState createState() => _MAChartScreenState();
}

class _MAChartScreenState extends State<MAChartScreen> {
  TextEditingController symbolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: symbolController,
              decoration: const InputDecoration(
                labelText: 'Enter symbol (uppercase)',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final symbol = symbolController.text.toUpperCase();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TradingViewChart(symbol: symbol, studies: []),
                  ),
                );
              },
              child: const Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class TradingViewChart extends StatefulWidget {
  final String symbol;
  final List<Map<String, dynamic>> studies;

  TradingViewChart({required this.symbol, required this.studies});

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
          _getTradingViewHtml(widget.symbol),
          mimeType: 'text/html',
        ),
      );
  }

  String _getTradingViewHtml(String symbol) {
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
              "interval": "D",
              "timezone": "Etc/UTC",
              "theme": "light",
              "style": "1",
              "locale": "en",
              "toolbar_bg": "#f1f3f6",
              "enable_publishing": false,
              "withdateranges": true,
              "hide_side_toolbar": false,
              "allow_symbol_change": true,
              "save_image": false,
              "details": true,
              "hotlist": true,
              "calendar": true,
              "studies": ${jsonEncode(widget.studies)}
            });
          </script>
        </body>
      </html>
    ''';
  }

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
              '${widget.symbol}',
              style: TextStyle(
                fontSize: 24,
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
      body: WebView(
        controller: webViewController,
      ),
    );
  }
}
