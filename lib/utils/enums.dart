enum GenderCharacter {
  // ignore: constant_identifier_names
  FEMALE,
  // ignore: constant_identifier_names
  MALE,
  // ignore: constant_identifier_names
  UNKNOWN
}

enum StatusCharacter {
  // ignore: constant_identifier_names
  ALIVE,

  // ignore: constant_identifier_names
  DEAD,

  // ignore: constant_identifier_names
  UNKNOWN
}

///Errores de API para control en pantalla
enum ErrorFailure {
  serverError,
  unknownError,
  noData,
  unauthorized,
  noInternet
}
