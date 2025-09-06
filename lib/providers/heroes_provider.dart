import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/models/heroe.dart';
import 'package:test_app/models/multimedia.dart';

class HeroesProvider extends ChangeNotifier {
  final String _baseUrl = 'rest-sorella-production.up.railway.app';
  
  // Headers comunes para todas las peticiones
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  List<Heroe> _heroes = [];
  bool _cargandoHeroes = false;
  String? _error;

  HeroesProvider();

  // Getters
  List<Heroe> get heroes => _heroes;
  bool get isLoadingHeroes => _cargandoHeroes;
  String? get error => _error;

  // Método privado para manejo de errores
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  // Obtener todos los héroes
  Future<List<Heroe>> getHeroes() async {
    // Si ya se están cargando, retornar la lista actual
    if (_cargandoHeroes) return _heroes;
    
    _cargandoHeroes = true;
    _clearError();
    notifyListeners();

    final url = Uri.https(_baseUrl, '/api/heroes');

    try {
      final response = await http.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodeData = json.decode(response.body);
        final List results = decodeData['resp'] ?? [];
        _heroes = results.map((json) => Heroe.fromJson(json)).toList();
      } else {
        final errorMsg = 'Error cargando héroes: ${response.statusCode}';
        _setError(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      final errorMsg = 'Error cargando héroes: $e';
      _setError(errorMsg);
      print(errorMsg);
      rethrow; // Re-lanzar la excepción para que el caller pueda manejarla
    } finally {
      _cargandoHeroes = false;
      notifyListeners();
    }

    return _heroes;
  }

  // Obtener héroe por ID
  Future<Heroe?> getHeroeById(String id) async {
    if (id.isEmpty) {
      _setError('ID de héroe no puede estar vacío');
      return null;
    }

    final url = Uri.https(_baseUrl, '/api/heroes/$id');

    try {
      _clearError();
      final response = await http.get(url, headers: _headers);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodeData = json.decode(response.body);
        if (decodeData['resp'] != null) {
          return Heroe.fromJson(decodeData['resp']);
        } else {
          _setError('Héroe no encontrado');
          return null;
        }
      } else if (response.statusCode == 404) {
        _setError('Héroe no encontrado');
        return null;
      } else {
        final errorMsg = 'Error obteniendo héroe: ${response.statusCode}';
        _setError(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      final errorMsg = 'Error obteniendo héroe: $e';
      _setError(errorMsg);
      print(errorMsg);
      return null;
    }
  }

  // Obtener todas las multimedia
  Future<List<Multimedia>> getAllMultimedias() async {
    final url = Uri.https(_baseUrl, '/api/multimedias');
    
    try {
      _clearError();
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> resp = data['resp'] ?? [];
        return resp.map((e) => Multimedia.fromJson(e)).toList();
      } else {
        final errorMsg = 'Error al obtener multimedia: ${response.statusCode}';
        _setError(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      final errorMsg = 'Error al obtener multimedia: $e';
      _setError(errorMsg);
      print(errorMsg);
      rethrow;
    }
  }

  // Obtener multimedia por héroe
  Future<List<Multimedia>> getMultimediaByHeroe(String id) async {
    if (id.isEmpty) {
      final errorMsg = 'ID de héroe no puede estar vacío';
      _setError(errorMsg);
      throw Exception(errorMsg);
    }

    final url = Uri.https(_baseUrl, '/api/multimedias/heroe/$id');
    
    try {
      _clearError();
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> resp = data['resp'] ?? [];
        return resp.map((e) => Multimedia.fromJson(e)).toList();
      } else if (response.statusCode == 404) {
        // Si el héroe no tiene multimedia, retornar lista vacía en lugar de error
        return [];
      } else {
        final errorMsg = 'Error al obtener multimedia del héroe: ${response.statusCode}';
        _setError(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      final errorMsg = 'Error al obtener multimedia del héroe: $e';
      _setError(errorMsg);
      print(errorMsg);
      rethrow;
    }
  }

  // Método para refrescar los héroes (forzar nueva carga)
  Future<List<Heroe>> refreshHeroes() async {
    _heroes.clear();
    return await getHeroes();
  }

  // Método para limpiar el cache
  void clearCache() {
    _heroes.clear();
    _clearError();
    notifyListeners();
  }

  // Método para buscar héroe por nombre localmente
  List<Heroe> searchHeroesByName(String name) {
    if (name.isEmpty) return _heroes;
    
    return _heroes.where((heroe) => 
        heroe.nombre.toLowerCase().contains(name.toLowerCase())
    ).toList();
  }
}