import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonController {
  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;
      return results.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los Pokémon');
    }
  }
}