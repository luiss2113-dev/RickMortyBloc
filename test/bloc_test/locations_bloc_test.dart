import 'package:rick_morty_app/presentation/blocs/blocs.dart';
import 'package:rick_morty_app/utils/enums.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/domain/models/models.dart';
import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:rick_morty_app/data/helpers/either.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'character_bloc_test.mocks.dart';

@GenerateMocks([RickMortyRepository])
void main() {
  group('Bloc Characters for test', () {
    final location = LocationItemModel(
        created: DateTime.now(),
        name: 'Rick',
        id: 23,
        dimension: 'httmc',
        type: 'Playa',
        residents: const ['Caramelo', 'cafe', 'postre']);
    const info = ResponseInfo(pages: 1, next: 'null?page=2', prev: '');
    final response = Locations(info: info, results: [location]);
    const responseEmpy = Locations(info: info, results: []);
    const lastInfo = ResponseInfo(
      pages: 42,
      next: null,
    );
    final lastResponse = Locations(info: lastInfo, results: [location]);
    final mockRepo = MockRickMortyRepository();

    blocTest(
      'Locations are loaded correcty when call firts time getLocations reporitory function, success',
      build: () {
        when(mockRepo.getLocations())
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return LocationsBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const GetLocationsEvent()),
      expect: () {
        return [
          const LocationsState(state: BlocState.loading),
          LocationsState(locations: response, state: BlocState.loaded)
        ];
      },
    );

    blocTest(
      'Location are loaded correcty when calling second or more times getLocations reporitory function, success',
      build: () {
        when(mockRepo.getLocations(page: 2))
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return LocationsBloc(mockRepo);
      },
      act: (bloc) {
        bloc.emit(bloc.state.copyWith(
          newLocations: response,
          newState: BlocState.loaded,
        ));
        bloc.add(const GetLocationsEvent());
      },
      expect: () {
        return [
          LocationsState(
            state: BlocState.loaded,
            locations: response,
          ),
          LocationsState(
            state: BlocState.loaded,
            locations: Locations(info: response.info, results: [
              ...response.results!,
              ...response.results!,
            ]),
          )
        ];
      },
    );

    blocTest(
      'Locations are loaded empty correcty when I call getLocations reporitory function, success',
      build: () {
        when(mockRepo.getLocations())
            .thenAnswer((_) async => Future.value(Either.right(responseEmpy)));

        return LocationsBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const GetLocationsEvent()),
      expect: () {
        return [
          const LocationsState(state: BlocState.loading),
          const LocationsState(state: BlocState.loaded, locations: responseEmpy)
        ];
      },
    );

    blocTest(
      'Locations no call by function when next property is null',
      build: () {
        when(mockRepo.getLocations())
            .thenAnswer((_) async => Future.value(Either.right(lastResponse)));

        return LocationsBloc(mockRepo);
      },
      act: (bloc) {
        bloc.emit(bloc.state.copyWith(
          newLocations: lastResponse,
          newState: BlocState.loaded,
        ));
        bloc.add(const GetLocationsEvent());
      },
      expect: () {
        return [
          LocationsState(state: BlocState.loaded, locations: lastResponse),
        ];
      },
    );

    blocTest(
      'Locations, error message',
      build: () {
        when(mockRepo.getLocations()).thenAnswer(
            (_) async => await Future.value(Either.left(ErrorFailure.noData)));

        return LocationsBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const GetLocationsEvent()),
      expect: () {
        return [
          const LocationsState(state: BlocState.loading),
          LocationsState(
              state: BlocState.error,
              messageError: getErrorBloc(ErrorFailure.noData))
        ];
      },
    );
  });
}
