part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {}

class InitialState extends CharacterState {
  @override
  List<Object?> get props => [];
}

class LoadingCharactersState extends CharacterState {
  @override
  List<Object?> get props => [];
}

// class CharactersLoadedState extends CharacterState {
//   final List<Character> characters;
//   CharactersLoadedState(this.characters);

//   @override
//   List<Object?> get props => [characters];
// }

class CharactersLoadedState extends CharacterState {
  final CharactersResponse charactersResponse;

  CharactersLoadedState({
    required this.charactersResponse,
  });

  @override
  List<Object?> get props => [charactersResponse];
}

class CharactersErrorState extends CharacterState {
  final String errorMessage;
  CharactersErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
