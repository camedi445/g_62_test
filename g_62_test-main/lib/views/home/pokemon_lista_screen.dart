import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_62_test/providers/pokemon_providers.dart';
import 'package:g_62_test/views/home/pokemon_detail_screen.dart';
import 'package:g_62_test/views/home/widgets/pokemon_list_item.dart';

class PokemonListaScreen extends ConsumerWidget {
  const PokemonListaScreen({super.key}); 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonListAsyncValue = ref.watch(pokemonListProvider);

    return pokemonListAsyncValue.when(
      data: (pokemonList) => ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = pokemonList[index];
          return PokemonListItem(
            pokemon: pokemon,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonDetailScreen(pokemonId: pokemon.id),
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(
                'Error al cargar Pokémon: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
                onPressed: () => ref.invalidate(pokemonListProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}