// macd_chart_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_universal/webview_universal.dart';

class MACDChartScreen extends StatefulWidget {
  final String symbol;

  const MACDChartScreen({
    Key? key,
    required this.symbol,
  }) : super(key: key);

  @override
  _MACDChartScreenState createState() => _MACDChartScreenState();
}

class _MACDChartScreenState extends State<MACDChartScreen> {
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
      body: TradingViewChart(
        symbol: widget.symbol,
      ),
    );
  }
}

class TradingViewChart extends StatefulWidget {
  final String symbol;

  TradingViewChart({required this.symbol});

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
            var chart = new TradingView.widget({
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
              "studies": ["MACD@tv-basicstudies"]
            });
          </script>
        </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      controller: webViewController,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const MACDChartScreen(
      symbol: '',
    ),
  ));
}
