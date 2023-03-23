import 'package:flutter/material.dart';
import 'package:rick_and_morty/state/repository/characters_repository.dart';
import 'package:rick_and_morty/views/widgets/character_card.dart';
import 'package:rick_and_morty/views/widgets/loading_card.dart';

class CharactersListGridView extends StatelessWidget {
  final CharactersResponse charactersResponse;
  final bool isLoadingMore;
  final ScrollController scrollController;

  const CharactersListGridView({
    super.key,
    required this.charactersResponse,
    required this.isLoadingMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: isLoadingMore
          ? charactersResponse.characters.length + 1
          : charactersResponse.characters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == charactersResponse.count) {
          return const Card(
            child: Center(
              child: Text(
                'The end',
                style: TextStyle(color: Colors.blue, fontSize: 24),
              ),
            ),
          );
        } else if (index >= charactersResponse.characters.length) {
          return const LoadingCard();
        } else {
          return CharacterCard(
            character: charactersResponse.characters[index],
          );
        }
      },
    );
  }
}
