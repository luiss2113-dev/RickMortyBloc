enum GenderCharacter { female, male, unknown, empty }

enum StatusCharacter { alive, dead, unknown, empty }

enum CharacterSpecies { human, alien, empty }

///Errores de API para control en pantalla
enum ErrorFailure {
  serverError,
  unknownError,
  noData,
  unauthorized,
  noInternet
}

final characterStatusValues = EnumValues({
  "alive": StatusCharacter.alive,
  "dead": StatusCharacter.dead,
  "unknown": StatusCharacter.unknown,
  "empty": StatusCharacter.empty
});

final charactersGenderValues = EnumValues({
  "female": GenderCharacter.female,
  "male": GenderCharacter.male,
  "unknown": GenderCharacter.unknown,
  "empty": GenderCharacter.empty
});

final characterSpeciesValues = EnumValues({
  "human": CharacterSpecies.human,
  "alien": CharacterSpecies.alien,
  "empty": CharacterSpecies.empty
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
