part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent {}

class ToggleIsFavourite extends FavouritesEvent {
  final Character character;
  ToggleIsFavourite({required this.character});
}

class RemoverFromFavourites extends FavouritesEvent {}

class LoadFavouritesEvent extends FavouritesEvent {}
