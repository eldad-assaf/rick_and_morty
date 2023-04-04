import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/blocs/favourites_blocs/favourites_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/views/widgets/favourites_list_grid_view.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Favourites'),
        ),
        body: BlocBuilder<FavouritesBloc, List<Character>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return Container(
                color: Colors.green,
              );
            } else {
              return FavouritesListGridView(
                favourites: state,
              );
            }
          },
        ),
      ),
    );
  }
}
