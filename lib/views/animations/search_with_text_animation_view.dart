import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/utils/constants.dart';
import 'package:rick_and_morty/views/animations/search_animation_view.dart';

class SearchWithTextAnimationView extends StatelessWidget {
  final String text;
  const SearchWithTextAnimationView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Appconst.kLight),
            ),
          ),
          const SearchAnimationView()
        ],
      ),
    );
  }
}
