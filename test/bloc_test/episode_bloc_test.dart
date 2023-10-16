import 'package:rick_morty_app/utils/enums.dart';
import 'package:rick_morty_app/presentation/blocs/episode_bloc.dart';
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
  group('Bloc Episode for test Rick and morty API.', () {
    final episode = EpisodeItemModel(
        created: DateTime.now(),
        name: 'Rick',
        episode: 'CS4550',
        id: 23,
        characters: const ['Caramelo', 'cafe', 'postre']);
    final info =
        ResponseInfo(count: 1, pages: 1, next: 'null?page:2', prev: '');
    final response = Episodes(info: info, results: [episode]);
    final infoNotNext = ResponseInfo(count: 1, pages: 1, prev: '');
    final lastResponse = Episodes(info: infoNotNext, results: [episode]);
    final responseEmpy = Episodes(info: info, results: []);
    final mockRepo = MockRickMortyRepository();

    blocTest(
      'Episodes are loaded correcty when call firts time getEpisodes reporitory function, success',
      build: () {
        when(mockRepo.getEpisodes())
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return EpisodeCubit(mockRepo);
      },
      act: (bloc) => bloc.loadEpisodes(),
      expect: () {
        return [
          const EpisodeState(
            page: 1,
            isLoading: true,
          ),
          EpisodeState(
              episodesCurrent: response.results!,
              page: 1,
              isLoading: false,
              isNext: true)
        ];
      },
    );

    blocTest(
      'Episode are loaded correcty when calling second or more times getEpisodes reporitory function, success',
      build: () {
        when(mockRepo.getEpisodes(page: 2))
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return EpisodeCubit(mockRepo);
      },
      act: (bloc) => bloc.loadEpisodes(page: 2),
      expect: () {
        return [
          EpisodeState(
            episodesCurrent: response.results!,
            page: 2,
            isLoading: false,
          )
        ];
      },
    );

    blocTest(
      'Episodes are loaded empty correcty when I call getEpisodes reporitory function, success',
      build: () {
        when(mockRepo.getEpisodes())
            .thenAnswer((_) async => Future.value(Either.right(responseEmpy)));

        return EpisodeCubit(mockRepo);
      },
      act: (bloc) => bloc.loadEpisodes(),
      expect: () {
        return [
          const EpisodeState(
            page: 1,
            isLoading: true,
          ),
          const EpisodeState(
            page: 1,
            isLoading: false,
          )
        ];
      },
    );

    blocTest(
      'Episodes no call by function when next property is null',
      build: () {
        when(mockRepo.getEpisodes())
            .thenAnswer((_) async => Future.value(Either.right(lastResponse)));

        return EpisodeCubit(mockRepo);
      },
      act: (bloc) => bloc.loadEpisodes(),
      expect: () {
        return [
          const EpisodeState(
            page: 1,
            isLoading: true,
          ),
          EpisodeState(
              page: 1,
              isLoading: false,
              episodesCurrent: lastResponse.results!,
              isNext: false)
        ];
      },
    );

    blocTest(
      'Episodes, error message',
      build: () {
        when(mockRepo.getEpisodes()).thenAnswer(
            (_) async => await Future.value(Either.left(ErrorFailure.noData)));

        return EpisodeCubit(mockRepo);
      },
      act: (bloc) => bloc.loadEpisodes(),
      expect: () {
        return [
          const EpisodeState(
            page: 1,
            isLoading: true,
          ),
          EpisodeState(
              page: 1,
              isLoading: false,
              error: getErrorBloc(ErrorFailure.noData))
        ];
      },
    );
  });
}
