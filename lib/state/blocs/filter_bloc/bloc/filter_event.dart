part of 'filter_bloc.dart';

abstract class FilterEvent {}

class ApplyFiltersEvent extends FilterEvent {
  final Map<String, dynamic> params;
  ApplyFiltersEvent({
    required this.params,
  });
}

class ClearFilterEvent extends FilterEvent {}
