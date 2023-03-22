part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {
  final List<Character>? characters;
  final int? count;
  final String? nextPageUrl;
  final int? nextPageNumber;

  const CharacterState(
      this.characters, this.count, this.nextPageUrl, this.nextPageNumber);
}

class InitialState extends CharacterState {
  const InitialState(
      super.characters, super.count, super.next, super.nextPageNumber);

  @override
  List<Object?> get props => [characters, count, nextPageUrl];
}

class LoadingCharactersState extends CharacterState {
  const LoadingCharactersState(
      super.characters, super.count, super.next, super.nextPageNumber);

  @override
  List<Object?> get props => [characters, count, nextPageUrl];
}

class CharactersLoadedState extends CharacterState {
  const CharactersLoadedState(
      {required characters,
      required count,
      required nextPageUrl,
      required nextPageNumber})
      : super(characters, count, nextPageUrl, nextPageNumber);

  @override
  List<Object?> get props => [characters, count];
}

class CharactersErrorState extends CharacterState {
  final String errorMessage;
  const CharactersErrorState(this.errorMessage) : super(null, null, null ,null);

  @override
  List<Object?> get props => [errorMessage];
}
