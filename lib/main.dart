import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';

import 'views/screens/all_characters_screen.dart';

//https://www.youtube.com/watch?v=hc7zZTEqFyA
void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CharacterRepository(),
      child: MaterialApp(
        title: 'Rick and morty app',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const AllCharactersScreen(),
        },
      ),
    );
  }
}
