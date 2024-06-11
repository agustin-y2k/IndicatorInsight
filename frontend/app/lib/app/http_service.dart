// http_service.dart
import 'package:http/http.dart' as http;

class HttpService {
  Future<http.Response> post(String url,
      {required Map<String, String> headers}) {
    return http.post(Uri.parse(url), headers: headers);
  }
}
