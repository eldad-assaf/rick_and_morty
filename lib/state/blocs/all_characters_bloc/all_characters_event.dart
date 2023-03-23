part of 'all_characters_bloc.dart';

@immutable
abstract class AllCharacterEvent {}

class LoadCharactersEvent extends AllCharacterEvent {}

class LoadMoreCharactersEvent extends AllCharacterEvent {}

class ResetSearchPage extends AllCharacterEvent {}

class SaveCurrentCharacterResponse extends AllCharacterEvent {}

class ScrollToLastPosition extends AllCharacterEvent {}
