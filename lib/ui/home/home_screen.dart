// StatefulWidget innecesariamente complejo
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_62_test/ui/home/provider/controller_provider.dart';
import 'package:g_62_test/ui/home/widgets/pokemon_item_list.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(pokemonListControllerProvider);

    return listState.isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: listState.pokemonList.length,
          itemBuilder: (context, index) {
            final pokemon = listState.pokemonList[index];
            final detail = pokemon['detail'];

            return PokemonItemList(pokemon: pokemon, detail: detail);
          },
        );
  }
}
