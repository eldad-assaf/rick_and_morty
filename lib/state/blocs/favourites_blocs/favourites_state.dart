// part of 'favourites_bloc.dart';

// @immutable
// abstract class FavouritesState extends Equatable {
//   final List<Character> favourites;
//   const FavouritesState(this.favourites);
// }

// class InitialFavouriteState extends FavouritesState {
//   const InitialFavouriteState(super.favourites);
//   @override
//   List<Object?> get props => [favourites];
// }

// class LoadingFavouritesState extends FavouritesState {
//   const LoadingFavouritesState(super.favourites);

//   @override
//   List<Object?> get props => [favourites];
// }

// class FavouritesLoadedState extends FavouritesState {
//   const FavouritesLoadedState({required favourites}) : super(favourites);
//   @override
//   List<Object?> get props => [favourites];
// }

// class FavouritesErrorState extends FavouritesState {
//   final String errorMessage;
//   const FavouritesErrorState(this.errorMessage) : super(const []);

//   @override
//   List<Object?> get props => [errorMessage];
// }
