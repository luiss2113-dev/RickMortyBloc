import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:rick_morty_app/utils/enums.dart';
import 'package:rick_morty_app/presentation/blocs/blocs.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/domain/models/models.dart';
import 'package:rick_morty_app/data/helpers/either.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'character_bloc_test.mocks.dart';

@GenerateMocks([RickMortyRepository])
void main() {
  group('Bloc Characters for test', () {
    final character = CharacterItemModel(
      created: DateTime.now(),
      name: 'Rick',
      episode: const ['Caramelo', 'cafe', 'postre'],
      gender: GenderCharacter.female,
    );
    const info = ResponseInfo(
      pages: 42,
      next: "https://rickandmortyapi.com/api/character?page=2",
    );
    const lastInfo = ResponseInfo(
      pages: 42,
      next: null,
    );
    final response = Characters(info: info, results: [character]);

    const responseEmpy = Characters(info: info, results: []);
    final mockRepo = MockRickMortyRepository();

    blocTest(
      'Characters are loaded correcty when call firts time getCharacters reporitory function',
      build: () {
        when(mockRepo.getCharacters())
            .thenAnswer((_) async => Future.value(Either.right(response)));

        return CharacterBloc(mockRepo);
      },
      act: (bloc) {
        return bloc..add(const GetCharacterEvent());
      },
      expect: () {
        return [
          const CharacterState(state: BlocState.loading),
          CharacterState(
              characters:
                  Characters(info: response.info, results: response.results),
              state: BlocState.loaded),
        ];
      },
    );

    blocTest(
        'Characters are loaded correcty when calling second or more times getCharacters reporitory function',
        build: () {
      when(mockRepo.getCharacters(page: 2))
          .thenAnswer((_) async => Future.value(Either.right(response)));

      return CharacterBloc(mockRepo);
    }, act: (bloc) {
      bloc.emit(bloc.state.copyWith(
          characters: Characters(info: info, results: [character]),
          state: BlocState.loaded));
      return bloc..add(const GetCharacterEvent());
    }, expect: () {
      return [
        CharacterState(
            characters: Characters(info: response.info, results: [character]),
            state: BlocState.loaded),
        CharacterState(
            characters: Characters(
                info: response.info,
                results: [character, ...response.results!]),
            state: BlocState.loaded),
      ];
    });

    blocTest(
        'Characters are loaded empty correcty when I call getCharacters reporitory function',
        build: () {
      when(mockRepo.getCharacters())
          .thenAnswer((_) async => Future.value(Either.right(responseEmpy)));
      return CharacterBloc(mockRepo);
    }, act: (bloc) {
      return bloc..add(const GetCharacterEvent());
    }, expect: () {
      return [
        const CharacterState(state: BlocState.loading),
        CharacterState(
            characters: Characters(info: response.info, results: const []),
            state: BlocState.loaded),
      ];
    });

    blocTest('Characters no called when next is null are lastest results',
        build: () {
      when(mockRepo.getCharacters())
          .thenAnswer((_) async => Future.value(Either.right(responseEmpy)));
      return CharacterBloc(mockRepo);
    }, act: (bloc) {
      bloc.emit(bloc.state.copyWith(
          characters: Characters(
              info: lastInfo, results: [character, character, character]),
          state: BlocState.loaded));
      return bloc..add(const GetCharacterEvent());
    }, expect: () {
      return [
        CharacterState(
            characters: Characters(
                info: lastInfo, results: [character, character, character]),
            state: BlocState.loaded)
      ];
    });

    blocTest(
        'Characters are loaded empty correcty when I call getCharacters reporitory function',
        build: () {
      when(mockRepo.getCharacters())
          .thenAnswer((_) async => Future.value(Either.right(responseEmpy)));
      return CharacterBloc(mockRepo);
    }, act: (bloc) {
      return bloc..add(const GetCharacterEvent());
    }, expect: () {
      return [
        const CharacterState(state: BlocState.loading),
        CharacterState(
            characters: Characters(info: response.info, results: const []),
            state: BlocState.loaded),
      ];
    });

    blocTest('Characters when call API return error exceptions', build: () {
      when(mockRepo.getCharacters()).thenAnswer(
          (_) async => await Future.value(Either.left(ErrorFailure.noData)));

      return CharacterBloc(mockRepo);
    }, act: (bloc) {
      return bloc..add(const GetCharacterEvent());
    }, expect: () {
      return [
        const CharacterState(state: BlocState.loading),
        CharacterState(
            messageError: getErrorBloc(ErrorFailure.noData),
            state: BlocState.error),
      ];
    });
  });
}
