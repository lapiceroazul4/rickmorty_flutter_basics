import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/models/character.dart';

class RickMortyProvider extends ChangeNotifier {
  final String _baseUrl = 'rickandmortyapi.com';
  int _pagina = 1;
  bool _cargando = false;

  List<Character> characters = [];

  RickMortyProvider() {
    getOnDisplayCharacters();
  }

  Future<void> getOnDisplayCharacters() async {
    if (_cargando) return; // evita llamadas dobles
    _cargando = true;

    var url = Uri.https(_baseUrl, 'api/character', {
      'page': _pagina.toString(),
    });

    final response = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(response.body);

    final List results = decodeData['results'];

    // agregamos a la lista existente (scroll infinito)
    characters.addAll(results.map((json) => Character.fromJson(json)).toList());

    _pagina++; // avanzamos página
    _cargando = false;

    notifyListeners(); // 🔥 avisa a la UI
  }
}
