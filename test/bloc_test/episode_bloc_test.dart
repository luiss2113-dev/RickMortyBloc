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
  group('Bloc Episode for test Rick and morty API.', () {
    final episode = EpisodeItemModel(
        created: DateTime.now(),
        name: 'Rick',
        episode: 'CS4550',
        id: 23,
        characters: const ['Caramelo', 'cafe', 'postre']);
    const info = ResponseInfo(pages: 1, next: 'null?page=2', prev: '');
    const lastInfo = ResponseInfo(
      pages: 42,
      next: null,
    );
    final response = Episodes(info: info, results: [episode]);
    final lastResponse = Episodes(info: lastInfo, results: [episode]);
    const responseEmpy = Episodes(info: info, results: []);
    final mockRepo = MockRickMortyRepository();

    blocTest(
      'Episodes are loaded correcty when call firts time getEpisodes reporitory function, success',
      build: () {
        when(mockRepo.getEpisodes())
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return EpisodeBloc(mockRepo);
      },
      act: (bloc) => bloc..add(const GetEpisodeEvent()),
      expect: () {
        return [
          const EpisodeState(state: BlocState.loading),
          EpisodeState(episodes: response, state: BlocState.loaded)
        ];
      },
    );

    blocTest(
      'Episode are loaded correcty when calling second or more times getEpisodes reporitory function, success',
      build: () {
        when(mockRepo.getEpisodes(page: 2))
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return EpisodeBloc(mockRepo);
      },
      act: (bloc) {
        bloc.emit(bloc.state.copyWith(
          episodes: response,
          state: BlocState.loaded,
        ));
        return bloc..add(const GetEpisodeEvent());
      },
      expect: () {
        return [
          EpisodeState(episodes: response, state: BlocState.loaded),
          EpisodeState(
              episodes: response.copyWith(results: [episode, episode]),
              state: BlocState.loaded),
        ];
      },
    );

    blocTest(
      'Episodes are loaded empty correcty when I call getEpisodes reporitory function, success',
      build: () {
        when(mockRepo.getEpisodes())
            .thenAnswer((_) async => Future.value(Either.right(responseEmpy)));

        return EpisodeBloc(mockRepo);
      },
      act: (bloc) => bloc..add(const GetEpisodeEvent()),
      expect: () {
        return [
          const EpisodeState(state: BlocState.loading),
          const EpisodeState(
            state: BlocState.loaded,
            episodes: responseEmpy,
          )
        ];
      },
    );

    blocTest(
      'Episodes no call by function when next property is null',
      build: () {
        when(mockRepo.getEpisodes())
            .thenAnswer((_) async => Future.value(Either.right(lastResponse)));

        return EpisodeBloc(mockRepo);
      },
      act: (bloc) => bloc..add(const GetEpisodeEvent()),
      expect: () {
        return [
          const EpisodeState(state: BlocState.loading),
          EpisodeState(
            state: BlocState.loaded,
            episodes: lastResponse,
          )
        ];
      },
    );

    blocTest(
      'Episodes, error message',
      build: () {
        when(mockRepo.getEpisodes()).thenAnswer(
            (_) async => await Future.value(Either.left(ErrorFailure.noData)));

        return EpisodeBloc(mockRepo);
      },
      act: (bloc) => bloc..add(const GetEpisodeEvent()),
      expect: () {
        return [
          const EpisodeState(state: BlocState.loading),
          EpisodeState(
              state: BlocState.error,
              messageError: getErrorBloc(ErrorFailure.noData))
        ];
      },
    );
  });
}
