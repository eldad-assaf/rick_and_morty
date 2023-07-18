import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/utils/constants.dart';
import 'package:rick_and_morty/common/utils/text_style.dart';
import 'package:rick_and_morty/state/blocs/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/views/animations/not_found_animation_view.dart';
import 'dart:async';
import 'package:rick_and_morty/views/widgets/characters_list_grid_view.dart';
import '../animations/search_with_text_animation_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();

  Widget determineWidgetByState(SearchState state) {
    switch (state.runtimeType) {
      case InitialSearchState:
        return const SearchWithTextAnimationView(
          text: 'Type Character Name!',
        );
      case LoadingResultsState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ResultsLoadedState:
        return CharactersListGridView(
          charactersResponse: state.charactersResponse!,
          isLoadingMore: context.read<SearchBloc>().isLoadingMoreResults,
          scrollController:
              context.read<SearchBloc>().searchResultsScrollController,
        );
      case CharacterNotFoundState:
        return const NotFoundAnimationView();
      case SearchErrorState:
        return const Center(
          child: Text('Opps! Something went wrong :-( '),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () => Future(
            () {
              BlocProvider.of<SearchBloc>(context).add(LeaveSearchPage());

              return true;
            },
          ),
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: Appconst.kLight),
                backgroundColor: Appconst.kBkDark,
                centerTitle: true,
                title: Text(
                  'Characters Search',
                  style: appStyle(25, Appconst.kLight, FontWeight.bold),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      focusNode: _focusNode,
                      autofocus: true,
                      controller:
                          context.read<SearchBloc>().searchTextController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Appconst.kPink,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: determineWidgetByState(state)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
