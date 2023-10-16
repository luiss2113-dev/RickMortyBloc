import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/models.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final RickMortyRepository _rickMortyRepository;

  CharacterCubit(this._rickMortyRepository) : super(const CharacterInitial());

  Future<void> loadCharacters({int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await _rickMortyRepository.getCharacters(page: page);
    result.when((failure) {
      emit(
        state.copyWith(
          error: getErrorBloc(failure),
          isLoading: false,
        ),
      );
    }, (characters) {
      emit(state.copyWith(
        error: "",
        isLoading: false,
        charactersCurrent: [...state.charactersCurrent, ...?characters.results],
        page: page,
      ));
    });
  }

  void setSelectedCharacter(CharacterItemModel character) {
    emit(state.copyWith(
      selected: character,
    ));
  }

  Future<void> filterCharacters(CharacterFilters filters) async {
    emit(state.copyWith(isLoading: true, error: ''));
    final result = await _rickMortyRepository.filterCharacters(filters);
    result.when(
        (failure) => emit(
              state.copyWith(
                error: getErrorBloc(failure),
                isLoading: false,
              ),
            ), (characters) {
      emit(state.copyWith(
        error: "",
        isLoading: false,
        charactersCurrent: characters.results ?? [],
      ));
    });
  }
}

class CharacterState extends Equatable {
  final List<CharacterItemModel> charactersCurrent;
  final CharacterItemModel? selected;
  final int page;
  final String error;
  final bool isLoading;

  const CharacterState({
    this.charactersCurrent = const [],
    this.selected,
    this.page = 1,
    this.error = '',
    this.isLoading = true,
  });

  CharacterState copyWith({
    List<CharacterItemModel>? charactersCurrent,
    CharacterItemModel? selected,
    int? page,
    String? error,
    bool? isLoading,
  }) {
    return CharacterState(
      charactersCurrent: charactersCurrent ?? this.charactersCurrent,
      selected: selected ?? this.selected,
      page: page ?? this.page,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'CharacterState(charactersCurrent: ${charactersCurrent.length}, selected: $selected, page: $page, error: $error, isLoading: $isLoading)';
  }

  @override
  List<Object> get props => [charactersCurrent, page, error, isLoading];
}

class CharacterInitial extends CharacterState {
  const CharacterInitial() : super(page: 1);
}

class CharatersLoading extends CharacterState {
  const CharatersLoading({
    required List<CharacterItemModel> charactersCurrent,
  }) : super(charactersCurrent: charactersCurrent);
}

class CharactersLoaded extends CharacterState {
  const CharactersLoaded({
    required List<CharacterItemModel> charactersCurrent,
    ResponseInfo? info,
    required int page,
  }) : super(
          page: page,
          charactersCurrent: charactersCurrent,
        );
}

class CharacterSelected extends CharacterState {
  const CharacterSelected({
    required List<CharacterItemModel> charactersCurrent,
    CharacterItemModel? selected,
    required int page,
  }) : super(
            charactersCurrent: charactersCurrent,
            selected: selected,
            page: page);
}

class CharactersError extends CharacterState {
  final String error;

  const CharactersError({this.error = ''});

  @override
  List<Object> get props => [error];
}
