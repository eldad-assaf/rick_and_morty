import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/character_model.dart';

class CharacterRepository {
  Future<List<Character>> getCharacters() async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;
      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}


