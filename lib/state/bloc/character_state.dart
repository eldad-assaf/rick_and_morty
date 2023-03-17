part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {
  final List<Character>? characters;
  final int? totalPages;

  const CharacterState(this.characters, this.totalPages);
}

class InitialState extends CharacterState {
  const InitialState(super.characters, super.totalPages);

  @override
  List<Object?> get props => [characters, totalPages];
}

class LoadingCharactersState extends CharacterState {
  const LoadingCharactersState(
    super.characters,
    super.totalPages,
  );

  @override
  List<Object?> get props => [characters, totalPages];
}

class CharactersLoadedState extends CharacterState {
  const CharactersLoadedState({required characters, required totalPages})
      : super(characters, totalPages);

  @override
  List<Object?> get props => [characters, totalPages];
}

class CharactersErrorState extends CharacterState {
  final String errorMessage;
  const CharactersErrorState(this.errorMessage) : super(null, null);

  @override
  List<Object?> get props => [errorMessage];
}
