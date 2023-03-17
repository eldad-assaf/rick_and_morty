part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {
  final List<Character> characters;
  const CharacterState(this.characters);
}

class InitialState extends CharacterState {
  const InitialState(super.characters);

  @override
  List<Object?> get props => [];
}

class LoadingCharactersState extends CharacterState {
  const LoadingCharactersState(super.characters);

  @override
  List<Object?> get props => [];
}

class CharactersLoadedState extends CharacterState {
  const CharactersLoadedState({required characters}) : super(characters);

  @override
  List<Object?> get props => [characters];
}

class CharactersErrorState extends CharacterState {
  final String errorMessage;
  CharactersErrorState(this.errorMessage) : super([]);

  @override
  List<Object?> get props => [errorMessage];
}
