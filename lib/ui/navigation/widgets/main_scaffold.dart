import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_62_test/ui/home/provider/controller_provider.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/pantalla2')) return 1;
    if (location.startsWith('/pantalla3')) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/pantalla2');
        break;
      case 2:
        context.go('/pantalla3');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonListController = ref.read(
      pokemonListControllerProvider.notifier,
    );
    final currentIndex = _getIndex(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon App Sin Malas Prácticas'),
        actions: [
          if (currentIndex == 0)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                pokemonListController.getPokemonList();
              },
            ),
        ],
      ),
      // Usar el índice global en lugar de un estado local
      body: child,
      // Bottom Navigation Bar sin extraer en un widget separado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        items: [
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
                  // Mala práctica: no usar métodos separados
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '¡Esta ya no es una aplicación con malas prácticas!',
                      ),
                    ),
                  );
                },
                child: Icon(Icons.info),
              )
              : null,
    );
  }
}
