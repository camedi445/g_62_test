import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonController {
  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      List<Pokemon> pokemons = results.map((e) => Pokemon.fromJson(e)).toList();

      for (int i = 0; i < pokemons.length; i++) {
        final detail = await http.get(Uri.parse(pokemons[i].url));
        if (detail.statusCode == 200) {
          final detailData = json.decode(detail.body);
          pokemons[i] = pokemons[i].copyWithDetail(detailData);
        }
      }

      return pokemons;
    } else {
      throw Exception('Error al obtener Pokémon');
    }
  }
}
