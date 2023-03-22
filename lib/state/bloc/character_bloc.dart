import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;
  int page = 1;
  int searchPage = 1;
  bool isLoadingMore = false;
  bool hasReachedLastPage = false;
  ScrollPosition? lastScrollPosition;
  final ScrollController allCharactersScrollController = ScrollController();
  final ScrollController searchResultsScrollController = ScrollController();

  CharacterBloc(this._characterRepository)
      : super(const InitialState(null, null, null, null)) {
    allCharactersScrollController.addListener(() {
      lastScrollPosition = allCharactersScrollController.position;
      add(LoadMoreCharactersEvent());
    });

    on<SaveCurrentCharacterResponse>((event, emit) {
      final charactersResponseStorage = CharactersResponseStorage();

      final CharactersResponse charactersResponse = CharactersResponse(
          characters: state.characters!,
          count: state.count!,
          nextPageUrl: state.nextPageUrl,
          nextPageNumber: state.nextPageNumber);

      charactersResponseStorage.characterResponse = charactersResponse;
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
            characters: charactersResponseFromStorage.characters,
            count: charactersResponseFromStorage.count,
            nextPageUrl: charactersResponseFromStorage.nextPageUrl,
            nextPageNumber: charactersResponseFromStorage.nextPageNumber));

        return;
      }
      emit(const LoadingCharactersState(null, null, null, null));
      final CharactersResponse? charactersResponse =
          await _characterRepository.getCharacters(page);
      if (charactersResponse != null) {
        emit(CharactersLoadedState(
            characters: charactersResponse.characters,
            count: charactersResponse.count,
            nextPageUrl: charactersResponse.nextPageUrl,
            nextPageNumber: charactersResponse.nextPageNumber));
      } else if (charactersResponse == null) {
        emit(const CharactersErrorState('opps'));
      }
    });

    on<LoadSearchPageEvent>((event, emit) {
      emit(const InitialState(null, null, null, null));
    });

    on<SearchCharacterEvent>(
      (event, emit) async {
        log('event name : ${event.name}');
        searchResultsScrollController.addListener(
          () {
            log('Listener call!');
            add(LoadMoreSearchResultsEvent(name: event.name));
          },
        );
        emit(const LoadingCharactersState(null, null, null, null));
        final CharactersResponse? charactersResponse =
            await _characterRepository.searchCharacters(
                name: event.name, page: searchPage);
        if (charactersResponse != null) {
          log('emmiting CharactersLoadedState from SearchCharacterEvent');
          emit(CharactersLoadedState(
              characters: charactersResponse.characters,
              count: charactersResponse.count,
              nextPageUrl: charactersResponse.nextPageUrl,
              nextPageNumber: charactersResponse.nextPageNumber));
        } else if (charactersResponse == null) {
          emit(const CharactersErrorState('Character Not Found'));
        }
      },
    );

    on<LoadMoreCharactersEvent>((event, emit) async {
      if (allCharactersScrollController.position.pixels ==
              allCharactersScrollController.position.maxScrollExtent &&
          state.nextPageUrl != null) {
        isLoadingMore = true;
        page++;
        final CharactersResponse? charactersResponse =
            await _characterRepository.getCharacters(page);
        if (charactersResponse != null) {
          emit(CharactersLoadedState(
              characters: [
                ...state.characters!,
                ...charactersResponse.characters
              ],
              count: state.count,
              nextPageUrl: charactersResponse.nextPageUrl,
              nextPageNumber: charactersResponse.nextPageNumber));
        } else if (charactersResponse == null) {
          emit(const CharactersErrorState('opps'));
        }
      }
    });

    on<LoadMoreSearchResultsEvent>((event, emit) async {
      if (searchResultsScrollController.position.pixels ==
              searchResultsScrollController.position.maxScrollExtent &&
          state.nextPageUrl != null &&
          state.nextPageNumber != null) {
        isLoadingMore = true;
        //searchPage++;
        //makes isuues!
        //try to replace with next page grom the api response

        log('next : ${state.nextPageNumber}');
        log('next : ${state.nextPageUrl}');

        final CharactersResponse? charactersResponse =
            await _characterRepository.searchCharacters(
                name: event.name, page: state.nextPageNumber!);
        log('charactersResponse from LoadMoreSearchResultsEvent ${charactersResponse} ');
        if (charactersResponse != null) {
          emit(CharactersLoadedState(
              characters: [
                ...state.characters!,
                ...charactersResponse.characters
              ],
              count: state.count,
              nextPageUrl: charactersResponse.nextPageUrl,
              nextPageNumber: charactersResponse.nextPageNumber));
        } else if (charactersResponse == null) {
          emit(const CharactersErrorState('opps'));
        }
      }
    });

    on<GoBackToInitStateEvent>(
        (event, emit) => emit(const InitialState(null, null, null, null)));

    on<ResetSearchPage>((event, emit) {
      page = 1;
      searchPage = 1;
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
