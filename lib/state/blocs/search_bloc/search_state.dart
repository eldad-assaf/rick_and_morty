part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  final CharactersResponse? charactersResponse;
  const SearchState(this.charactersResponse);
}

class InitialSearchState extends SearchState {
  const InitialSearchState(super.charactersResponse);
  @override
  List<Object?> get props => [charactersResponse];
}

class LoadingResultsState extends SearchState {
  const LoadingResultsState(super.charactersResponse);

  @override
  List<Object?> get props => [charactersResponse];
}

class ResultsLoadedState extends SearchState {
  const ResultsLoadedState({
    required charactersResponse,
  }) : super(charactersResponse);

  @override
  List<Object?> get props => [charactersResponse];
}

class SearchErrorState extends SearchState {
  final String errorMessage;
  const SearchErrorState(this.errorMessage) : super(null);

  @override
  List<Object?> get props => [errorMessage];
}

class CharacterNotFoundState extends SearchState {
  const CharacterNotFoundState() : super(null);

  @override
  List<Object?> get props => [];
}
