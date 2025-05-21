import 'dart:convert';

import 'package:http/http.dart' as http;

class PokemonService {
  // Future<List<dynamic>> fetchPokemonList() async {
  //     final response = await http.get(
  //       Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       // Modificando variable global directamente
  //       final pokemonList = data['results'];

  //       // Obtener detalles de cada pokemon (manera ineficiente)
  //       for (int i = 0; i < pokemonList.length; i++) {
  //         final detailResponse = await http.get(
  //           Uri.parse(pokemonList[i]['url']),
  //         );
  //         if (detailResponse.statusCode == 200) {
  //           final detailData = json.decode(detailResponse.body);
  //           pokemonList[i]['detail'] = detailData;
  //         }
  //       }
  //       return pokemonList;

  //     } else {
  //       throw Exception('Error al cargar datos: ${response.statusCode}');
  //     }
  // }

  Future<List<Map<String, dynamic>>> fetchPokemonList() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al cargar datos: ${response.statusCode}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<Map<String, dynamic>> pokemonList =
        (data['results'] as List).cast<Map<String, dynamic>>();

    final futures =
        pokemonList.map((pokemon) async {
          final detailResponse = await http.get(Uri.parse(pokemon['url']));
          if (detailResponse.statusCode == 200) {
            final detailData =
                json.decode(detailResponse.body) as Map<String, dynamic>;
            return {...pokemon, 'detail': detailData};
          } else {
            return {...pokemon, 'detail': null};
          }
        }).toList();

    final detailedPokemonList = await Future.wait(futures);

    return detailedPokemonList;
  }
}
