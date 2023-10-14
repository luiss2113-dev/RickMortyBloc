import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/utils/enums.dart';

import 'filter.dart';
import 'page.dart';

class CharacterFilter extends Equatable with Page implements Params {
  final String? _name;
  final StatusCharacter? _status;
  final String? _species;
  final String? _type;
  final GenderCharacter? _gender;

  CharacterFilter({
    String? name,
    StatusCharacter? status,
    String? species,
    String? type,
    GenderCharacter? gender,
    required int page,
  })  : _name = name ?? '',
        _status = status,
        _species = species ?? '',
        _type = type ?? '',
        _gender = gender;

@override
  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'status': _status,
      'species': _species,
      'type': _type,
      'gender': _gender,
    };
  }

  Map<String, String> toParams() {
    return {
      'page': '$page',
      'name': _name ?? '',
      'status': '${_status ?? ''}',
      'species': _species ?? '',
      'type': _type ?? '',
      'gender': '${_gender ?? ''}',
    };
  }

  @override
  List<Object?> get props => [_gender, _name, _species, _status, _type, page];
  
  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
