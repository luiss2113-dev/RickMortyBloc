import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';
import '../../domain/models/models.dart';
import '../../data/helpers/http_app.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final RickMortyRepository _rickMortyRepository;
  EpisodeCubit(this._rickMortyRepository) : super(EpisodeInitial());

  Future<void> loadEpisodes({int page = 1}) async {
    if (!state.isNext) return;
    if (page == 1) {
      emit(state.copyWith(newIsLoading: true));
    }
    final result = await _rickMortyRepository.getEpisodes(page: page);
    result.when((failure) {
      emit(
        state.copyWith(
          newError: getErrorBloc(failure),
          newIsLoading: false,
        ),
      );
    }, (episodes) {
      emit(state.copyWith(
        newError: "",
        newIsLoading: false,
        episodesCurrent: [...state._episodes, ...?episodes.results],
        newPage: page,
        newIsNext: episodes.hasNextPage,
      ));
    });
  }

  void fetchMoreLocations() {
    loadEpisodes(page: state.page + 1);
  }
}

class EpisodeState extends BaseBloc {
  final List<EpisodeItemModel> _episodes;

  const EpisodeState({
    List<EpisodeItemModel> episodesCurrent = const [],
    String error = '',
    bool isLoading = true,
    bool isNext = true,
    int page = 1,
  })  : _episodes = episodesCurrent,
        super(
          msgError: error,
          isShowLoading: isLoading,
          currentPage: page,
          isNextPetition: isNext,
        );

  List<EpisodeItemModel> get episodes => _episodes;
  bool get isEmpty => _episodes.isEmpty;

  EpisodeState copyWith({
    List<EpisodeItemModel>? episodesCurrent,
    String? newError,
    bool? newIsLoading,
    int? newPage,
    bool? newIsNext,
  }) {
    return EpisodeState(
      episodesCurrent: episodesCurrent ?? _episodes,
      error: newError ?? error,
      isLoading: newIsLoading ?? isLoading,
      page: newPage ?? page,
      isNext: newIsNext ?? isNext,
    );
  }

  @override
  List<Object?> get props => [_episodes, error, isLoading, isNext];

  @override
  String toString() {
    return 'EpisodeState{episodesCurrent: ${_episodes.length}, error: $error, isLoading: $isLoading isNext: $isNext}';
  }
}

class EpisodeInitial extends EpisodeState {}
