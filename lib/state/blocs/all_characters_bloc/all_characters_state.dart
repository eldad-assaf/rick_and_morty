part of 'all_characters_bloc.dart';

@immutable
abstract class AllCharacterState extends Equatable {
  final List<Character>? characters;
  final int? count;
  final String? nextPageUrl;
  final int? nextPageNumber;

  const AllCharacterState(
      this.characters, this.count, this.nextPageUrl, this.nextPageNumber);
}

class InitialState extends AllCharacterState {
  const InitialState(
      super.characters, super.count, super.next, super.nextPageNumber);

  @override
  List<Object?> get props => [characters, count, nextPageUrl];
}

class LoadingCharactersState extends AllCharacterState {
  const LoadingCharactersState(
      super.characters, super.count, super.next, super.nextPageNumber);

  @override
  List<Object?> get props => [characters, count, nextPageUrl];
}

class CharactersLoadedState extends AllCharacterState {
  const CharactersLoadedState(
      {required characters,
      required count,
      required nextPageUrl,
      required nextPageNumber})
      : super(characters, count, nextPageUrl, nextPageNumber);

  @override
  List<Object?> get props => [characters, count];
}

class CharactersErrorState extends AllCharacterState {
  final String errorMessage;
  const CharactersErrorState(this.errorMessage) : super(null, null, null ,null);

  @override
  List<Object?> get props => [errorMessage];
}
