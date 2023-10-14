import 'package:rick_morty_app/utils/enums.dart';

class CharacterFilters {
  final String? name;
  final StatusCharacter? status;
  final CharacterSpecies ? species;
  final String? type;
  final GenderCharacter? gender;

  CharacterFilters({
    this.name = '',
    this.status = StatusCharacter.empty,
    this.species = CharacterSpecies.empty,
    this.type = '',
    this.gender = GenderCharacter.empty,
  });
}