import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/state/bloc/character_bloc.dart';
import 'package:rick_and_morty/views/screens/search.dart';

import '../../state/models/character_model.dart';

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
              context.read<CharacterBloc>().add(SaveCurrentCharacterResponse());
              context.read<CharacterBloc>().add(LoadSearchPageEvent());
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchPage(),
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
  return BlocBuilder<CharacterBloc, CharacterState>(
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
        final isLoadingMore = context.read<CharacterBloc>().isLoadingMore;
        context.read<CharacterBloc>().add(ScrollToLastPosition());

        return GridView.builder(
          controller:
              context.read<CharacterBloc>().allCharactersScrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    style: TextStyle(color: Colors.blue, fontSize: 24),
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
                      style: TextStyle(color: Colors.blue, fontSize: 24),
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
      }
      return Container();
    },
  );
}

class CharacterItemWidget extends StatelessWidget {
  final Character character;

  const CharacterItemWidget({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(character: character),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                character.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class DetailScreen extends StatelessWidget {
//   final Character character;

//   const DetailScreen({Key? key, required this.character}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink,
//       body: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 3,
//             width: double.infinity,
//             child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: CachedNetworkImage(
//                 imageUrl: character.image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.pink.shade400,
//                 // borderRadius: BorderRadius.only(
//                 //   topLeft: Radius.circular(30.0),
//                 //   topRight: Radius.circular(30.0),
//                 // ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 16.0),
//                   Text(
//                     character.name,
//                     style: const TextStyle(
//                       fontSize: 28.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Text(
//                     "Status: ${character.status}\nSpecies: ${character.species}\nType: ${character.type.isEmpty ? "Unknown" : character.type}\nGender: ${character.gender}",
//                     style: const TextStyle(
//                       wordSpacing: 2,
//                       fontSize: 22.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//}
class DetailScreen extends StatelessWidget {
  final Character character;

  const DetailScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.pink.shade400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Status: ${character.status}\nSpecies: ${character.species}\nType: ${character.type.isEmpty ? "Unknown" : character.type}\nGender: ${character.gender}",
                    style: const TextStyle(
                      wordSpacing: 2,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}
