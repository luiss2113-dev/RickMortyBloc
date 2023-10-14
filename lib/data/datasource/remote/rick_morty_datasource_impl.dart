import 'package:rick_morty_app/data/helpers/either.dart';

import 'package:rick_morty_app/domain/models/character.dart';

import 'package:rick_morty_app/domain/models/episodes.dart';

import 'package:rick_morty_app/domain/models/locations.dart';
import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import 'package:rick_morty_app/utils/constanst.dart';

import 'package:rick_morty_app/utils/enums.dart';

import '../../helpers/http_app.dart';
import '../../rick_morty_datasource.dart';

class RickMortyRemoteDatasource extends RickMortyDataSource {
  final HttpApp _httpApp;

  RickMortyRemoteDatasource({required HttpApp httpApp}) : _httpApp = httpApp;

  @override
  Future<Either<ErrorFailure, Characters>> getCharacters(CharacterFilter filter) async {
    try {
      final result =
          await _httpApp.request(Constanst.rickMortyCharacters, queryParameters: filter.toParams());
      return result.when((failure) => Either.left(getError(failure)), (body) {
        final characters = Characters.fromRawJson(body);
        return Either.right(characters);
      });
    } catch (error) {
      return Either.left(ErrorFailure.unknownError);
    }
  }

  @override
  Future<Either<ErrorFailure, Episodes>> getEpisodes({int page = 1}) {
    // TODO: implement getEpisodes
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorFailure, Locations>> getLocations({int page = 1}) {
    // TODO: implement getLocations
    throw UnimplementedError();
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
}
