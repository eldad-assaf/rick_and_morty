part of 'filter_bloc.dart';

@immutable
abstract class FilterState extends Equatable {
  final Map<String, dynamic>? filterParmas;
  const FilterState(this.filterParmas);
}

class UnFilterdListState extends FilterState {
  const UnFilterdListState(super.filterParmas);

  @override
  List<Object?> get props => [filterParmas];
}

class FilterdListState extends FilterState {
  const FilterdListState({required filterParams}) : super(filterParams);

  @override
  List<Object?> get props => [filterParmas];
}
