import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/repositories/character_repository.dart';

import '../cubit/character_cubit.dart';
import '../cubit/character_state.dart';

// ignore: use_key_in_widget_constructors
class CharacterListScreen extends StatefulWidget {
  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  //final dio = Dio();
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = BlocProvider.of<CharacterBloc>(context);
    _characterBloc.getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          print(state);
          if (state is CharacterLoading) {
            return const CircularProgressIndicator();
          } else if (state is CharacterLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                // return CharacterListItem(character: character);
                return Text(character.name);
              },
            );
          } else {
            return const Center(
              child: Text('Error fetching characters'),
            );
          }
        },
      ),
    );
  }
}
