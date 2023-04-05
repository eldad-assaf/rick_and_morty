import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  String filterStatusBy = '';
  String filterspeciesBy = '';
  String filterGenderBy = '';

  void resetValues() {
    filterStatusBy = '';
    filterspeciesBy = '';
    filterGenderBy = '';
  }

  FilterBloc() : super(FilterState.initial()) {
    on<FilterByStatusEvent>((event, emit) {
      filterStatusBy = event.statusFilterType == StatusFilter.alive
          ? 'alive'
          : event.statusFilterType == StatusFilter.dead
              ? 'dead'
              : 'unknown';
      log('FilterByStatusEvent emmiting state with : status ${event.statusFilterType}  ');

      emit(state.copyWith(
          statusFilter: event.statusFilterType, applyFilter: false));
    });

    on<FilterBySpeciesEvent>((event, emit) {
      filterspeciesBy = event.speciesFilterType == SpeciesFilter.human
          ? 'human'
          : event.speciesFilterType == SpeciesFilter.alien
              ? 'alien'
              : 'unknown';
      log('FilterBySpeciesEvent emmiting state with : species ${event.speciesFilterType}  ');

      emit(state.copyWith(
          speciesFilter: event.speciesFilterType, applyFilter: false));
    });
    on<ApplyFiltersEvent>((event, emit) {
      emit(state.copyWith(applyFilter: true));
    });

    on<ClearFilterEvent>((event, emit) {
      resetValues();
      emit(FilterState.initial());
    });
  }
}
