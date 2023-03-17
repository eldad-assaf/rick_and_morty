part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {
  final List<Character>? characters;
  final int? maxPagesFromApi;
  const CharacterState(this.characters, this.maxPagesFromApi);
}

class InitialState extends CharacterState {
  const InitialState(super.characters, super.maxPagesFromApi);

  @override
  List<Object?> get props => [characters, maxPagesFromApi];
}

class LoadingCharactersState extends CharacterState {
  const LoadingCharactersState(super.characters, super.maxPagesFromApi);

  @override
  List<Object?> get props => [];
}

class CharactersLoadedState extends CharacterState {
  const CharactersLoadedState({required characters, required maxPagesFromApi})
      : super(characters, maxPagesFromApi);

  @override
  List<Object?> get props => [characters ,maxPagesFromApi];
}

class CharactersErrorState extends CharacterState {
  final String errorMessage;
  const CharactersErrorState(this.errorMessage) : super(null,null);

  @override
  List<Object?> get props => [errorMessage];
}
