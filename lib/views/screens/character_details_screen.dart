import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/blocs/favourites_blocs/favourites_bloc.dart';

import '../../state/models/character_model.dart';
import '../animations/animated_prompt.dart';

enum AnimationType { add, remove }

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  bool showAnimatedPrompt = false;
  late AnimationType animationType;

  Future<void> _showAnimtion({required bool isFav}) async {
    setState(() {
      isFav
          ? animationType = AnimationType.remove
          : animationType = AnimationType.add;
      showAnimatedPrompt = true;

      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          showAnimatedPrompt = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pink,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: widget.character.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade400,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16.0),
                        Text(
                          widget.character.name,
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          "Status: ${widget.character.status}\nSpecies: ${widget.character.species}\nType: ${widget.character.type.isEmpty ? "Unknown" : widget.character.type}\nGender: ${widget.character.gender}",
                          style: const TextStyle(
                            wordSpacing: 2,
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Back'),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      BlocBuilder<FavouritesBloc, List<Character>>(
                        builder: (context, state) {
                          bool? isFav = state.contains(widget.character);
                          return IconButton(
                            onPressed: () {
                              _showAnimtion(isFav: isFav);
                              context.read<FavouritesBloc>().add(
                                  ToggleIsFavourite(
                                      character: widget.character));
                            },
                            icon: isFav == false
                                ? const Icon(
                                    Icons.favorite_outline,
                                    size: 35,
                                  )
                                : const Icon(Icons.favorite_rounded),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (showAnimatedPrompt)
              Center(
                child: AnimatedPrompt(
                  title: animationType == AnimationType.add
                      ? 'Added To Favourites!'
                      : 'Removed From Favourites',
                  subTitle: widget.character.name,
                  child: animationType == AnimationType.add
                      ? const Icon(Icons.done)
                      : const Icon(Icons.remove_circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
