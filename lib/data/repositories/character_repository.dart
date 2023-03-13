import 'package:dio/dio.dart';

import '../models/character.dart';

class CharacterRepository {
  final Dio _dio;

  CharacterRepository(this._dio);

  Future<List<Character>> getAllCharacters() async {
    try {
      final response =
          await _dio.get('https://rickandmortyapi.com/api/character');
      //print(response);
      final data = response.data['results'] as List;
      final characters = data.map((e) => Character.fromJson(e)).toList();
      return characters;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
