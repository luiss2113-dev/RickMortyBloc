import '../data/helpers/either.dart';
import '../utils/enums.dart';
import 'models/models.dart';
import 'viewmodels/viewmodels.dart';

abstract class RickMortyRepository {
  Future<Either<ErrorFailure, Characters>> getCharacters({int page = 1});
  Future<Either<ErrorFailure, Characters>> filterCharacters(
      CharacterFilters filters);
  Future<Either<ErrorFailure, Locations>> getLocations({int page = 1});
  Future<Either<ErrorFailure, Locations>> filterLocations(
      LocationFilters filters);
  Future<Either<ErrorFailure, Episodes>> getEpisodes({int page = 1});
  Future<Either<ErrorFailure, Episodes>> filterEpisodes(EpisodeFilters filters);
}
