import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/pokemon_controller.dart';
import '../models/pokemon.dart';

final pokemonProvider = StateNotifierProvider<PokemonController, List<Pokemon>>((ref) {
    return PokemonController();
  }
);
