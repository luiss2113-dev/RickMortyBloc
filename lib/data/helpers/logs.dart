part of 'http_app.dart';

void _printLogs(Map<String, dynamic> logs, StackTrace? stackTrace) {
  if (kDebugMode) {
    logs = {
      ...logs,
      'endTime': DateTime.now().toString(),
    };
    log('''
      ===================================
      ${const JsonEncoder.withIndent(' ').convert(logs)}
      
      ===================================
      ''', stackTrace: stackTrace);
  }
}
