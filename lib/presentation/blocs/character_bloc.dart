import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import '../../domain/models/models.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final RickMortyRepository _rickMortyRepository;

  CharacterCubit(this._rickMortyRepository) : super(CharacterInitial());

  Future<void> loadCharacters({int page = 1}) async {
    emit(CharatersLoading());
    final result = await _rickMortyRepository.getCharacters(page: page);
    result.when((failure) {
      emit(CharactersError(error: getErrorBloc(failure)));
    }, (characters) {
      emit(state.copyWith(
        charactersCurrent: [...state.charactersCurrent, ...?characters.results],
        info: characters.info,
      ));
      emit(CharactersLoaded());
    });
  }

  Future<void> filterCharacters(CharacterFilters filters) async {
    emit(CharatersLoading());
    final result = await _rickMortyRepository.filterCharacters(filters);
    result
        .when((failure) => emit(CharactersError(error: getErrorBloc(failure))),
            (characters) {
      emit(state.copyWith(
        charactersCurrent: characters.results,
        info: characters.info,
      ));
      emit(CharactersLoaded());
    });
  }
}

class CharacterState extends Equatable {
  final List<ItemCharacter> charactersCurrent;
  final ResponseInfo? info;
  final ItemCharacter? selected;

  const CharacterState(
      {this.charactersCurrent = const [], this.info, this.selected});

  CharacterState copyWith({
    List<ItemCharacter>? charactersCurrent,
    final ResponseInfo? info,
    ItemCharacter? selected,
  }) {
    return CharacterState(
      charactersCurrent: charactersCurrent ?? this.charactersCurrent,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharatersLoading extends CharacterState {}

class CharactersLoaded extends CharacterState {}

class CharacterSelected extends CharacterState {}

class CharactersError extends CharacterState {
  final String error;

  const CharactersError({this.error = ''});

  @override
  List<Object> get props => [error];
}
