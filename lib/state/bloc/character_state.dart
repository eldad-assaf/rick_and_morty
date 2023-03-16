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

class CharactersLoadedState extends CharacterState {
  final List<Character> characters;
  CharactersLoadedState(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharactersErrorState extends CharacterState {
  final String errorMessage;
  CharactersErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
