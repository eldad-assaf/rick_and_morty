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
      //  emit(FilterState.copyWith(statusFilter: event.statusFilterType));
    });

    on<FilterBySpeciesEvent>((event, emit) {
      filterspeciesBy = event.speciesFilterType == SpeciesFilter.human
          ? 'human'
          : event.speciesFilterType == SpeciesFilter.alien
              ? 'alien'
              : 'unknown';
      // emit(FilterState.copyWith(speciesFilter: event.speciesFilterType));
    });
    on<ApplyFiltersEvent>((event, emit) {});

    on<ClearFilterEvent>((event, emit) {
      resetValues();
      emit(FilterState.initial());
    });
  }
}
