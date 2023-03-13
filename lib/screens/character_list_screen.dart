import 'package:cached_network_image/cached_network_image.dart';
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
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = BlocProvider.of<CharacterBloc>(context);
    _characterBloc.getAllCharacters();
    _characterBloc.getOne();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const CircularProgressIndicator();
          } else if (state is CharacterLoaded) {
            // ignore: unnecessary_cast
            return GridView.builder(
              // ignore: prefer_const_constructors
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount:
                  state.characters.length, // Total number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                // Return a widget for each item in the grid
                final character = state.characters[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreenImage(imageUrl: character.image),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
            ;
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

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
