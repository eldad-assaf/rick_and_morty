part of 'filter_bloc.dart';

abstract class FilterEvent {}

class FilterSelectionEvent extends FilterEvent {
  final String nameFilterType;

  FilterSelectionEvent({required this.nameFilterType});
}
