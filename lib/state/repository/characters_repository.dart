
import 'package:dio/dio.dart';

import '../models/character_model.dart';

class CharacterRepository {
  final Dio dio;
  CharacterRepository({required this.dio});

  Future<CharactersResponse?> getCharacters(int page) async {
    final String endPoind =
        'https://rickandmortyapi.com/api/character?page=$page';
    try {
      // await Future.delayed(
      //     const Duration(seconds: 2)); // Simulate delay of 2 seconds

      final Response response = await dio.get(endPoind);

      if (response.statusCode == 200) {
        final CharactersResponse charactersResponse =
            CharactersResponse.fromJson(response.data);

        return charactersResponse;
      } else {
        return null;
      }
    } on DioError catch (error) {
      throw Exception('Failed to load characters : ${error.message}');
    }
  }

  Future<CharactersResponse?> searchCharacters({required String name , required int page}) async {
    final String endPoind =
        'https://rickandmortyapi.com/api/character/?name=$name&page=$page';
        //https://rickandmortyapi.com/api/character/?name=r&page=30

    try {
      final Response response = await dio.get(endPoind);
      if (response.statusCode == 200) {
        final CharactersResponse charactersResponse =
            CharactersResponse.fromJson(response.data);

        return charactersResponse;
      } else {
        throw Exception(
            'Failed to load characters : ${response.statusMessage}');
      }
    } on DioError catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load characters : ${error.message}');
      }
    }
  }
}

class CharactersResponse {
  final List<Character> characters;
  final int count;
  final String? nextPage;

  CharactersResponse(
      {required this.characters, required this.count, required this.nextPage});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    final characters = (json['results'] as List<dynamic>)
        .map((json) => Character.fromJson(json))
        .toList();
    final info = json['info'] as Map<String, dynamic>;
    final count = info['count'] as int;
    final next = info['next'] as String?;

    return CharactersResponse(
        characters: characters, count: count, nextPage: next);
  }
}
