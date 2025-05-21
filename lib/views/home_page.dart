import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pokémon:'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(pokemonProvider),
          ),
        ],
      ),
      body: pokemonAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final pokemon = list[index];

              return ListTile(
                leading:
                    pokemon.image != null
                        ? Image.network(pokemon.image!)
                        : const Icon(Icons.catching_pokemon),
                title: Text(pokemon.name.toUpperCase()),
                subtitle: Text('Tipo: ${pokemon.type ?? "?"}'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: Text(pokemon.name.toUpperCase()),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (pokemon.image != null)
                                Image.network(pokemon.image!, height: 100),
                              const SizedBox(height: 10),
                              Text('Altura: ${pokemon.height ?? "?"} dm'),
                              Text('Peso: ${pokemon.weight ?? "?"} hg'),
                              Text('Tipo: ${pokemon.type ?? "?"}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
