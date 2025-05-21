import 'package:g_62_test/data/pokemon_service.dart';
import 'package:g_62_test/ui/home/controller/pokemon_list_state.dart';
import 'package:riverpod/riverpod.dart';

class PokemonListController extends StateNotifier<PokemonListState> {
  PokemonListController() : super(PokemonListState());

  final pokemonService = PokemonService();

  Future<void> initialize() async {
    await getPokemonList();
  }

  Future<void> getPokemonList() async {
    state = state.copyWith(isLoading: true);

    try {
      final pokemonList = await pokemonService.fetchPokemonList();
      state = state.copyWith(isLoading: false, pokemonList: pokemonList);
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }
}
