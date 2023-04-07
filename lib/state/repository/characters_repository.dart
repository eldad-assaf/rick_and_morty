import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/state/models/characters_response.dart';


class CharacterRepository {
  final Dio dio;
  CharacterRepository({required this.dio});

  final String endPoind = 'https://rickandmortyapi.com/api/character/';

  Future<CharactersResponse?> getCharacters(
    int page,
  ) async {
    Map<String, dynamic> params = {'page': page};
    try {
      final Response response =
          await dio.get(endPoind, queryParameters: params);

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

  Future<CharactersResponse?> searchCharacters(
      {required String name, required int page}) async {
    Map<String, dynamic> params = {'name': name, 'page': page};

    try {
      final Response response =
          await dio.get(endPoind, queryParameters: params);
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
        //when no caracters available for the search name the api returns 404 error
        return null;
      } else {
        throw Exception('Failed to load characters : ${error.message}');
      }
    }
  }

  Future<CharactersResponse?> filterCharacters(int page,
      {required Map<String, dynamic> params}) async {

    final newParams = {'page': page, ...params};

    try {
      final Response response =
          await dio.get(endPoind, queryParameters: newParams);

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
}
