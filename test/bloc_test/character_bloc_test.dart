import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/data/helpers/either.dart';
import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:rick_morty_app/domain/models/models.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/presentation/blocs/character_bloc.dart';
import 'package:rick_morty_app/utils/enums.dart';

import 'character_bloc_test.mocks.dart';

@GenerateMocks([RickMortyRepository])
void main() {
  group('Bloc Characters for test', () {
    final character = ItemCharacter(
      created: DateTime.now(),
      name: 'Rick',
      episode: ['Caramelo', 'cafe', 'postre'],
      gender: GenderCharacter.female,
    );
    final info = ResponseInfo(count: 1, pages: 1, next: '', prev: '');
    final response = Characters(info: info, results: [character]);
    final responseEmpy = Characters(info: info, results: []);
    final mockRepo = MockRickMortyRepository();

    blocTest(
        'Characters are loaded correcty when I call getCharacters reporitory function',
        build: () {
          when(mockRepo.getCharacters())
              .thenAnswer((_) async => Future.value(Either.right(response)));

          return CharacterCubit(mockRepo);
        },
        act: (bloc) => bloc.loadCharacters(),
        expect: () {
          return [
            CharatersLoading(),
            CharacterState(
                charactersCurrent: response.results!, info: response.info),
            CharactersLoaded(),
          ];
        });

    blocTest(
        'Characters are loaded empty correcty when I call getCharacters reporitory function',
        build: () {
          when(mockRepo.getCharacters()).thenAnswer(
              (_) async => Future.value(Either.right(responseEmpy)));

          return CharacterCubit(mockRepo);
        },
        act: (bloc) => bloc.loadCharacters(),
        expect: () {
          return [
            CharatersLoading(),
            CharacterState(
                charactersCurrent: response.results!, info: response.info),
            CharactersLoaded(),
          ];
        });

    blocTest('Characters error exceptions',
        build: () {
          when(mockRepo.getCharacters()).thenAnswer((_) async =>
              await Future.value(
                  Either.left(ErrorFailure.noData)));

          return CharacterCubit(mockRepo);
        },
        act: (bloc) => bloc.loadCharacters(),
        expect: () {
          return [CharatersLoading(),
          CharactersError(error: getErrorBloc(ErrorFailure.noData))];
        });
  });
}
