import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:g_62_test/models/pokemon.dart';
import 'package:g_62_test/models/pokemon_detail.dart';

class PokemonApiService {
  final String _baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemonList({int offset = 0, int limit = 50}) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/pokemon?offset=$offset&limit=$limit'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['results'] as List)
            .map((json) => Pokemon.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load Pokemon list: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Pokemon list: $e');
    }
  }


  Future<PokemonDetail> fetchPokemonDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/pokemon/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PokemonDetail.fromJson(data);
      } else {
        throw Exception('Failed to load Pokemon detail for ID $id: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Pokemon detail for ID $id: $e');
    }
  }
}