import 'package:rick_morty_app/domain/models/models.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../data/helpers/http_app.dart';

part 'character_state.dart';
part 'character_event.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final RickMortyRepository _rickMortyRepository;
  CharacterBloc(this._rickMortyRepository) : super(const CharacterState()) {
    on<GetCharacterEvent>(_loadCharacters);
  }

  Future<void> _loadCharacters(
      GetCharacterEvent event, Emitter<CharacterState> emit) async {
    if (!state.characters.hasNextPage) return;

    if (state.characters.nextPage == 1) {
      emit(state.copyWith(state: BlocState.loading));
    }

    final result = await _rickMortyRepository.getCharacters(
        page: state.characters.nextPage);
    result.when(
      (failure) {
        emit(state.copyWith(
            state: BlocState.error, message: getErrorBloc(failure)));
      },
      (characters) {
        emit(
          state.copyWith(
            state: BlocState.loaded,
            characters: state.characters.copyWith(
              info: ResponseInfo(
                pages: characters.info?.pages,
                next: characters.info?.next,
                prev: characters.info?.prev,
              ),
              results: [
                ...state.characters.results ?? [],
                ...characters.results ?? []
              ],
            ),
          ),
        );
      },
    );
  }
}
