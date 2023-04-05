
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const UnFilterdCharactersState(null)) {
    on<ApplyFiltersEvent>((event, emit) {
      emit(FilterdCharactersState(params: event.params));
    });

    on<ClearFilterEvent>((event, emit) {
      emit(const UnFilterdCharactersState(null));
    });
  }
}
