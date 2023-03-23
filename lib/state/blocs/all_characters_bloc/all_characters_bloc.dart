import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
part 'all_characters_event.dart';
part 'all_characters_state.dart';

class AllCharactersBloc extends Bloc<AllCharacterEvent, AllCharacterState> {
  final CharacterRepository _characterRepository;
  int page = 1;
  bool isLoadingMore = false;
  bool hasReachedLastPage = false;
  ScrollPosition? lastScrollPosition;
  final ScrollController allCharactersScrollController = ScrollController();
  // final ScrollController searchResultsScrollController = ScrollController();

  AllCharactersBloc(this._characterRepository)
      : super(const InitialState(null)) {
    allCharactersScrollController.addListener(() {
      lastScrollPosition = allCharactersScrollController.position;
      add(LoadMoreCharactersEvent());
    });

    on<SaveCurrentCharacterResponse>((event, emit) {
      final charactersResponseStorage = CharactersResponseStorage();

      // final CharactersResponse charactersResponse = state.charactersResponse!; //no need?

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
      final charactersResponseStorage = CharactersResponseStorage();
      final charactersResponseFromStorage =
          charactersResponseStorage.charactersResponse;

      if (charactersResponseFromStorage != null) {
        emit(CharactersLoadedState(
            charactersResponse: charactersResponseFromStorage));

        return;
      }
      emit(const LoadingCharactersState(null));
      final CharactersResponse? charactersResponse =
          await _characterRepository.getCharacters(page);
      if (charactersResponse != null) {
        emit(CharactersLoadedState(charactersResponse: charactersResponse));
      } else if (charactersResponse == null) {
        emit(const CharactersErrorState('opps'));
      }
    });

    on<LoadMoreCharactersEvent>((event, emit) async {
      if (allCharactersScrollController.position.pixels ==
          allCharactersScrollController.position.maxScrollExtent) {
        // log('page : $page , stateNumber = ${state.charactersResponse!.nextPageNumber}');
        // log('nextUrl = ${state.charactersResponse!.nextPageUrl}');
        // log('count = ${state.charactersResponse!.count}');

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
