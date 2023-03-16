part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
}

class LoadCharactersEvent extends CharacterEvent {
  final int page;

  const LoadCharactersEvent(this.page);

  @override
  List<Object?> get props => [page];
}
