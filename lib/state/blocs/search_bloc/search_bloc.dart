import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/state/models/characters_response.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
import '../../models/character_model.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CharacterRepository _characterRepository;
  final ScrollController searchResultsScrollController = ScrollController();
  final TextEditingController searchTextController = TextEditingController();
  int page = 1;
  bool isLoadingMoreResults = false;
  String tempValue = '';
  Timer? _timer;

  SearchBloc(this._characterRepository)
      : super(const InitialSearchState(null)) {
    searchResultsScrollController.addListener(() {
      add(LoadMoreSearchResults());
    });
    searchTextController.addListener(() {
      //fix the issue that closing the keyboard
      if (searchTextController.text.trim().isEmpty) {
        add(LeaveSearchPage());
      }

      log('temoValue: $tempValue , controllerValue : ${searchTextController.text}');
      if (searchTextController.text.isNotEmpty) {
        if (tempValue.trim() != searchTextController.text.trim()) {
          _timer?.cancel();
          _timer = Timer(const Duration(milliseconds: 500), () {
            add(SearchCharacterEvent(name: searchTextController.text));
          });
          tempValue = searchTextController.text.trim();
        }
      }
    });

    on<SearchCharacterEvent>((event, emit) async {
      emit(const LoadingResultsState(null));
      final CharactersResponse? charactersResponse = await _characterRepository
          .searchCharacters(name: event.name, page: page);

      log('search response : ${charactersResponse?.characters ?? ''}');

      if (charactersResponse != null) {
        emit(ResultsLoadedState(charactersResponse: charactersResponse));
      } else if (charactersResponse == null) {
        emit(const CharacterNotFoundState());
      }
    });

    on<LoadMoreSearchResults>((event, emit) async {
      if (searchResultsScrollController.position.pixels ==
          searchResultsScrollController.position.maxScrollExtent) {
        if (state.charactersResponse!.nextPageNumber == null) {
          return;
        }
        isLoadingMoreResults = true;
        page++;
        final CharactersResponse? charactersResponse =
            await _characterRepository.searchCharacters(
                name: searchTextController.text.trim(), page: page);
        if (charactersResponse != null) {
          List<Character> combinedCharactersLoadedUntilNow = [
            ...state.charactersResponse!.characters,
            ...charactersResponse.characters
          ];

          final newResponesObjectWithUpdatedList = charactersResponse.copyWith(
              characters: combinedCharactersLoadedUntilNow);

          emit(ResultsLoadedState(
              charactersResponse: newResponesObjectWithUpdatedList));
        } else if (charactersResponse == null) {
          //    emit(const CharactersErrorState('opps'));
          emit(const SearchErrorState('opps'));
        }
      }
    });

    on<LeaveSearchPage>((event, emit) async {
      emit(const InitialSearchState(null));
      tempValue = '';
      page = 1;
      isLoadingMoreResults = false;
      searchTextController.clear();
    });
  }
}
