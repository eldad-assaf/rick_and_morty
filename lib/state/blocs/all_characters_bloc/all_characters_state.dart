part of 'all_characters_bloc.dart';

@immutable
abstract class AllCharacterState extends Equatable {
  final CharactersResponse? charactersResponse;
  const AllCharacterState(this.charactersResponse);
}

class InitialState extends AllCharacterState {
  const InitialState(super.charactersResponse);
  @override
  List<Object?> get props => [charactersResponse];
}

class LoadingCharactersState extends AllCharacterState {
  const LoadingCharactersState(super.charactersResponse);

  @override
  List<Object?> get props => [charactersResponse];
}

class CharactersLoadedState extends AllCharacterState {
  const CharactersLoadedState({
    required charactersResponse,
  
  }) : super(charactersResponse);

  @override
  List<Object?> get props => [charactersResponse];
}

class CharactersErrorState extends AllCharacterState {
  final String errorMessage;
  const CharactersErrorState(this.errorMessage) : super(null);

  @override
  List<Object?> get props => [errorMessage];
}
