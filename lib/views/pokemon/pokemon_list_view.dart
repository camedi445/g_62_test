import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import 'pokemon_detail_view.dart';

class PokemonListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokemonControllerProvider);

    return state.when(
      data: (pokemonList) {
        return RefreshIndicator(
          onRefresh: () => ref.read(pokemonControllerProvider.notifier).loadPokemons(),
          child: ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: pokemon.imageUrl != null
                      ? Image.network(
                          pokemon.imageUrl!,
                          width: 64,
                          height: 64,
                          errorBuilder: (_, __, ___) => Icon(Icons.error),
                        )
                      : SizedBox(
                          width: 64,
                          height: 64,
                          child: Center(child: CircularProgressIndicator())),
                  title: Text(pokemon.name.toUpperCase()),
                  subtitle: Text('Tipo: ${pokemon.types?.join(", ") ?? '?'}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => PokemonDetailView(pokemon: pokemon),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
