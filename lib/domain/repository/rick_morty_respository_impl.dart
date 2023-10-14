import 'package:rick_morty_app/data/helpers/either.dart';
import 'package:rick_morty_app/domain/models/character.dart';
import 'package:rick_morty_app/domain/models/episodes.dart';
import 'package:rick_morty_app/domain/models/locations.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import 'package:rick_morty_app/domain/viewmodels/episodes_filter.dart';
import 'package:rick_morty_app/domain/viewmodels/locations_filter.dart';
import 'package:rick_morty_app/utils/enums.dart';

import '../../data/datasource/remote/rick_morty_datasource_impl.dart';

class RickAndMortyRepositoryImpl extends RickMortyRepository {
  final RickMortyRemoteDatasource _rickMortyDataSource;

  RickAndMortyRepositoryImpl({required RickMortyRemoteDatasource rickMortyDataSource})
      : _rickMortyDataSource = rickMortyDataSource;

  @override
  Future<Either<ErrorFailure, Characters>> getCharacters({int page = 1}) =>
      _rickMortyDataSource.getCharacters(page: page);

  @override
  Future<Either<ErrorFailure, Episodes>> getEpisodes({int page = 1}) =>
      _rickMortyDataSource.getEpisodes(page: page);

  @override
  Future<Either<ErrorFailure, Locations>> getLocations({int page = 1}) =>
      _rickMortyDataSource.getLocations(page: page);

        @override
  Future<Either<ErrorFailure, Characters>> filterCharacters(
          CharacterFilters filters) =>
      _rickMortyDataSource.filterCharacters(filters);

  @override
  Future<Either<ErrorFailure, Episodes>> filterEpisodes(
          EpisodeFilters filters) =>
      _rickMortyDataSource.filterEpisodes(filters);

  @override
  Future<Either<ErrorFailure, Locations>> filterLocations(
          LocationFilters filters) =>
      filterLocations(filters);

}
