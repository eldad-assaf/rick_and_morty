import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/bloc/character_bloc.dart';
import 'dart:async';

import 'package:rick_and_morty/views/screens/main_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _debouncer = Debouncer(
      const Duration(milliseconds: 800)); // <-- set the delay time here

  void _onTextChanged(String newText) {
    _debouncer.run(() {
      if (newText.trim().isNotEmpty) {
        BlocProvider.of<CharacterBloc>(context).add(ResetSearchPage());
        BlocProvider.of<CharacterBloc>(context)
            .add(SearchCharacterEvent(name: newText.trimLeft().trimRight()));

      }
    });
  }

  @override
  void dispose() {
    _debouncer.cancel(); // <-- cancel the debouncer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() {
        BlocProvider.of<CharacterBloc>(context).add(ResetSearchPage());

        BlocProvider.of<CharacterBloc>(context).add(LoadCharactersEvent());
        return true;
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onTextChanged,
            ),
            Expanded(
              child: BlocBuilder<CharacterBloc, CharacterState>(
                builder: (context, state) {
                  if (state is InitialState) {
                    return const Center(
                      child: Text('Type the character name'),
                    );
                  } else if (state is LoadingCharactersState) {
                    return const Center(
                      child: Text('loading state!'),
                    );
                  } else if (state is CharactersLoadedState) {
                    final isLoadingMore =
                        context.read<CharacterBloc>().isLoadingMore;
                    return GridView.builder(
                      controller: context
                          .read<CharacterBloc>()
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
                    return const Center(
                      child: Text('error state!'),
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
