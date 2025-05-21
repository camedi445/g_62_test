import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/pokemon_controller.dart';
import '../models/pokemon.dart';

final pokemonProvider = FutureProvider<List<Pokemon>>((ref) async {
  return PokemonController().fetchPokemonList();
});
