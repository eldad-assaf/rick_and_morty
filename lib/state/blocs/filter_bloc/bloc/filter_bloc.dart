
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
part 'filter_state.dart';
part 'filter_event.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const UnFilterdListState(null)) {
    on<ApplyFiltersEvent>((event, emit) {
      emit(FilterdListState(filterParams: event.filterParams));
    });

    on<ClearFilterEvent>((event, emit) {
      emit(const UnFilterdListState(null));
    });
  }
}
