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
      : super(const InitialState(null, null, null)) {
    allCharactersScrollController.addListener(() {
      lastScrollPosition = allCharactersScrollController.position;
      add(LoadMoreCharactersEvent());
    });

    on<SaveCurrentCharacterResponse>((event, emit) {
      final charactersResponseStorage = CharactersResponseStorage();

      final CharactersResponse charactersResponse = CharactersResponse(
          characters: state.characters!,
          count: state.count!,
          nextPage: state.next);

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
          next: charactersResponseFromStorage.nextPage,
        ));

//   _scrollController.animateTo(
//   _savedScrollPosition.pixels,
//   duration: Duration(milliseconds: 500),
//   curve: Curves.easeInOut,
// );

        return;
      }
      emit(const LoadingCharactersState(null, null, null));
      final CharactersResponse? charactersResponse =
          await _characterRepository.getCharacters(page);
      if (charactersResponse != null) {
        emit(CharactersLoadedState(
            characters: charactersResponse.characters,
            count: charactersResponse.count,
            next: charactersResponse.nextPage));
      } else if (charactersResponse == null) {
        emit(const CharactersErrorState('opps'));
      }
    });

    on<LoadSearchPageEvent>((event, emit) {
      emit(const InitialState(null, null, null));
    });

    on<SearchCharacterEvent>(
      (event, emit) async {
        searchResultsScrollController.addListener(
          () {
            add(LoadMoreSearchResultsEvent(name: event.name));
          },
        );
        emit(const LoadingCharactersState(null, null, null));
        final CharactersResponse? charactersResponse =
            await _characterRepository.searchCharacters(
                name: event.name, page: searchPage);
        if (charactersResponse != null) {
          emit(CharactersLoadedState(
            characters: charactersResponse.characters,
            count: charactersResponse.count,
            next: charactersResponse.nextPage,
          ));
        } else if (charactersResponse == null) {
          emit(const CharactersErrorState('opps'));
        }
      },
    );

    on<LoadMoreCharactersEvent>((event, emit) async {
      if (allCharactersScrollController.position.pixels ==
              allCharactersScrollController.position.maxScrollExtent &&
          state.next != null) {
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
            next: charactersResponse.nextPage,
          ));
        } else if (charactersResponse == null) {
          emit(const CharactersErrorState('opps'));
        }
      }
    });

    on<LoadMoreSearchResultsEvent>((event, emit) async {
      if (searchResultsScrollController.position.pixels ==
              searchResultsScrollController.position.maxScrollExtent &&
          state.next != null) {
        isLoadingMore = true;
        searchPage++;
        final CharactersResponse? charactersResponse =
            await _characterRepository.searchCharacters(
                name: event.name, page: searchPage);
        if (charactersResponse != null) {
          emit(CharactersLoadedState(
            characters: [
              ...state.characters!,
              ...charactersResponse.characters
            ],
            count: state.count,
            next: charactersResponse.nextPage,
          ));
        } else if (charactersResponse == null) {
          emit(const CharactersErrorState('opps'));
        }
      }
    });

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
