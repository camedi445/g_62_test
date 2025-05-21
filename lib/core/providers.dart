import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon_model.dart';
import '../controllers/pokemon_controller.dart';

// Provider del controlador de Pokémon
final pokemonControllerProvider =
    StateNotifierProvider<PokemonController, AsyncValue<List<Pokemon>>>(
        (ref) => PokemonController());
