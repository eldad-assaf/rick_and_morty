import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/views/screens/search_screen.dart';
import 'package:rick_and_morty/views/widgets/characters_list_grid_view.dart';
import '../../state/blocs/all_characters_bloc/all_characters_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget determineWidgetByState(AllCharacterState state, BuildContext context) {
    switch (state.runtimeType) {
      case LoadingCharactersState:
        return const Center(child: CircularProgressIndicator());
      case CharactersLoadedState:
        context.read<AllCharactersBloc>().add(ScrollToLastPosition());
        return CharactersListGridView(
          charactersResponse: state.charactersResponse!,
          isLoadingMore: context.read<AllCharactersBloc>().isLoadingMore,
          scrollController:
              context.read<AllCharactersBloc>().allCharactersScrollController,
        );
      case CharactersErrorState:
        return const Center(
          child: Text('Opps! Something went wrong :-('),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: BlocBuilder<AllCharactersBloc, AllCharacterState>(
          builder: (context, state) {
            return determineWidgetByState(state, context);
          },
        ),
      ),
    );
  }
}
