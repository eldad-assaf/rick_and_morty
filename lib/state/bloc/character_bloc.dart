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
    on<LoadCharactersEvent>(_loadCharacters);
  }

  void _loadCharacters(
      LoadCharactersEvent event, Emitter<CharacterState> emit) async {
    emit(LoadingCharactersState());

    try {
      final CharactersResponse charactersResponse =
          await _characterRepository.getCharacters(event.page);

      emit(CharactersLoadedState(charactersResponse:charactersResponse ));
    } catch (e) {
      emit(CharactersErrorState(e.toString()));
    }
  }
}
