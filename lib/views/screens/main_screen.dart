import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/bloc/character_bloc.dart';

import '../../state/models/character_model.dart';

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
        return const Center(child: CircularProgressIndicator());
      }
      if (state is CharactersErrorState) {
        return Center(
          child: Text(state.errorMessage),
        );
      }
      if (state is CharactersLoadedState) {
        return GridView.count(
          controller: context.read<CharacterBloc>().scrollController,
          crossAxisCount: 2, // Show 2 characters per row
          childAspectRatio: 0.75, // Set the aspect ratio of each grid item
          children: state.characters!.map((character) {
            return CharacterItemWidget(character: character);
          }).toList(),
        );
      }
      return Container();
    },
  );
}

class CharacterItemWidget extends StatelessWidget {
  final Character character;

  const CharacterItemWidget({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              character.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
