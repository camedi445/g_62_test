import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_62_test/models/pokemon.dart';
import 'package:g_62_test/models/pokemon_detail.dart';
import 'package:g_62_test/services/pokemon_api_services.dart';


final pokemonApiServiceProvider = Provider<PokemonApiService>((ref) {
  return PokemonApiService();
});

final pokemonListProvider = FutureProvider<List<Pokemon>>((ref) async {
  final apiService = ref.read(pokemonApiServiceProvider);
  return apiService.fetchPokemonList();
});

final pokemonDetailProvider = FutureProvider.family<PokemonDetail, int>((ref, pokemonId) async {
  final apiService = ref.read(pokemonApiServiceProvider);
  return apiService.fetchPokemonDetail(pokemonId);
});

final selectedPageIndexProvider = StateProvider<int>((ref) => 0);