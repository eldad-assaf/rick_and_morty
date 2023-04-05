part of 'filter_bloc.dart';

//enum FilterType { nameFilter, statusFilter, speciesFilter }

enum StatusFilter { alive, dead, unknown }

enum SpeciesFilter { human, alien, unknown }

class FilterState extends Equatable {
  final StatusFilter? statusFilter;
  final SpeciesFilter? speciesFilter;
  final bool applyFilter;

  const FilterState({
    required this.statusFilter,
    required this.speciesFilter,
    required this.applyFilter,
  });

  factory FilterState.initial() {
    return const FilterState(
      statusFilter: null,
      speciesFilter: null,
      applyFilter: false,
    );
  }

  @override
  List<Object?> get props => [statusFilter, speciesFilter, applyFilter];

  FilterState copyWith({
    StatusFilter? statusFilter,
    SpeciesFilter? speciesFilter,
    bool? applyFilter,
  }) {
    return FilterState(
      statusFilter: statusFilter ?? this.statusFilter,
      speciesFilter: speciesFilter ?? this.speciesFilter,
      applyFilter: applyFilter ?? this.applyFilter,
    );
  }
}
