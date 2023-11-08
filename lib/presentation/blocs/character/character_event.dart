part of 'character_bloc.dart';

sealed class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

final class GetCharacterEvent extends CharacterEvent {
  const GetCharacterEvent();
}

final class FilterCharacterEvent extends CharacterEvent {
  final CharacterFilters filters;
  const FilterCharacterEvent({
    required this.filters,
  });

  @override
  List<Object> get props => [filters];
}
