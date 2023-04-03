import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
part 'favourites_event.dart';

class FavouritesBloc extends HydratedBloc<FavouritesEvent, List<Character>> {
  FavouritesBloc() : super([]) {
    on<LoadFavouritesEvent>((event, emit) {
      emit(const []);
    });

    on<ToggleIsFavourite>((event, emit) {
      final Character character = event.character;
      List<Character> currentFavourites = [...state];
      if (state.contains(character)) {
        currentFavourites.remove(event.character);
      } else {
        currentFavourites.add(event.character);
      }
      emit(currentFavourites);
    });
  }

  @override
  List<Character>? fromJson(Map<String, dynamic> json) {
    List<Character> characters = [];
    json['characters'].forEach(
      (el) => characters.add(
        Character.fromJson(el),
      ),
    );
    return characters;
  }

  @override
  Map<String, dynamic>? toJson(List<Character> state) {
    var json = {'characters': []};
    for (var character in state) {
      json['characters']!.add(character.toJson());
    }
    return json;
  }
}
