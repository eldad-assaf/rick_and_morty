import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/character_model.dart';

class CharacterRepository {
  Future<CharactersResponse> getCharacters(int page) async {
    final response = await http
        .get(Uri.parse('https://rickandmortyapi.com/api/character?page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CharactersResponse.fromJson(data);
    } else {
      throw Exception('Failed to load characters');
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
