import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon.dart';
import '../repositories/pokemon_repository.dart';

final pokemonRepositoryProvider = Provider((ref) => PokemonRepository());

class PokemonNotifier extends StateNotifier<AsyncValue<List<Pokemon>>> {
  final PokemonRepository _repository;

  PokemonNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    try {
      state = const AsyncValue.loading(); // Estado de carga
      final List<Pokemon> pokemons = await _repository.fetchPokemonList();

      final List<Future<Pokemon>> detailFutures =
          pokemons.map((pokemon) async {
            try {
              final detail = await _repository.fetchPokemonDetails(pokemon.url);
              return pokemon.copyWith(
                id: detail.id,
                imageUrl: detail.imageUrl,
                height: detail.height,
                weight: detail.weight,
                type: detail.type,
              );
            } catch (e) {
              print('Error fetching details for ${pokemon.name}: $e');
              return pokemon;
            }
          }).toList();

      final List<Pokemon> detailedPokemons = await Future.wait(detailFutures);
      state = AsyncValue.data(detailedPokemons);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final pokemonListProvider =
    StateNotifierProvider<PokemonNotifier, AsyncValue<List<Pokemon>>>((ref) {
      return PokemonNotifier(ref.watch(pokemonRepositoryProvider));
    });

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
