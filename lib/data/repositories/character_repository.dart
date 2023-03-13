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

  void searchCharacterByName(String name) async {
    final dio = Dio();
    try {
      final response = await dio.get(
          'https://rickandmortyapi.com/api/character',
          queryParameters: {'name': 'Rick Sanchez'});
      final characters = response.data['results'];
      print('rick? : $characters');
      // Do something with the list of characters that match the name
    } catch (e) {
      print(e.toString());
    }
  }
}
