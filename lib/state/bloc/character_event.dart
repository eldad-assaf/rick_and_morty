part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class LoadCharactersEvent extends CharacterEvent {}

class LoadMoreCharactersEvent extends CharacterEvent {}

class LoadSearchPageEvent extends CharacterEvent {}

class LoadMoreSearchResultsEvent extends CharacterEvent {
  final String name;
  LoadMoreSearchResultsEvent({required this.name});
}

class SearchCharacterEvent extends CharacterEvent {
  final String name;
  SearchCharacterEvent({required this.name});
}

class ResetSearchPage extends CharacterEvent {}
