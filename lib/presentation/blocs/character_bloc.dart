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
    if (!state.isNext) return;
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
        charactersCurrent: [...state.characters, ...?characters.results],
        page: page,
      ));
    });
  }

  void fetchMoreCharacters() {
    loadCharacters(page: state.page + 1);
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
        isNext: characters.isNext,
      ));
    });
  }
}

class CharacterState extends Equatable {
  final List<CharacterItemModel> _charactersCurrent;
  final int _page;
  final String _error;
  final bool _isLoading;
  final bool _isNext;

  const CharacterState({
    List<CharacterItemModel> charactersCurrent = const [],
    int page = 1,
    String error = '',
    bool isLoading = true,
    bool isNext = true,
  })  : _isLoading = isLoading,
        _error = error,
        _page = page,
        _charactersCurrent = charactersCurrent,
        _isNext = isNext;

  List<CharacterItemModel> get characters => _charactersCurrent;
  int get page => _page;
  bool get isLoading => _isLoading;
  bool get isError => _error != '';
  String get errorCurrent => _error;
  bool get isNext => _isNext;
  bool get isEmpty => _charactersCurrent.isEmpty;

  CharacterState copyWith({
    List<CharacterItemModel>? charactersCurrent,
    int? page,
    String? error,
    bool? isLoading,
    bool? isNext,
  }) {
    return CharacterState(
      charactersCurrent: charactersCurrent ?? _charactersCurrent,
      page: page ?? _page,
      error: error ?? _error,
      isLoading: isLoading ?? _isLoading,
      isNext: isNext ?? _isNext,
    );
  }

  @override
  String toString() {
    return 'CharacterState(charactersCurrent: ${_charactersCurrent.length}, page: $_page, error: $_error, isLoading: $_isLoading, isNext: $_isNext)';
  }

  @override
  List<Object> get props => [_charactersCurrent, _error, _isLoading, _isNext];
}

class CharacterInitial extends CharacterState {
  const CharacterInitial() : super(page: 1);
}
