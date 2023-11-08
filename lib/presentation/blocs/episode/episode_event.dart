part of 'episode_bloc.dart';

sealed class EpisodeEvent extends Equatable {
  const EpisodeEvent();

  @override
  List<Object> get props => [];
}

final class GetEpisodeEvent extends EpisodeEvent {
  const GetEpisodeEvent();
}

final class FilterEpisodeEvent extends EpisodeEvent {
  final EpisodeFilters filters;
  const FilterEpisodeEvent({
    required this.filters,
  });

  @override
  List<Object> get props => [filters];
}
