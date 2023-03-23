import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/views/screens/search_screen.dart';
import 'package:rick_and_morty/views/widgets/characters_list_grid_view.dart';
import '../../state/blocs/all_characters_bloc/all_characters_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context
                  .read<AllCharactersBloc>()
                  .add(SaveCurrentCharacterResponse());
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ));
            },
          )
        ],
      ),
      body: blocBody(context),
    );
  }
}

Widget blocBody(BuildContext context) {
  return BlocBuilder<AllCharactersBloc, AllCharacterState>(
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
        final isLoadingMore = context.read<AllCharactersBloc>().isLoadingMore;
        context.read<AllCharactersBloc>().add(ScrollToLastPosition());
        return CharactersListGridView(
          charactersResponse: state.charactersResponse!,
          isLoadingMore: isLoadingMore,
          scrollController:
              context.read<AllCharactersBloc>().allCharactersScrollController,
        );
      }
      return Container();
    },
  );
}


