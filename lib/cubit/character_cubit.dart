import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/cubit/character_state.dart';

import '../data/repositories/character_repository.dart';

class CharacterBloc extends Cubit<CharacterState> {
  final CharacterRepository _repository;

  CharacterBloc(this._repository) : super(CharacterInitial());

  Future<void> getAllCharacters() async {
    try {
      emit(CharacterLoading());
      final characters = await _repository.getAllCharacters();
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(const CharacterError('error message'));
    }
  }
}
