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
  Map<String, dynamic> params = {};

  int page = 1;
  bool isLoadingMore = false;
  bool hasReachedLastPage = false;
  ScrollPosition? lastScrollPosition;
  final ScrollController allCharactersScrollController = ScrollController();
  // final ScrollController searchResultsScrollController = ScrollController();

  AllCharactersBloc(this._characterRepository, this._filterBloc)
      : super(const InitialState(null)) {
    _filterBloc.stream.listen((state) {
      if (state.applyFilter) {
        params = {'page': page};

        if (state.statusFilter != null) {
          switch (state.statusFilter) {
            case StatusFilter.alive:
              params['status'] = 'alive';
              break;
            case StatusFilter.dead:
              params['status'] = 'dead';

              break;
            case StatusFilter.unknown:
              params['status'] = 'unknown';

              break;
            default:
          }
        }

        if (state.speciesFilter != null) {
          switch (state.speciesFilter) {
            case SpeciesFilter.human:
              params['species'] = 'human';
              break;
            case SpeciesFilter.alien:
              params['species'] = 'alien';

              break;
            case SpeciesFilter.unknown:
              params['species'] = 'unknown';

              break;
            default:
          }

          // params['species'] = state.speciesFilter;
        }

        // Use the params map for filtering

        log('params : $params');

        add(LoadFilterdCharactersEvent(params: params));
      } else if (state.applyFilter == false) {
        log('should clear and start fron top again');
        allCharactersScrollController.animateTo(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        params = {};
        page = 1;
        isLoadingMore = false;
        hasReachedLastPage = false;
        add(LoadCharactersEvent());
      }
    });
    allCharactersScrollController.addListener(() {
      lastScrollPosition = allCharactersScrollController.position;
      if (params.isEmpty) {
        add(LoadMoreCharactersEvent());
      } else {
        add(LoadMoreFilterdCharactersEvent());
      }
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

    on<LoadFilterdCharactersEvent>((event, emit) async {
      emit(const LoadingCharactersState(null));
      final CharactersResponse? charactersResponse = await _characterRepository
          .filterCharacters(page, params: event.params)
          .catchError((e) {
        emit(const CharactersErrorState('404!'));
        return null;
      });
      if (charactersResponse != null) {
        emit(CharactersLoadedState(charactersResponse: charactersResponse));
      } else if (charactersResponse == null) {
        emit(const CharactersErrorState('opps'));
      }
    });
    on<LoadMoreFilterdCharactersEvent>((event, emit) async {
      if (allCharactersScrollController.position.pixels ==
          allCharactersScrollController.position.maxScrollExtent) {
        if (state.charactersResponse!.nextPageNumber == null) {
          return;
        }
        log('LoadMoreFilterdCharactersEvent');
        isLoadingMore = true;
        page++;
        final CharactersResponse? charactersResponse =
            await _characterRepository.filterCharacters(page, params: params);
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
