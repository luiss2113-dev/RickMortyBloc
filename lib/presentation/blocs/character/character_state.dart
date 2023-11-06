part of 'character_bloc.dart';

enum BlocState { initial, loading, loaded, error }

final class CharacterState extends Equatable {
  final BlocState state;
  final Characters characters;
  final String messageError;

  const CharacterState({
    this.state = BlocState.initial,
    this.characters = const Characters(info: ResponseInfo(next: '')),
    this.messageError = '',
  });

  CharacterState copyWith({
    BlocState? state,
    Characters? characters,
    String? message,
  }) {
    return CharacterState(
      state: state ?? this.state,
      characters: characters ?? this.characters,
      messageError: message ?? messageError,
    );
  }

  @override
  String toString() {
    return 'CharacterState(state: $state, characters:${characters.toJson()} messageError: $messageError)';
  }

  @override
  List<Object> get props => [state, characters, messageError];
}
