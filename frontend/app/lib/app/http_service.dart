// http_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  Future<http.Response> post(String url,
      {required Map<String, String> headers, dynamic body}) {
    return http.post(Uri.parse(url), headers: headers, body: body);
  }
}
