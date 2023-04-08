part of 'filter_bloc.dart';

abstract class FilterEvent {}

class ApplyFiltersEvent extends FilterEvent {
  final Map<String, dynamic>? filterParams;
  ApplyFiltersEvent({required this.filterParams});
}




class ClearFilterEvent extends FilterEvent {}
