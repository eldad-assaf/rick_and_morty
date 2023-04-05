part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  final Map<String, dynamic>? params;
  const FilterState(this.params);
}

class FilterdCharactersState extends FilterState {
  const FilterdCharactersState({required params}) : super(params);

  @override
  List<Object?> get props => [params];
}

class UnFilterdCharactersState extends FilterState {
  const UnFilterdCharactersState(super.params);

  @override
  List<Object?> get props => [params];
}
