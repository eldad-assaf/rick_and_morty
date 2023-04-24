import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:badges/badges.dart' as badge;

import '../../state/blocs/favourites_blocs/favourites_bloc.dart';
import '../screens/favourites_screen.dart';

class FavouriteIconWithBadge extends StatelessWidget {
  const FavouriteIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesBloc, List<Character>>(
      builder: (context, state) {
        return badge.Badge(
          badgeContent: Text(
            state.length.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          badgeStyle: const badge.BadgeStyle(badgeColor: Colors.pink),
          position: badge.BadgePosition.topStart(start: 2, top: 4),
          child: Center(
            child: IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavouritesScreen(),
                ));
              },
            ),
          ),
        );
      },
    );
  }
}
