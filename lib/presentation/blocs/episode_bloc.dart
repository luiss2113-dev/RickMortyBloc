import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/models.dart';
import '../../data/helpers/http_app.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final RickMortyRepository _rickMortyRepository;
  EpisodeCubit(this._rickMortyRepository) : super(EpisodeInitial());

  Future<void> loadEpisodes({int page = 1}) async {
    if (!state.isNext) return;
    if (page == 1) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await _rickMortyRepository.getEpisodes(page: page);
    result.when((failure) {
      emit(
        state.copyWith(
          error: getErrorBloc(failure),
          isLoading: false,
        ),
      );
    }, (episodes) {
      emit(state.copyWith(
        error: "",
        isLoading: false,
        episodesCurrent: [...state._episodes, ...?episodes.results],
        page: page,
        isNext: episodes.isNext,
      ));
    });
  }

  void fetchMoreLocations() {
    loadEpisodes(page: state.page + 1);
  }

  void selectedLocation(
    EpisodeItemModel episode,
  ) {
    emit(state.copyWith(episode: episode));
  }
}

class EpisodeState extends Equatable {
  final List<EpisodeItemModel> _episodes;
  final EpisodeItemModel? _episode;
  final String _error;
  final bool _isLoading;
  final int _page;
  final bool _isNext;

  const EpisodeState({
    List<EpisodeItemModel> episodesCurrent = const [],
    String error = '',
    bool isLoading = true,
    bool isNext = true,
    EpisodeItemModel? episode,
    int page = 1,
  })  : _episodes = episodesCurrent,
        _error = error,
        _isLoading = isLoading,
        _page = page,
        _isNext = isNext,
        _episode = episode;

  List<EpisodeItemModel> get episodes => _episodes;
  String get error => _error;
  bool get isLoading => _isLoading;
  int get page => _page;
  EpisodeItemModel? get episode => _episode;
  bool get isError => _error != '';
  bool get isNext => _isNext;
  bool get isEmpty => _episodes.isEmpty;

  @override
  List<Object?> get props => [_episodes, _error, _isLoading, _isNext];

  @override
  String toString() {
    return 'EpisodeState{episodesCurrent: ${_episodes.length}, error: $_error, isLoading: $_isLoading isNext: $_isNext}';
  }

  EpisodeState copyWith({
    List<EpisodeItemModel>? episodesCurrent,
    String? error,
    bool? isLoading,
    int? page,
    bool? isNext,
    EpisodeItemModel? episode,
  }) {
    return EpisodeState(
      episodesCurrent: episodesCurrent ?? _episodes,
      error: error ?? _error,
      isLoading: isLoading ?? _isLoading,
      page: page ?? _page,
      isNext: isNext ?? _isNext,
      episode: episode ?? _episode,
    );
  }
}

class EpisodeInitial extends EpisodeState {}
