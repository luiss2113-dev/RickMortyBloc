import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/domain/rick_morty_repository.dart';

import '../../data/helpers/http_app.dart';
import '../../domain/models/models.dart';

class LocationCubit extends Cubit<LocationState> {
  final RickMortyRepository _rickMortyRepository;
  LocationCubit(this._rickMortyRepository) : super(LocationsInitial());

  Future<void> loadLocations({int page = 1}) async {
    if (!state.isNext) return;
    if (page == 1) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await _rickMortyRepository.getLocations(page: page);
    result.when((failure) {
      emit(
        state.copyWith(
          error: getErrorBloc(failure),
          isLoading: false,
        ),
      );
    }, (locations) {
      emit(state.copyWith(
          error: "",
          isLoading: false,
          locationsCurrent: [...state._locations, ...?locations.results],
          page: page,
          isNext: locations.isNext));
    });
  }

  void fetchMoreLocations() {
    loadLocations(page: state.page + 1);
  }
}

class LocationState extends Equatable {
  final List<LocationItemModel> _locations;
  final String _error;
  final bool _isLoading;
  final int _page;
  final bool _isNext;

  const LocationState({
    List<LocationItemModel> locations = const [],
    String error = '',
    bool isLoading = true,
    bool isNext = true,
    int page = 1,
  })  : _locations = locations,
        _error = error,
        _isLoading = isLoading,
        _page = page,
        _isNext = isNext;

  List<LocationItemModel> get locations => _locations;
  String get error => _error;
  bool get isLoading => _isLoading;
  int get page => _page;
  bool get isError => _error != '';
  bool get isNext => _isNext;
  bool get isEmpty => _locations.isEmpty;

  @override
  List<Object?> get props => [_locations, _error, _isLoading, _isNext];

  @override
  String toString() {
    return 'LocationsState{locationsCurrent: ${_locations.length}, error: $_error, isLoading: $_isLoading, isNext: $_isNext}';
  }

  LocationState copyWith({
    List<LocationItemModel>? locationsCurrent,
    String? error,
    bool? isLoading,
    int? page,
    bool? isNext,
  }) {
    return LocationState(
      locations: locationsCurrent ?? _locations,
      error: error ?? _error,
      isLoading: isLoading ?? _isLoading,
      page: page ?? _page,
      isNext: isNext ?? _isNext,
    );
  }
}

class LocationsInitial extends LocationState {}
