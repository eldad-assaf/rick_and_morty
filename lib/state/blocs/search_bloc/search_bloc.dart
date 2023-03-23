import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CharacterRepository _characterRepository;
  final ScrollController searchResultsScrollController = ScrollController();
  final TextEditingController searchTextController = TextEditingController();
  int page = 1;
  bool isLoadingMoreResults = false;
  String tempValue = '';

  SearchBloc(this._characterRepository)
      : super(const InitialSearchState(null)) {
    searchResultsScrollController.addListener(() {});
    searchTextController.addListener(() {
      //fix the issue that closing the keyboard

      log('temoValue: $tempValue , controllerValue : ${searchTextController.text}');
      if (searchTextController.text.isNotEmpty) {
        if (tempValue.trim() != searchTextController.text.trim()) {
          add(SearchCharacterEvent(name: searchTextController.text));
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
        emit(const SearchErrorState('opps'));
      }
    });
  }
}
