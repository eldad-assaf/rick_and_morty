import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/state/models/characters_response.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';

import '../filter_bloc/bloc/filter_bloc.dart';
part 'all_characters_event.dart';
part 'all_characters_state.dart';

class AllCharactersBloc extends Bloc<AllCharacterEvent, AllCharacterState> {
  final CharacterRepository _characterRepository;
  final FilterBloc _filterBloc;

  int page = 1;
  bool isLoadingMore = false;
  bool hasReachedLastPage = false;
  ScrollPosition? lastScrollPosition;
  final ScrollController allCharactersScrollController = ScrollController();
  // final ScrollController searchResultsScrollController = ScrollController();

  AllCharactersBloc(this._characterRepository, this._filterBloc)
      : super(const InitialState(null)) {
    _filterBloc.stream.listen((state) {
      final filterState = state;

    });
    allCharactersScrollController.addListener(() {
      lastScrollPosition = allCharactersScrollController.position;
      add(LoadMoreCharactersEvent());
    });

    on<SaveCurrentCharacterResponse>((event, emit) {
      final charactersResponseStorage = CharactersResponseStorage();
      charactersResponseStorage.characterResponse = state.charactersResponse!;
    });

    on<ScrollToLastPosition>((event, emit) {
      if (lastScrollPosition != null) {
        allCharactersScrollController.animateTo(lastScrollPosition!.pixels,
            duration: const Duration(microseconds: 1),
            curve: Curves.easeInSine);
      }
    });

    on<LoadCharactersEvent>((event, emit) async {

      emit(const LoadingCharactersState(null));
      final CharactersResponse? charactersResponse =
          await _characterRepository.getCharacters(page).catchError((e) {
        emit(const CharactersErrorState('404!'));
        return null;
      });
      if (charactersResponse != null) {
        emit(CharactersLoadedState(charactersResponse: charactersResponse));
      } else if (charactersResponse == null) {
        emit(const CharactersErrorState('opps'));
      }
    });

    on<LoadMoreCharactersEvent>((event, emit) async {
      if (allCharactersScrollController.position.pixels ==
          allCharactersScrollController.position.maxScrollExtent) {
        if (state.charactersResponse!.nextPageNumber == null) {
          return;
        }
        isLoadingMore = true;
        page++;
        final CharactersResponse? charactersResponse =
            await _characterRepository.getCharacters(page);
        if (charactersResponse != null) {
          List<Character> combinedCharactersLoadedUntilNow = [
            ...state.charactersResponse!.characters,
            ...charactersResponse.characters
          ];

          final newResponesObjectWithUpdatedList = charactersResponse.copyWith(
              characters: combinedCharactersLoadedUntilNow);

          emit(CharactersLoadedState(
              charactersResponse: newResponesObjectWithUpdatedList));
        } else if (charactersResponse == null) {
          emit(const CharactersErrorState('opps'));
        }
      }
    });

    on<ResetSearchPage>((event, emit) {
      page = 1;
      //  searchPage = 1;
    });
  }
}

class CharactersResponseStorage {
  static final CharactersResponseStorage _instance =
      CharactersResponseStorage._internal();

  factory CharactersResponseStorage() {
    return _instance;
  }

  CharactersResponse? _charactersResponse;

  CharactersResponse? get charactersResponse => _charactersResponse;

  set characterResponse(CharactersResponse value) {
    _charactersResponse = value;
  }

  CharactersResponseStorage._internal();
}
