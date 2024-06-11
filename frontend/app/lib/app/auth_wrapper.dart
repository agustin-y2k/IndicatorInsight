// auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_application/app/auth_token_provider.dart';
import 'package:flutter_application/app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    final authTokenProvider = Provider.of<AuthTokenProvider>(context);

    if (authTokenProvider.authToken != null) {
      return child;
    } else {
      return HomeScreen();
    }
  }
}
