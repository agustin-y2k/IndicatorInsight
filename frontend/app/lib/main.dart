// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_application/app/auth_token_provider.dart';
import 'package:flutter_application/app/http_service.dart';
import 'package:flutter_application/app/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'en';
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadAuthToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthTokenProvider()),
              Provider<HttpService>(create: (_) => HttpService()),
            ],
            child: MaterialApp(
              home: HomeScreen(),
              title: 'Indicator Insight',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en'),
                Locale('es'),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> _loadAuthToken() async {}
}
