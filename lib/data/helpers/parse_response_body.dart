
part of 'http_app.dart';

dynamic _parseResponseBody(String body) {
  try {
    return jsonDecode(body);
  } catch (e) {
    return body;
  }
}
