part of 'all_characters_bloc.dart';

@immutable
abstract class AllCharacterEvent {}

class LoadCharactersEvent extends AllCharacterEvent {}

class LoadMoreCharactersEvent extends AllCharacterEvent {}

class ResetSearchPage extends AllCharacterEvent {}

class GoBackToInitState extends AllCharacterEvent {}

class SaveCurrentCharacterResponse extends AllCharacterEvent {}

class ScrollToLastPosition extends AllCharacterEvent {}

class LoadFilterdCharactersEvent extends AllCharacterEvent {
  final Map<String, dynamic> params;
  LoadFilterdCharactersEvent({
    required this.params,
  });
}

class LoadMoreFilterdCharactersEvent extends AllCharacterEvent {
  final Map<String, dynamic> params;
  LoadMoreFilterdCharactersEvent({
    required this.params,
  });
}
