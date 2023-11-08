part of 'episode_bloc.dart';

final class EpisodeState extends Equatable {
  final BlocState state;
  final Episodes episodes;
  final String messageError;

  const EpisodeState({
    this.state = BlocState.initial,
    this.episodes = const Episodes(info: ResponseInfo(next: '')),
    this.messageError = '',
  });

  EpisodeState copyWith({
    BlocState? state,
    Episodes? episodes,
    String? message,
  }) {
    return EpisodeState(
      state: state ?? this.state,
      episodes: episodes ?? this.episodes,
      messageError: message ?? messageError,
    );
  }

  @override
  String toString() =>
      'EpisodeState(state: $state, episodes: ${episodes.toJson()})';

  @override
  List<Object> get props => [episodes, state, messageError];
}

final class EpisodeInitial extends EpisodeState {}
