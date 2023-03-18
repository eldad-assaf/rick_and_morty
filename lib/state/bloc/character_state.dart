part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {
  final List<Character>? characters;
  final int? count;
  final String? next;

  const CharacterState(this.characters, this.count ,this.next);
}

class InitialState extends CharacterState {
  const InitialState(super.characters, super.count, super.next);

  @override
  List<Object?> get props => [characters, count,next];
}

class LoadingCharactersState extends CharacterState {
  const LoadingCharactersState(
    super.characters,
    super.count,
    super.next
  );

  @override
  List<Object?> get props => [characters, count,next];
}

class CharactersLoadedState extends CharacterState {
  const CharactersLoadedState({required characters, required count , required next})
      : super(characters, count,next );

  @override
  List<Object?> get props => [characters, count];
}

class CharactersErrorState extends CharacterState {
  final String errorMessage;
  const CharactersErrorState(this.errorMessage) : super(null, null ,null);

  @override
  List<Object?> get props => [errorMessage];
}
