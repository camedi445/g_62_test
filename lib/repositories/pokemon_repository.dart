import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonRepository {
  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception(
        'Error al cargar la lista de Pokémon: ${response.statusCode}',
      );
    }
  }

  Future<Pokemon> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception(
        'Error al cargar los detalles del Pokémon: ${response.statusCode}',
      );
    }
  }
}
