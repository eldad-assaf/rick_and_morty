import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/utils/constants.dart';
import 'package:rick_and_morty/common/utils/text_style.dart';
import 'package:rick_and_morty/views/widgets/character_card.dart';
import 'package:rick_and_morty/views/widgets/loading_card.dart';
import '../../state/models/characters_response.dart';

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
          ? charactersResponse.characters.length +
              1 // +1 is for the 'loading...' grid
          : charactersResponse.characters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == charactersResponse.count) {
          return Card(
            child: Center(
              child: Text(
                'The end',
                style: appStyle(24, Appconst.kBlueLight, FontWeight.normal),
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
