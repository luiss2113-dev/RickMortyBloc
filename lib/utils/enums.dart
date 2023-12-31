import 'package:flutter/material.dart';

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
  "Alive": StatusCharacter.alive,
  "Dead": StatusCharacter.dead,
  "unknown": StatusCharacter.unknown,
  "empty": StatusCharacter.empty
});

final characterSpeciesValues = EnumValues({
  "Human": CharacterSpecies.human,
  "Alien": CharacterSpecies.alien,
  "Empty": CharacterSpecies.empty
});

final charactersGenderValues = EnumValues({
  "Female": GenderCharacter.female,
  "Male": GenderCharacter.male,
  "unknown": GenderCharacter.unknown,
  "Empty": GenderCharacter.empty
});

IconData characterSpecieIcon(CharacterSpecies specie) => [
      Icons.person,
      Icons.person_off_rounded,
      Icons.radio_button_unchecked_rounded
    ][specie.index];

IconData statusIcon(StatusCharacter status) => [
      Icons.fireplace,
      Icons.fireplace_outlined,
      Icons.radio_button_unchecked_rounded,
      Icons.fiber_manual_record_outlined
    ][status.index];

IconData genreIcon(GenderCharacter genre) => [
      Icons.face_2,
      Icons.face_outlined,
      Icons.radio_button_unchecked_rounded,
      Icons.fiber_manual_record_outlined
    ][genre.index];

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
