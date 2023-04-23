import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/blocs/all_characters_bloc/all_characters_bloc.dart';
import 'package:rick_and_morty/state/blocs/favourites_blocs/favourites_bloc.dart';
import 'package:rick_and_morty/state/blocs/filter_bloc/bloc/filter_bloc.dart';
import 'package:rick_and_morty/state/blocs/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
import 'package:rick_and_morty/views/screens/main_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}

void main() async {
  Bloc.observer = const AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
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
            BlocProvider<FilterBloc>(
              create: (context) => FilterBloc(),
            ),
            BlocProvider<AllCharactersBloc>(
              create: (context) => AllCharactersBloc(
                  RepositoryProvider.of(context),
                  BlocProvider.of<FilterBloc>(context))
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
