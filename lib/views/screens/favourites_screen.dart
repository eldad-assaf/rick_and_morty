import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/blocs/favourites_blocs/favourites_bloc.dart';
import 'package:rick_and_morty/state/models/character_model.dart';
import 'package:rick_and_morty/views/widgets/favourites_list_grid_view.dart';

import '../../common/utils/constants.dart';
import '../../common/utils/text_style.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Appconst.kLight),
          backgroundColor: Appconst.kBkDark,
          centerTitle: true,
          title: Text(
            'Favourites',
            style: appStyle(25, Appconst.kLight, FontWeight.bold),
          ),
        ),
        body: BlocBuilder<FavouritesBloc, List<Character>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return Center(
                child: Text(
                  'there are no favourites yet.',
                  style: appStyle(20, Appconst.kLight, FontWeight.normal),
                ),
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
