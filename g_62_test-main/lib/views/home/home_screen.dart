import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_62_test/providers/pokemon_providers.dart';
import 'package:g_62_test/views/home/pokemon_lista_screen.dart'; 
import 'package:g_62_test/views/mock_screen_x.dart';
import 'package:g_62_test/views/mock_screen_y.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final List<Widget> _screens = [
    PokemonListaScreen(), 
    MockScreenX(),        
    MockScreenY(),        
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedPageIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon App'),
        centerTitle: true,
        actions: [
          if (selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.invalidate(pokemonListProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Recargando Pokémon...')),
                );
              },
            ),
        ],
      ),
      body: _screens[selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(selectedPageIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokémon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Pantalla 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Pantalla 3',
          ),
        ],
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      '¡Esta es una aplicación refactorizada con buenas prácticas',
                    ),
                  ),
                );
              },
              child: const Icon(Icons.info),
            )
          : null,
    );
  }
}