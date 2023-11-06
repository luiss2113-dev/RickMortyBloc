import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/domain/viewmodels/character_filter.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/data/helpers/http_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';
import '../../domain/models/models.dart';

class CharacterCubit extends Cubit<FeatureState> {
  final RickMortyRepository _rickMortyRepository;

  CharacterCubit(this._rickMortyRepository) : super(FeatureInitial());

  Future<void> loadCharacters({int page = 1}) async {
    emit(FeatureCalled());
    final result = await _rickMortyRepository.getCharacters(page: page);
    result.when(
      (failure) {
        emit(FeatureError(message: getErrorBloc(failure)));
      },
      (characters) {
        emit(
          FeatureLoaded(
            info: characters.info,
            charactersCurrent: [
              ...state.charactersCurrent ?? [],
              ...?characters.results
            ],
          ),
        );
      },
    );
  }

  void fetchMoreCharacters() {
    loadCharacters(page: 1);
  }

  Future<void> filterCharacters(CharacterFilters filters) async {
    emit(FeatureCalled());
    final result = await _rickMortyRepository.filterCharacters(filters);
    result.when((failure) => emit(FeatureError(message: getErrorBloc(failure))),
        (characters) {
      emit(FeatureLoaded(
        info: characters.info,
        charactersCurrent: [
          ...state.charactersCurrent ?? [],
          ...?characters.results
        ],
      ));
    });
  }
}

abstract class FeatureState extends Equatable {
  final List<CharacterItemModel>? charactersCurrent;

  const FeatureState({this.charactersCurrent});
}

class FeatureInitial extends FeatureState {
  @override
  List<Object?> get props => [];
}

class FeatureCalled extends FeatureState {
  @override
  List<Object?> get props => [];
}

class FeatureError extends FeatureState {
  final String? message;

  const FeatureError({this.message});

  @override
  List<Object?> get props => [];
}

class FeatureLoaded extends FeatureState {
  final ResponseInfo? info;

  const FeatureLoaded({
    this.info,
    super.charactersCurrent,
  });

  int get page => info?.pages ?? 1;
  bool get isNext => info?.next != null;

  @override
  List<Object?> get props => [info, charactersCurrent];
}

class CharacterState extends BaseBloc {
  final List<CharacterItemModel> _charactersCurrent;

  const CharacterState({
    List<CharacterItemModel> charactersCurrent = const [],
    String error = '',
    bool isLoading = true,
    bool isNext = true,
    int page = 1,
  })  : _charactersCurrent = charactersCurrent,
        super(
          msgError: error,
          isShowLoading: isLoading,
          currentPage: page,
          isNextPetition: isNext,
        );

  List<CharacterItemModel> get characters => _charactersCurrent;
  bool get isEmpty => _charactersCurrent.isEmpty;

  CharacterState copyWith({
    List<CharacterItemModel>? charactersCurrent,
    String? newError,
    bool? newIsLoading,
    int? newPage,
    bool? newIsNext,
  }) {
    return CharacterState(
      charactersCurrent: charactersCurrent ?? _charactersCurrent,
      error: newError ?? error,
      isLoading: newIsLoading ?? isLoading,
      page: newPage ?? page,
      isNext: newIsNext ?? isNext,
    );
  }

  @override
  String toString() {
    return 'CharacterState(charactersCurrent: ${_charactersCurrent.length}, page: $page, error: $error, isLoading: $isLoading, isNext: $isNext)';
  }

  @override
  List<Object?> get props => [_charactersCurrent, error, isLoading, isNext];
}

class CharacterInitial extends CharacterState {
  const CharacterInitial() : super(page: 1);
}
