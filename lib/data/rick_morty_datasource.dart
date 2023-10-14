import 'package:rick_morty_app/data/helpers/either.dart';
import 'package:rick_morty_app/utils/enums.dart';

import '../domain/models/models.dart';
import '../domain/viewmodels/character_filter.dart';

abstract class RickMortyDataSource {
  const RickMortyDataSource();
  Future<Either<ErrorFailure, Characters>> getCharacters(CharacterFilter filter);
  Future<Either<ErrorFailure, Locations>> getLocations({int page = 1});
  Future<Either<ErrorFailure, Episodes>> getEpisodes({int page = 1});
}
