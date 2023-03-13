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
      final infoData = response.data['info'] as Map<String, dynamic>;
      final characters = data.map((e) => Character.fromJson(e)).toList();
      final info = Info.fromJson(infoData);
      return characters;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<Character>?> searchCharacterByName(String name) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character',
        queryParameters: {'name': name},
      );

      if (response.statusCode == 404 || response.data['error'] != null) {
        return null;
      }

      final data = response.data['results'] as List;
      final characters = data.map((e) => Character.fromJson(e)).toList();
      return characters;
    } on DioError catch (e) {
      print(e.response!.statusMessage);
      if (e.response!.statusMessage == 'Not Found') {
        //there is no character under this name!
        return [];
      }
      throw Exception(e.message);
    }
  }
}
