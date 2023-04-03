import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/blocs/all_characters_bloc/all_characters_bloc.dart';
import 'package:rick_and_morty/state/blocs/favourites_blocs/favourites_bloc.dart';
import 'package:rick_and_morty/state/blocs/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
import 'package:rick_and_morty/views/screens/main_screen.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CharacterRepository(dio: Dio()),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AllCharactersBloc>(
              create: (context) =>
                  AllCharactersBloc(RepositoryProvider.of(context))
                    ..add(LoadCharactersEvent()),
            ),
            BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(RepositoryProvider.of(context)),
            ),
            BlocProvider<FavouritesBloc>(
              create: (context) => FavouritesBloc(),
            ),
          ],
          child: MaterialApp(
            title: 'Rick and morty app',
            theme: ThemeData.dark(),
            initialRoute: '/',
            routes: {
              '/': (context) => const MainScreen(),
            },
          )),
    );
  }
}
