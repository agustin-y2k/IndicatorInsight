// parabolic_sar_chart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ParabolicSARChartScreen extends StatefulWidget {
  final String symbol;

  const ParabolicSARChartScreen({
    Key? key,
    required this.symbol,
  }) : super(key: key);

  @override
  _ParabolicSARChartScreenState createState() =>
      _ParabolicSARChartScreenState();
}

class _ParabolicSARChartScreenState extends State<ParabolicSARChartScreen> {
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

class TradingViewChart extends StatelessWidget {
  final String symbol;

  TradingViewChart({required this.symbol});

  @override
  Widget build(BuildContext context) {
    final String tradingViewHtml = '''
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
              "studies": ["PSAR@tv-basicstudies"]
            });
          </script>
        </body>
      </html>
    ''';

    return InAppWebView(
      initialData: InAppWebViewInitialData(data: tradingViewHtml),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const ParabolicSARChartScreen(
      symbol: '',
    ),
  ));
}
