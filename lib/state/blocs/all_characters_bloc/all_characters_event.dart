part of 'all_characters_bloc.dart';

@immutable
abstract class AllCharacterEvent {}

class FilterCharactersEvent extends AllCharacterEvent {
  final Map<String, dynamic> params;
  FilterCharactersEvent({required this.params});
}

class LoadMoreFilterdCharactersEvent extends AllCharacterEvent {
  final Map<String, dynamic> params;
  LoadMoreFilterdCharactersEvent({required this.params});
}

class LoadCharactersEvent extends AllCharacterEvent {}

class LoadMoreCharactersEvent extends AllCharacterEvent {}

class ResetSearchPage extends AllCharacterEvent {}

class SaveCurrentCharacterResponse extends AllCharacterEvent {}

class ScrollToLastPosition extends AllCharacterEvent {}
