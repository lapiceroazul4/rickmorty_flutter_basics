import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/models/character.dart';

class RickMortyService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  static Future<List<Character>> getCharacters() async {
    final response = await http.get(Uri.parse('$_baseUrl/character'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar personajes');
    }
  }
}
