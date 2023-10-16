import 'package:rick_morty_app/presentation/blocs/location_bloc.dart';
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
    final info = ResponseInfo(count: 1, pages: 1, next: '?page=2', prev: '');
    final response = Locations(info: info, results: [location]);
    final responseEmpy = Locations(info: info, results: []);
    final infoNotNext = ResponseInfo(count: 1, pages: 1, prev: '');
    final lastResponse = Locations(info: infoNotNext, results: [location]);
    final mockRepo = MockRickMortyRepository();

    blocTest(
      'Locations are loaded correcty when call firts time getLocations reporitory function, success',
      build: () {
        when(mockRepo.getLocations())
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return LocationCubit(mockRepo);
      },
      act: (bloc) => bloc.loadLocations(),
      expect: () {
        return [
          const LocationState(
            page: 1,
            isLoading: true,
          ),
          LocationState(
            locations: response.results!,
            page: 1,
            isLoading: false,
          )
        ];
      },
    );

    blocTest(
      'Location are loaded correcty when calling second or more times getLocations reporitory function, success',
      build: () {
        when(mockRepo.getLocations(page: 2))
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return LocationCubit(mockRepo);
      },
      act: (bloc) => bloc.loadLocations(page: 2),
      expect: () {
        return [
          LocationState(
            locations: response.results!,
            page: 2,
            isLoading: false,
          )
        ];
      },
    );

    blocTest(
      'Locations are loaded empty correcty when I call getLocations reporitory function, success',
      build: () {
        when(mockRepo.getLocations())
            .thenAnswer((_) async => Future.value(Either.right(responseEmpy)));

        return LocationCubit(mockRepo);
      },
      act: (bloc) => bloc.loadLocations(),
      expect: () {
        return [
          const LocationState(
            page: 1,
            isLoading: true,
          ),
          const LocationState(
            page: 1,
            isLoading: false,
            isNext: true,
          )
        ];
      },
    );

    blocTest(
      'Characters no call by function when next property is null',
      build: () {
        when(mockRepo.getLocations())
            .thenAnswer((_) async => Future.value(Either.right(lastResponse)));

        return LocationCubit(mockRepo);
      },
      act: (bloc) => bloc.loadLocations(),
      expect: () {
        return [
          const LocationState(
            page: 1,
            isLoading: true,
          ),
          LocationState(
            page: 1,
            isLoading: false,
            locations: lastResponse.results!,
            isNext: false,
          )
        ];
      },
    );

    blocTest(
      'Locations, error message',
      build: () {
        when(mockRepo.getLocations()).thenAnswer(
            (_) async => await Future.value(Either.left(ErrorFailure.noData)));

        return LocationCubit(mockRepo);
      },
      act: (bloc) => bloc.loadLocations(),
      expect: () {
        return [
          const LocationState(
            page: 1,
            isLoading: true,
          ),
          LocationState(
              page: 1,
              isLoading: false,
              error: getErrorBloc(ErrorFailure.noData))
        ];
      },
    );
  });
}
