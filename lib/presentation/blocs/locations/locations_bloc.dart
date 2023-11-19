import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/domain/models/models.dart';
import 'package:rick_morty_app/domain/rick_morty_repository.dart';
import 'package:rick_morty_app/domain/viewmodels/viewmodels.dart';

import '../../../data/helpers/http_app.dart';
import '../blocs.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final RickMortyRepository _rickMortyRepository;
  LocationsBloc(this._rickMortyRepository) : super(LocationsInitial()) {
    on<GetLocationsEvent>(loadLocations);
  }

  Future<void> loadLocations(
      GetLocationsEvent event, Emitter<LocationsState> emit) async {
    if (!state.locations.hasNextPage) return;

    if (state.locations.nextPage == 1) {
      emit(state.copyWith(newState: BlocState.loading));
    }

    final result =
        await _rickMortyRepository.getLocations(page: state.locations.nextPage);

    result.when(
      (failure) {
        emit(
          state.copyWith(
            newMessageError: getErrorBloc(failure),
            newState: BlocState.error,
          ),
        );
      },
      (locations) {
        emit(
          state.copyWith(
            newState: BlocState.loaded,
            newLocations: state.locations.copyWith(
              info: locations.info,
              results: [
                ...state.locations.results ?? [],
                ...?locations.results,
              ],
            ),
          ),
        );
      },
    );
  }
}
