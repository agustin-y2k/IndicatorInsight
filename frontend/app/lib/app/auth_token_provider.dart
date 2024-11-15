// auth_token_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenProvider with ChangeNotifier {
  String? _authToken;

  String? get authToken => _authToken;

  Future<void> loadAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken');
    notifyListeners();
  }

  Future<void> setAuthToken(String? token) async {
    _authToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString('authToken', token);
    } else {
      await prefs.remove('authToken');
    }
    notifyListeners();
  }

  Future<void> clearAuthToken() async {
    _authToken = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    notifyListeners();
  }

  void logout() {
    clearAuthToken();
  }
}
