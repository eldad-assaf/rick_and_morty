
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  String filterNameBy = '';
  String filterStatusBy = '';
  String filterspeciesBy = '';

  void resetValues() {
    filterNameBy = '';
    filterStatusBy = '';
    filterspeciesBy = '';
  }

  FilterBloc() : super(FilterState.initial()) {
    on<FilterByNameEvent>((event, emit) {
      filterNameBy =
          event.nameFilterType == NameFilter.ascending ? 'asc' : 'desc';
      emit(FilterState.copyWith(nameFilter: event.nameFilterType));
    });

    on<FilterByStatusEvent>((event, emit) {
      filterStatusBy = event.statusFilterType == StatusFilter.alive
          ? 'alive'
          : event.statusFilterType == StatusFilter.dead
              ? 'dead'
              : 'unknown';
      emit(FilterState.copyWith(statusFilter: event.statusFilterType));
    });

    on<FilterBySpeciesEvent>((event, emit) {
      filterspeciesBy = event.speciesFilterType == SpeciesFilter.human
          ? 'human'
          : event.speciesFilterType == SpeciesFilter.alien
              ? 'alien'
              : 'unknown';
      emit(FilterState.copyWith(speciesFilter: event.speciesFilterType));
    });
    on<ClearFilterEvent>((event, emit) {
      resetValues();
      emit(FilterState.initial());
    });
  }
}
