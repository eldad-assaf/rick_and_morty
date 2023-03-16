import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/bloc/character_bloc.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: blocBody(context),
    );
  }
}

Widget blocBody(BuildContext context) {
  return BlocBuilder<CharacterBloc, CharacterState>(
    builder: (context, state) {
      if (state is LoadingCharactersState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is CharactersErrorState) {
        return Center(
          child: Text(state.errorMessage),
        );
      }
      if (state is CharactersLoadedState) {
        return Center(child: Text('loaded'));
      }
      return Container();
    },
  );
}
