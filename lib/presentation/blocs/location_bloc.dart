import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';
import '../../domain/models/models.dart';
import '../../data/helpers/http_app.dart';

class LocationCubit extends Cubit<LocationState> {
  final RickMortyRepository _rickMortyRepository;
  LocationCubit(this._rickMortyRepository) : super(LocationsInitial());

  Future<void> loadLocations({int page = 1}) async {
    if (!state.isNext) return;
    if (page == 1) {
      emit(state.copyWith(newIsLoading: true));
    }
    final result = await _rickMortyRepository.getLocations(page: page);
    result.when((failure) {
      emit(
        state.copyWith(
          newError: getErrorBloc(failure),
          newIsLoading: false,
        ),
      );
    }, (locations) {
      emit(state.copyWith(
          newError: "",
          newIsLoading: false,
          locationsCurrent: [...state._locations, ...?locations.results],
          newPage: page,
          newIsNext: locations.isNext));
    });
  }

  void fetchMoreLocations() {
    loadLocations(page: state.page + 1);
  }
}

class LocationState extends BaseBloc {
  final List<LocationItemModel> _locations;

  const LocationState({
    List<LocationItemModel> locations = const [],
    String msgError = '',
    bool isLoading = true,
    bool isNext = true,
    int page = 1,
  })  : _locations = locations,
        super(
          msgError: msgError,
          isShowLoading: isLoading,
          currentPage: page,
          isNextPetition: isNext,
        );

  List<LocationItemModel> get locations => _locations;
  bool get isEmpty => _locations.isEmpty;

  LocationState copyWith({
    List<LocationItemModel>? locationsCurrent,
    String? newError,
    bool? newIsLoading,
    int? newPage,
    bool? newIsNext,
  }) {
    return LocationState(
      locations: locationsCurrent ?? _locations,
      msgError: newError ?? error,
      isLoading: newIsLoading ?? isLoading,
      page: newPage ?? page,
      isNext: newIsNext ?? isNext,
    );
  }

  @override
  List<Object?> get props => [_locations, error, isLoading, isNext];

  @override
  String toString() {
    return 'LocationsState{locationsCurrent: ${_locations.length}, error: $error, isLoading: $isLoading, isNext: $isNext}';
  }
}

class LocationsInitial extends LocationState {}
