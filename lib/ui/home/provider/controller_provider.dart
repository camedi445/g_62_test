import 'package:g_62_test/ui/home/controller/pokemon_list_controller.dart';
import 'package:g_62_test/ui/home/controller/pokemon_list_state.dart';
import 'package:riverpod/riverpod.dart';

final pokemonListControllerProvider =
    StateNotifierProvider<PokemonListController, PokemonListState>((ref) {
      final PokemonListController pokemonListController =
          PokemonListController();
      pokemonListController.initialize();
      return pokemonListController;
    });
