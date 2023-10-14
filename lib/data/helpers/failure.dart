part of 'http_app.dart';

///Encapsulamiento de errores, retorna statusCode y Exception
class HttpFailure {
   int? statusCode;
   Object? exception;

  HttpFailure({this.statusCode, this.exception});
}

class NetworkException {}
