import 'package:rick_morty_app/data/helpers/either.dart';

import 'package:rick_morty_app/domain/models/character.dart';

import 'package:rick_morty_app/domain/models/episodes.dart';

import 'package:rick_morty_app/domain/models/locations.dart';
import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import 'package:rick_morty_app/domain/viewmodels/episodes_filter.dart';
import 'package:rick_morty_app/domain/viewmodels/locations_filter.dart';
import 'package:rick_morty_app/utils/constanst.dart';

import 'package:rick_morty_app/utils/enums.dart';

import '../../helpers/http_app.dart';

class RickMortyRemoteDatasource {
  final HttpApp _httpApp;

  RickMortyRemoteDatasource({required HttpApp httpApp}) : _httpApp = httpApp;

  Future<Either<ErrorFailure, Characters>> getCharacters({int page = 1}) async {
    try {
      final result =
          await _httpApp.request('${Constanst.rickMortyCharacters}?page=$page');

      return result.when((failure) => Either.left(getError(failure)), (body) {
        try {
          final characters = Characters.fromRawJson(body);
          if (characters.results == null || characters.results == []) {
            return Either.left(ErrorFailure.noData);
          }
          return Either.right(characters);
        } catch (e) {
          return Either.left(ErrorFailure.noData);
        }
      });
    } catch (error) {
      return Either.left(ErrorFailure.unknownError);
    }
  }

  Future<Either<ErrorFailure, Characters>> filterCharacters(
      CharacterFilters filters) async {
    try {
      var prefs =
          '?${filters.name != null && filters.name != '' ? 'name=${filters.name}' : ''}&status=${characterStatusValues.reverse[filters.status]}&gender=${charactersGenderValues.reverse[filters.gender]}${filters.type != null && filters.type != '' ? '&type=${filters.type}' : ''}&species=${characterSpeciesValues.reverse[filters.species]}';

      final result =
          await _httpApp.request('${Constanst.rickMortyEpisodes}$prefs');

      return result.when((failure) => Either.left(getError(failure)), (body) {
        try {
          final characters = Characters.fromRawJson(body);
          if (characters.results == null || characters.results == []) {
            return Either.left(ErrorFailure.noData);
          }
          return Either.right(characters);
        } catch (e) {
          return Either.left(ErrorFailure.noData);
        }
      });
    } catch (error) {
      return Either.left(ErrorFailure.unknownError);
    }
  }

  Future<Either<ErrorFailure, Episodes>> getEpisodes({int page = 1}) async {
    try {
      final result =
          await _httpApp.request('${Constanst.rickMortyEpisodes}?page=$page');

      return result.when((failure) => Either.left(getError(failure)), (body) {
        try {
          final episodes = Episodes.fromRawJson(body);
          if (episodes.results == null || episodes.results == []) {
            return Either.left(ErrorFailure.noData);
          }
          return Either.right(episodes);
        } catch (e) {
          return Either.left(ErrorFailure.noData);
        }
      });
    } catch (error) {
      return Either.left(ErrorFailure.unknownError);
    }
  }

  Future<Either<ErrorFailure, Episodes>> filterEpisodes(
      EpisodeFilters filters) async {
    try {
      var prefs = '?name=${filters.name}&episode=${filters.episode}';

      final result =
          await _httpApp.request('${Constanst.rickMortyEpisodes}$prefs');

      return result.when((failure) => Either.left(getError(failure)), (body) {
        try {
          final episodes = Episodes.fromRawJson(body);
          if (episodes.results == null || episodes.results == []) {
            return Either.left(ErrorFailure.noData);
          }
          return Either.right(episodes);
        } catch (e) {
          return Either.left(ErrorFailure.noData);
        }
      });
    } catch (error) {
      return Either.left(ErrorFailure.unknownError);
    }
  }

  Future<Either<ErrorFailure, Locations>> getLocations({int page = 1}) async {
    try {
      final result =
          await _httpApp.request('${Constanst.rickMortyLocations}?page=$page');

      return result.when((failure) => Either.left(getError(failure)), (body) {
        try {
          final locations = Locations.fromRawJson(body);
          if (locations.results == null || locations.results == []) {
            return Either.left(ErrorFailure.noData);
          }
          return Either.right(locations);
        } catch (e) {
          return Either.left(ErrorFailure.noData);
        }
      });
    } catch (error) {
      return Either.left(ErrorFailure.unknownError);
    }
  }

  Future<Either<ErrorFailure, Locations>> filterLocations(
      LocationFilters filters) async {
    try {
      var prefs =
          '?name=${filters.name}&type=${filters.type}${filters.dimension != null && filters.dimension != '' ? '&dimension=${filters.dimension}' : ''}';

      final result =
          await _httpApp.request('${Constanst.rickMortyEpisodes}$prefs');

      return result.when((failure) => Either.left(getError(failure)), (body) {
        try {
          final locations = Locations.fromRawJson(body);
          if (locations.results == null || locations.results == []) {
            return Either.left(ErrorFailure.noData);
          }
          return Either.right(locations);
        } catch (e) {
          return Either.left(ErrorFailure.noData);
        }
      });
    } catch (error) {
      return Either.left(ErrorFailure.unknownError);
    }
  }
}

ErrorFailure getError(HttpFailure failure) {
  if (failure.statusCode != null) {
    switch (failure.statusCode) {
      case 401:
        return ErrorFailure.unauthorized;
      case 500:
        return ErrorFailure.serverError;
      default:
        return ErrorFailure.unknownError;
    }
  }

  if (failure.exception is NetworkException) {
    return ErrorFailure.noInternet;
  }

  return ErrorFailure.unknownError;
}
