// class SearchCharacterEvent extends CharacterEvent {
//   final String name;
//   SearchCharacterEvent({required this.name});
// }

part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchCharacterEvent extends SearchEvent {
  final String name;
  SearchCharacterEvent({required this.name});
}

class LoadMoreSearchResults extends SearchEvent{
  
}

class ResetSearchResultsEvent extends SearchEvent {}
