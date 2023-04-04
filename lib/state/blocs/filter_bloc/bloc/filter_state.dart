part of 'filter_bloc.dart';

//enum FilterType { nameFilter, statusFilter, speciesFilter }

enum NameFilter { ascending, descending }

enum StatusFilter { alive, dead, unknown }

enum SpeciesFilter { human, alien, unknown }

class FilterState extends Equatable {
  final NameFilter? nameFilter;
  final StatusFilter? statusFilter;
  final SpeciesFilter? speciesFilter;

  const FilterState({
    required this.nameFilter,
    required this.statusFilter,
    required this.speciesFilter,
  });

  factory FilterState.initial() {
    return const FilterState(
        nameFilter: null, statusFilter: null, speciesFilter: null);
  }

  @override
  List<Object?> get props => [nameFilter, statusFilter, speciesFilter];

  static FilterState copyWith({
    NameFilter? nameFilter,
    StatusFilter? statusFilter,
    SpeciesFilter? speciesFilter,
  }) {
    return FilterState(
      nameFilter: nameFilter ?? nameFilter,
      statusFilter: statusFilter ?? statusFilter,
      speciesFilter: speciesFilter ?? speciesFilter,
    );
  }
}
