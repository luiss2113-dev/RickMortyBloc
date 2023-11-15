part of 'locations_bloc.dart';

final class LocationsState extends Equatable {
  final BlocState state;
  final Locations locations;
  final String messageError;

  const LocationsState({
    this.state = BlocState.initial,
    this.locations = const Locations(info: ResponseInfo(next: '')),
    this.messageError = '',
  });

  LocationsState copyWith({
    BlocState? newState,
    Locations? newLocations,
    String? newMessageError,
  }) {
    return LocationsState(
      state: newState ?? state,
      locations: newLocations ?? locations,
      messageError: newMessageError ?? messageError,
    );
  }

  @override
  List<Object> get props => [locations, state, messageError];

  @override
  String toString() {
    return 'LocationsState{locationsCurrent: ${locations.toJson()}, state: $state, messageError: $messageError}';
  }
}

final class LocationsInitial extends LocationsState {}
