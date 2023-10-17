import 'package:rick_morty_app/utils/enums.dart';

class CharacterFilters {
  final String? name;
  final StatusCharacter? status;
  final String? species;
  final String? type;
  final GenderCharacter? gender;

  CharacterFilters({
    this.name = '',
    this.status = StatusCharacter.empty,
    this.species = 'empty',
    this.type = '',
    this.gender = GenderCharacter.empty,
  });

  @override
  String toString() {
    return 'CharacterFilters(name: $name, status: $status, species: $species, type: $type, gender: $gender)';
  }
}
