import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pokemon.dart';

final pokemonControllerProvider = StateNotifierProvider<PokemonController, List<Pokemon>>((ref) {
  return PokemonController();
});

class PokemonController extends StateNotifier<List<Pokemon>> {
  PokemonController() : super([]);

  Future<void> fetchPokemonData() async {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        List<Pokemon> pokemons = [];
        for (var item in results) {
          final pokemonDetailsResponse = await http.get(Uri.parse(item['url']));

          if (pokemonDetailsResponse.statusCode == 200) {
            final details = json.decode(pokemonDetailsResponse.body);
            final String name = details['name'] ?? 'Unknown';
            final String imageUrl = details['sprites']?['front_default'] ?? '';
            final String type = details['types']?[0]['type']['name'] ?? 'Unknown';
            final int id = details['id'] ?? 0;
            final double height = details['height']?.toDouble() ?? 0.0;
            final double weight = details['weight']?.toDouble() ?? 0.0;
            
            pokemons.add(Pokemon(
              name: name,
              url: item['url'],
              id: id,
              imageUrl: imageUrl,
              height: height,
              weight: weight,
              type: type,
            ));
          }
        }
      state = pokemons;
    } 
  }
}
