// rsi_chart_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_universal/webview_universal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RSIChartScreen extends StatefulWidget {
  final String symbol;
  final String interval;
  final int period;

  const RSIChartScreen({
    Key? key,
    required this.symbol,
    required this.interval,
    this.period = 14,
  }) : super(key: key);

  @override
  _RSIChartScreenState createState() => _RSIChartScreenState();
}

class _RSIChartScreenState extends State<RSIChartScreen> {
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
        period: widget.period,
      ),
    );
  }
}

class TradingViewChart extends StatefulWidget {
  final String symbol;
  final String interval;
  final int period;

  const TradingViewChart({
    required this.symbol,
    required this.interval,
    required this.period,
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
          _getTradingViewHtml(widget.symbol, widget.interval, widget.period),
          mimeType: 'text/html',
        ),
      );
  }

  String _getTradingViewHtml(String symbol, String interval, int period) {
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
              "studies": [
                {
                  "id": "RSI@tv-basicstudies",
                  "inputs": {
                    "length": $period
                  }
                }
              ]
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
