// Mocks generated by Mockito 5.4.2 from annotations
// in rick_morty_app/test/bloc_test/locations_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rick_morty_app/data/helpers/either.dart' as _i2;
import 'package:rick_morty_app/domain/models/models.dart' as _i6;
import 'package:rick_morty_app/domain/rick_morty_repository.dart' as _i3;
import 'package:rick_morty_app/domain/viewmodels/viewmodels.dart' as _i7;
import 'package:rick_morty_app/utils/enums.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<Left, Right> extends _i1.SmartFake
    implements _i2.Either<Left, Right> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RickMortyRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRickMortyRepository extends _i1.Mock
    implements _i3.RickMortyRepository {
  MockRickMortyRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Characters>> getCharacters(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCharacters,
          [],
          {#page: page},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Characters>>.value(
                _FakeEither_0<_i5.ErrorFailure, _i6.Characters>(
          this,
          Invocation.method(
            #getCharacters,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Characters>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Characters>> filterCharacters(
          _i7.CharacterFilters? filters) =>
      (super.noSuchMethod(
        Invocation.method(
          #filterCharacters,
          [filters],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Characters>>.value(
                _FakeEither_0<_i5.ErrorFailure, _i6.Characters>(
          this,
          Invocation.method(
            #filterCharacters,
            [filters],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Characters>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Locations>> getLocations(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLocations,
          [],
          {#page: page},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Locations>>.value(
                _FakeEither_0<_i5.ErrorFailure, _i6.Locations>(
          this,
          Invocation.method(
            #getLocations,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Locations>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Locations>> filterLocations(
          _i7.LocationFilters? filters) =>
      (super.noSuchMethod(
        Invocation.method(
          #filterLocations,
          [filters],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Locations>>.value(
                _FakeEither_0<_i5.ErrorFailure, _i6.Locations>(
          this,
          Invocation.method(
            #filterLocations,
            [filters],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Locations>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Episodes>> getEpisodes(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getEpisodes,
          [],
          {#page: page},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Episodes>>.value(
                _FakeEither_0<_i5.ErrorFailure, _i6.Episodes>(
          this,
          Invocation.method(
            #getEpisodes,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Episodes>>);

  @override
  _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Episodes>> filterEpisodes(
          _i7.EpisodeFilters? filters) =>
      (super.noSuchMethod(
        Invocation.method(
          #filterEpisodes,
          [filters],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Episodes>>.value(
                _FakeEither_0<_i5.ErrorFailure, _i6.Episodes>(
          this,
          Invocation.method(
            #filterEpisodes,
            [filters],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.ErrorFailure, _i6.Episodes>>);
}
