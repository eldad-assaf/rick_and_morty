import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/character_model.dart';

class CharacterRepository {
  final Dio dio;
  CharacterRepository({required this.dio});
  Future<CharactersResponse?> getCharacters(int page) async {
    final String endPoind =
        'https://rickandmortyapi.com/api/character?page=$page';
    try {
      final Response response = await dio.get(endPoind);

      if (response.statusCode == 200) {
        final CharactersResponse charactersResponse =
            CharactersResponse.fromJson(response.data);

        return charactersResponse;
      }
    } on DioError catch (error) {
      throw Exception('Failed to load characters : ${error.message}');
    }
    
  }
}

class CharactersResponse {
  final List<Character> characters;
  final int totalPages;

  CharactersResponse({
    required this.characters,
    required this.totalPages,
  });

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    final characters = (json['results'] as List<dynamic>)
        .map((json) => Character.fromJson(json))
        .toList();
    final info = json['info'] as Map<String, dynamic>;
    final totalPages = info['pages'] as int;

    return CharactersResponse(
      characters: characters,
      totalPages: totalPages,
    );
  }
}
