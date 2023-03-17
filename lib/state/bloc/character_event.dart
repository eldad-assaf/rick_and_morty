part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class LoadCharactersEvent extends CharacterEvent {}

class LoadMoreCharactersEvent extends CharacterEvent {}
