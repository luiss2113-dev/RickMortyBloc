import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/domain/models/models.dart';
import 'package:rick_morty_app/domain/viewmodels/viewmodels.dart';
import 'package:rick_morty_app/presentation/blocs/blocs.dart';

import '../../../data/helpers/http_app.dart';
import '../../../domain/rick_morty_repository.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final RickMortyRepository _rickMortyRepository;
  EpisodeBloc(this._rickMortyRepository) : super(EpisodeInitial()) {
    on<GetEpisodeEvent>(_loadEpisodes);
  }

  Future<void> _loadEpisodes(
      GetEpisodeEvent event, Emitter<EpisodeState> emit) async {
    if (!state.episodes.hasNextPage) return;

    if (state.episodes.nextPage == 1) {
      emit(state.copyWith(state: BlocState.loading));
    }

    final result =
        await _rickMortyRepository.getEpisodes(page: state.episodes.nextPage);

    result.when(
      (failure) {
        emit(state.copyWith(
            state: BlocState.error, message: getErrorBloc(failure)));
      },
      (episodes) {
        emit(
          state.copyWith(
            state: BlocState.loaded,
            episodes: state.episodes.copyWith(
              info: ResponseInfo(
                pages: episodes.info?.pages,
                next: episodes.info?.next,
                prev: episodes.info?.prev,
              ),
              results: [
                ...state.episodes.results ?? [],
                ...?episodes.results,
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> filterEpisode(
      FilterEpisodeEvent event, Emitter<EpisodeState> emit) async {
    emit(state.copyWith(state: BlocState.loading));
    final result = await _rickMortyRepository.filterEpisodes(event.filters);
    result.when(
        (failure) => emit(state.copyWith(
            state: BlocState.error,
            message: getErrorBloc(failure))), (episode) {
      emit(
        state.copyWith(
          state: BlocState.loaded,
          episodes: state.episodes.copyWith(
            info: ResponseInfo(
              pages: episode.info?.pages,
              next: episode.info?.next,
              prev: episode.info?.prev,
            ),
            results: [
              ...state.episodes.results ?? [],
              ...?episode.results,
            ],
          ),
        ),
      );
    });
  }
}
