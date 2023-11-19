part of 'locations_bloc.dart';

sealed class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

final class GetLocationsEvent extends LocationsEvent {
  const GetLocationsEvent();
}

final class FilterLocationsEvent extends LocationsEvent {
  final LocationFilters filters;
  const FilterLocationsEvent({required this.filters});

  @override
  List<Object> get props => [filters];
}
