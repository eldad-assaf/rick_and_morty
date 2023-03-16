import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;
  CharacterBloc(this._characterRepository) : super(InitialState()) {
    print(state);
    on<LoadCharactersEvent>(_loadCharacters);
  }

  void _loadCharacters(
      LoadCharactersEvent event, Emitter<CharacterState> emit) async {
    print('_loadCharacters');
    emit(LoadingCharactersState());

    try {
      final characters = await _characterRepository.getCharacters();
      print(characters);
      emit(CharactersLoadedState(characters));
    } catch (e) {
      emit(CharactersErrorState(e.toString()));
    }
  }
}
