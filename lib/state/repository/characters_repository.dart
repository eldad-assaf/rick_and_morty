import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/character_model.dart';

class CharacterRepository {
  final Dio dio;
  CharacterRepository({required this.dio});

  final String endPoind = 'https://rickandmortyapi.com/api/character/';

  Future<CharactersResponse?> getCharacters(int page) async {
    Map<String, dynamic> _params = {'page': page};

    // final String endPoind =
    //     'https://rickandmortyapi.com/api/character?page=$page';
    try {
      // await Future.delayed(
      //     const Duration(seconds: 2)); // Simulate delay of 2 seconds

      final Response response =
          await dio.get(endPoind, queryParameters: _params);

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
    Map<String, dynamic> _params = {'name': name, 'page': page};

    try {
      final Response response =
          await dio.get(endPoind, queryParameters: _params);
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
}

class CharactersResponse {
  final List<Character> characters;
  final int count;
  final String? nextPageUrl;
  final int? nextPageNumber;

  CharactersResponse(
      {required this.characters,
      required this.count,
      required this.nextPageUrl,
      required this.nextPageNumber});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    final characters = (json['results'] as List<dynamic>)
        .map((json) => Character.fromJson(json))
        .toList();
    final info = json['info'] as Map<String, dynamic>;
    final count = info['count'] as int;
    final nextPageUrl = info['next'] as String?;
    int? nextPageNumber;
    if (nextPageUrl != null) {
      nextPageNumber = nextPageUrl.pageNumberFromUrl;
    }
    return CharactersResponse(
      characters: characters,
      count: count,
      nextPageUrl: nextPageUrl,
      nextPageNumber: nextPageNumber,
    );
  }
}

extension UrlExtension on String {
  int? get pageNumberFromUrl {
    final regex = RegExp(r'page=(\d+)');
    final match = regex.firstMatch(this);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    return null;
  }
}
