import 'package:rick_and_morty/state/models/character_model.dart';

class CharactersResponse {
  final List<Character> characters;
  final int count;
  final String? nextPageUrl;
  final int? nextPageNumber;

  CharactersResponse({
    required this.characters,
    required this.count,
    required this.nextPageUrl,
    required this.nextPageNumber,
  });

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

  CharactersResponse copyWith({
    List<Character>? characters,
  }) {
    return CharactersResponse(
      characters: characters ?? this.characters,
      count: count,
      nextPageUrl: nextPageUrl ?? nextPageUrl,
      nextPageNumber: nextPageNumber ?? nextPageNumber,
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
