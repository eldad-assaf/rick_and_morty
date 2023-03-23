import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:rick_and_morty/views/screens/main_screen.dart';
import '../../state/blocs/all_characters_bloc/all_characters_bloc.dart';
import '../animations/search_with_text_animation_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _debouncer =
      Debouncer(const Duration(seconds: 2)); // <-- set the delay time here

  void _onTextChanged(String newText) {
    log('_onTextChanged');
    log(newText);
    _debouncer.run(() {
      if (newText.trim().isNotEmpty) {}
      if (newText.trim().isEmpty) {
        log('WTF');
        // BlocProvider.of<CharacterBloc>(context).add(GoBackToInitStateEvent());
      }
    });
  }

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() {
        // BlocProvider.of<CharacterBloc>(context).add(ResetSearchPage());
        // BlocProvider.of<CharacterBloc>(context).add(LoadCharactersEvent());
        return true;
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _onTextChanged,
              ),
            ),
            Expanded(
              child: BlocBuilder<AllCharactersBloc, AllCharacterState>(
                builder: (context, state) {
                  if (state is InitialState) {
                    return const SearchWithTextAnimationView(
                      text: 'Type Character Name!',
                    );
                  } else if (state is LoadingCharactersState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CharactersLoadedState) {
                    final isLoadingMore =
                        context.read<AllCharactersBloc>().isLoadingMore;
                    return GridView.builder(
                      controller: context
                          .read<AllCharactersBloc>()
                          .searchResultsScrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: isLoadingMore
                          ? state.characters!.length + 1
                          : state.characters!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == state.count) {
                          return const Card(
                            child: Center(
                              child: Text(
                                'The end',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 24),
                              ),
                            ),
                          );
                        } else if (index >= state.characters!.length) {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(color: Colors.pink),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'loading...',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 24),
                                )
                              ],
                            ),
                          );
                        } else {
                          return CharacterItemWidget(
                            character: state.characters![index],
                          );
                        }
                      },
                    );
                  } else if (state is CharactersErrorState) {
                    return Center(
                      child: Text('Opps! ${state.errorMessage}'),
                    );
                  } else {
                    return const Center(
                      child: Text('else block!'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }
}
