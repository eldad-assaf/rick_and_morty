part of 'filter_bloc.dart';

abstract class FilterEvent {}

// class FilterByNameEvent extends FilterEvent {
//   final NameFilter nameFilterType;

//   FilterByNameEvent({
//     required this.nameFilterType,
//   });
// }

class FilterByStatusEvent extends FilterEvent {
  final StatusFilter statusFilterType;

  FilterByStatusEvent({
    required this.statusFilterType,
  });
}

class FilterBySpeciesEvent extends FilterEvent {
  final SpeciesFilter speciesFilterType;

  FilterBySpeciesEvent({
    required this.speciesFilterType,
  });
}

class ApplyFiltersEvent extends FilterEvent{}

class ClearFilterEvent extends FilterEvent{}
