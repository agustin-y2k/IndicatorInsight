// reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../home_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                errorMessage,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _resetPassword() async {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorSnackBar(AppLocalizations.of(context)!.pleaseFillAllFields);
      return;
    }

    if (newPassword != confirmPassword) {
      _showErrorSnackBar(AppLocalizations.of(context)!.passwordsDoNotMatch);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/users/set-new-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': widget.email, 'new_password': newPassword}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.passwordResetSuccess),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        _showErrorSnackBar(AppLocalizations.of(context)!.passwordResetFailed);
      }
    } catch (e) {
      _showErrorSnackBar(AppLocalizations.of(context)!.internalServerError);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_reset, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.resetPassword,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: newPasswordController,
                    obscureText: _obscureNewPassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.newPassword,
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.confirmPassword,
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  _isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: 280,
                          child: ElevatedButton(
                            onPressed: _resetPassword,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            child: Text(
                                AppLocalizations.of(context)!.resetPassword),
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
