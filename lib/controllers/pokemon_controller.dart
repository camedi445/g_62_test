import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pokemon_model.dart';
import '../services/pokemon_service.dart';

class PokemonController extends StateNotifier<AsyncValue<List<Pokemon>>> {
  final PokemonService _service = PokemonService();

  PokemonController() : super(const AsyncValue.loading()) {
    loadPokemons();
  }

  Future<void> loadPokemons() async {
    try {
      state = const AsyncValue.loading();
      final pokemons = await _service.fetchPokemonList();

      // Obtener detalles paralelamente para cada pokemon
      final detailedPokemons = await Future.wait(pokemons.map((pokemon) async {
        final detail = await _service.fetchPokemonDetail(pokemon.url);
        return pokemon.copyWith(
          id: detail.id,
          imageUrl: detail.imageUrl,
          height: detail.height,
          weight: detail.weight,
          types: detail.types,
        );
      }));

      state = AsyncValue.data(detailedPokemons);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
