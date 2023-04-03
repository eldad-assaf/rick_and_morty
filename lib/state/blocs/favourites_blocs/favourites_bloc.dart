
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(const InitialFavouriteState([])) {
    on<LoadFavouritesEvent>((event, emit) {
      emit(const LoadingFavouritesState([]));
    });

    on<ToggleIsFavourite>((event, emit) {
      final Character character = event.character;
      List<Character> currentFavourites = [...state.favourites];
      if (state.favourites.contains(character)) {
        currentFavourites.remove(event.character);
      } else {
        currentFavourites.add(event.character);
      }
      emit(FavouritesLoadedState(favourites: currentFavourites));

    });
  }
}
