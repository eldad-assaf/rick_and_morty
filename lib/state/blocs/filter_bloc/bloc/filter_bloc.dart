import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  String nameFilterType = 'asc';

  FilterBloc() : super(FilterState.initial()) {
    on<FilterSelectionEvent>((event, emit) {
      nameFilterType = event.nameFilterType;
      log(nameFilterType);

      emit(FilterState.copyWith(
          nameFilter: nameFilterType == 'asc'
              ? NameFilter.ascending
              : NameFilter.descending));
    });
  }
}
