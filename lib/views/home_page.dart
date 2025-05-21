import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_providers.dart';
import 'pokemon_detail_dialog.dart';
import 'widgets/pokemon_list_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final pokemonListAsync = ref.watch(pokemonListProvider);

    final List<Widget> screens = [
      pokemonListAsync.when(
        data: (pokemonList) {
          if (pokemonList.isEmpty) {
            return const Center(child: Text('No hay Pokémon disponibles.'));
          }
          return ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              return PokemonListItem(
                pokemon: pokemon,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PokemonDetailDialog(pokemon: pokemon);
                    },
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error al cargar los Pokémon.'),
                  Text(error.toString()),
                  ElevatedButton(
                    onPressed:
                        () =>
                            ref
                                .read(pokemonListProvider.notifier)
                                .fetchPokemons(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
      ),
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.apps, size: 100, color: Colors.blueGrey),
            SizedBox(height: 20),
            Text(
              'Pantalla 2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videogame_asset, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Pantalla 3',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon App con Riverpod y MVC'),
        actions: [
          if (currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(pokemonListProvider.notifier).fetchPokemons();
              },
            ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokémon',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Pantalla 2'),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Pantalla 3',
          ),
        ],
      ),
      floatingActionButton:
          currentIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ya tiene MVC y Riverpod Implementado'),
                    ),
                  );
                },
                child: const Icon(Icons.info),
              )
              : null,
    );
  }
}
