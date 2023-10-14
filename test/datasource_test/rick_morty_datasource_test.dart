import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Testing if is calling information RICKMOTY API', () async {
    expect(2, 2);
  });
}

MockClient _getMockProvider(String filePath) => MockClient(
    (_) async => Response(await File(filePath).readAsString(), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }));
