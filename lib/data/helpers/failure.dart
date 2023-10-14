part of 'http_app.dart';

///Encapsulamiento de errores, retorna statusCode y Exception
class HttpFailure {
   int? statusCode;
   Object? exception;

  HttpFailure({this.statusCode, this.exception});
}

class NetworkException {}

  String getErrorBloc(ErrorFailure failure) {
    return {
          ErrorFailure.noData: "No hay datos",
          ErrorFailure.noInternet: "No tienes conexión a internet",
          ErrorFailure.serverError: "Error en el servidor",
          ErrorFailure.unknownError: "Error desconocido",
          ErrorFailure.unauthorized: "No autorizado",
        }[failure] ??
        "Error desconocido";
  }