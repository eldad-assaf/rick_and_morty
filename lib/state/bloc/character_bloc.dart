import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;
  int page = 30;
  bool isLoadingMore = false;
  final ScrollController scrollController = ScrollController();

  CharacterBloc(this._characterRepository)
      : super(const InitialState(null, null)) {
    scrollController.addListener(() {
      add(LoadMoreCharactersEvent());
    });
    on<LoadCharactersEvent>((event, emit) async {
      emit(const LoadingCharactersState(null, null));
      final CharactersResponse? charactersResponse =
          await _characterRepository.getCharacters(page);
      if (charactersResponse != null) {
        // emit(CharactersLoadedState(characters: charactersResponse.characters));
        emit(CharactersLoadedState(
            maxPagesFromApi: charactersResponse.totalPages,
            characters: charactersResponse.characters));
      } else if (charactersResponse == null) {
        emit(const CharactersErrorState('opps'));
      }
    });

    on<LoadMoreCharactersEvent>((event, emit) async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page == state.maxPagesFromApi) {
          return;
        } else {
          isLoadingMore = true;
          page++;
          // if (state.charactersResponse!.totalPages < page) {
          //   print(page);
          //   print(state.charactersResponse!.totalPages);
          //   print('last page');
          //   return;
          // }
          final CharactersResponse? charactersResponse =
              await _characterRepository.getCharacters(page);
          if (charactersResponse != null) {
            // emit(CharactersLoadedState(characters: [
            //   ...state.characters,
            //   ...charactersResponse.characters
            // ]));
            emit(CharactersLoadedState(
                maxPagesFromApi: charactersResponse.totalPages,
                characters: [
                  ...state.characters!,
                  ...charactersResponse.characters
                ]));
          } else if (charactersResponse == null) {
            emit(const CharactersErrorState('opps'));
          }
        }
      }
    });
  }
}
