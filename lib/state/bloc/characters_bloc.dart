import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';

class CharacterBloc extends Cubit<CharacterState> {
  final CharacterRepository _characterRepository;

  CharacterBloc({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository,
        super(CharacterInitial());

  void getCharacters() async {
    emit(CharacterLoading());
    try {
      final characters = await _characterRepository.getCharacters();
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError('Failed to load characters: ${e.toString()}'));
    }
  }
}

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;

  CharacterLoaded(this.characters);
}

class CharacterError extends CharacterState {
  final String message;

  CharacterError(this.message);
}
