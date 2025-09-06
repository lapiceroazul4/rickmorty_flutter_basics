import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/models/character.dart';
import 'package:test_app/models/location.dart';
import 'package:test_app/models/episode.dart';

class RickMortyProvider extends ChangeNotifier {
  final String _baseUrl = 'rickandmortyapi.com';
  
  // Paginación para characters
  int _paginaCharacters = 1;
  bool _cargandoCharacters = false;
  
  // Paginación para locations
  int _paginaLocations = 1;
  bool _cargandoLocations = false;
  
  // Paginación para episodes
  int _paginaEpisodes = 1;
  bool _cargandoEpisodes = false;

  // Listas de datos
  List<Character> characters = [];
  List<Location> locations = [];
  List<Episode> episodes = [];

  RickMortyProvider() {
    getOnDisplayCharacters();
    getOnDisplayLocations();
    getOnDisplayEpisodes();
  }

  // MÉTODOS PARA CHARACTERS
  Future<void> getOnDisplayCharacters() async {
    if (_cargandoCharacters) return;
    _cargandoCharacters = true;

    var url = Uri.https(_baseUrl, 'api/character', {
      'page': _paginaCharacters.toString(),
    });

    try {
      final response = await http.get(url);
      final Map<String, dynamic> decodeData = json.decode(response.body);

      final List results = decodeData['results'];

      characters.addAll(results.map((json) => Character.fromJson(json)).toList());

      _paginaCharacters++;
      _cargandoCharacters = false;

      notifyListeners();
    } catch (e) {
      _cargandoCharacters = false;
      print('Error cargando characters: $e');
    }
  }

  // MÉTODOS PARA LOCATIONS
  Future<void> getOnDisplayLocations() async {
    if (_cargandoLocations) return;
    _cargandoLocations = true;

    var url = Uri.https(_baseUrl, 'api/location', {
      'page': _paginaLocations.toString(),
    });

    try {
      final response = await http.get(url);
      final Map<String, dynamic> decodeData = json.decode(response.body);

      final List results = decodeData['results'];

      locations.addAll(results.map((json) => Location.fromJson(json)).toList());

      _paginaLocations++;
      _cargandoLocations = false;

      notifyListeners();
    } catch (e) {
      _cargandoLocations = false;
      print('Error cargando locations: $e');
    }
  }

  // Método para cargar más locations (scroll infinito)
  Future<void> loadMoreLocations() async {
    await getOnDisplayLocations();
  }

  // MÉTODOS PARA EPISODES
  Future<void> getOnDisplayEpisodes() async {
    if (_cargandoEpisodes) return;
    _cargandoEpisodes = true;

    var url = Uri.https(_baseUrl, 'api/episode', {
      'page': _paginaEpisodes.toString(),
    });

    try {
      final response = await http.get(url);
      final Map<String, dynamic> decodeData = json.decode(response.body);

      final List results = decodeData['results'];

      episodes.addAll(results.map((json) => Episode.fromJson(json)).toList());

      _paginaEpisodes++;
      _cargandoEpisodes = false;

      notifyListeners();
    } catch (e) {
      _cargandoEpisodes = false;
      print('Error cargando episodes: $e');
    }
  }

  // Método para cargar más episodes (scroll infinito)
  Future<void> loadMoreEpisodes() async {
    await getOnDisplayEpisodes();
  }

  // GETTERS para saber si está cargando
  bool get isLoadingCharacters => _cargandoCharacters;
  bool get isLoadingLocations => _cargandoLocations;
  bool get isLoadingEpisodes => _cargandoEpisodes;

  // MÉTODOS PARA BUSCAR POR ID
  Future<Location?> getLocationById(int id) async {
    try {
      var url = Uri.https(_baseUrl, 'api/location/$id');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodeData = json.decode(response.body);
        return Location.fromJson(decodeData);
      }
    } catch (e) {
      print('Error obteniendo location por ID: $e');
    }
    return null;
  }

  Future<Episode?> getEpisodeById(int id) async {
    try {
      var url = Uri.https(_baseUrl, 'api/episode/$id');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodeData = json.decode(response.body);
        return Episode.fromJson(decodeData);
      }
    } catch (e) {
      print('Error obteniendo episode por ID: $e');
    }
    return null;
  }

  // MÉTODOS PARA REINICIAR LISTAS (útil para refresh)
  void resetCharacters() {
    characters.clear();
    _paginaCharacters = 1;
    _cargandoCharacters = false;
    getOnDisplayCharacters();
  }

  void resetLocations() {
    locations.clear();
    _paginaLocations = 1;
    _cargandoLocations = false;
    getOnDisplayLocations();
  }

  void resetEpisodes() {
    episodes.clear();
    _paginaEpisodes = 1;
    _cargandoEpisodes = false;
    getOnDisplayEpisodes();
  }
}