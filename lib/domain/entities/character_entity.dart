import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/utils/constanst.dart';

import '../../utils/enums.dart';

class CharacterEntity extends Equatable {
  final int? _id;
  final String? _name;
  final String? _image;
  final StatusCharacter _status;

  const CharacterEntity({
    StatusCharacter status = StatusCharacter.unknown,
    int id = 0,
    String name = '',
    String image = '',
  })  : _status = status,
        _id = id,
        _name = name,
        _image = image;

  String get characterName => _name ?? 'Unknown';
  int get characterId => _id ?? 0;
  StatusCharacter get characterStatus => _status;
  String get characterImage => _image ?? Constanst.defaultImageUrl;
  String get tagHero => 'character_$characterId';

  @override
  List<Object?> get props => [_id, _name, _image, _status];
}
