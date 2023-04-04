import 'package:flutter/material.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/views/widgets/character_card.dart';

class FavouritesListGridView extends StatelessWidget {
  final List<Character> favourites;

  const FavouritesListGridView({
    super.key,
    required this.favourites,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        //   controller: scrollController,
        itemCount: favourites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (BuildContext context, int index) {
          return CharacterCard(
            character: favourites[index],
          );
        });
  }
}
