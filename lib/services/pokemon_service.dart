import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Pokemon>> fetchPokemonList({int limit = 50}) async {
    final response = await http.get(Uri.parse('$baseUrl?limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((json) => Pokemon.fromListJson(json)).toList();
    } else {
      throw Exception('Failed to load Pokemon list');
    }
  }

  Future<Pokemon> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pokemon.fromDetailJson(data);
    } else {
      throw Exception('Failed to load Pokemon detail');
    }
  }
}
