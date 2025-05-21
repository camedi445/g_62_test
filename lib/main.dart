// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod

// Importa tus nuevas vistas (aún no creadas, pero las crearemos en los siguientes pasos)
// Asegúrate de que la ruta sea correcta según tu estructura de carpetas
import 'package:pokemon_app/features/pokemon_list/presentation/views/pokemon_list_screen.dart';
import 'package:pokemon_app/features/mock_screens/presentation/views/mock_screen.dart';


void main() {
  // Envuelve toda la aplicación con ProviderScope para que Riverpod funcione
  runApp(
    ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget { // Cambia a ConsumerWidget para usar Riverpod
  const MainApp({super.key}); // Usa const para el constructor

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Añade WidgetRef ref
    // Un provider para manejar el índice de la BottomNavigationBar
    // Lo definimos aquí temporalmente, luego lo moveremos a un controlador de UI más específico
    final currentIndexProvider = StateProvider<int>((ref) => 0);
    final currentIndex = ref.watch(currentIndexProvider);

    // Lista de pantallas que se mostrarán en el body
    final List<Widget> screens = [
      const PokemonListScreen(), // Nuestra futura pantalla de lista de Pokémon
      const MockScreen(title: 'Pantalla Mock 1'), // Pantalla Mock 1
      const MockScreen(title: 'Pantalla Mock 2'), // Pantalla Mock 2
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar el banner de debug
      title: 'Pokemon App Refactorizada con MVC y Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        // CORRECCIÓN: Usar CardThemeData en lugar de CardTheme
        cardTheme: CardThemeData( 
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 8,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokémon App'),
          // El botón de refrescar se moverá a PokemonListScreen y su controlador
          actions: [
            if (currentIndex == 0) // Solo mostrar refresh en la pantalla de Pokémon
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  // Aquí se llamaría a un método del controlador de PokemonListScreen
                  // Por ahora, solo un print, lo implementaremos en el siguiente paso
                  print('Botón de refrescar presionado');
                },
              ),
          ],
        ),
        body: screens[currentIndex], // Muestra la pantalla actual
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            // Actualiza el estado del provider con el nuevo índice
            ref.read(currentIndexProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon),
              label: 'Pokémon',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Mock 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset),
              label: 'Mock 2',
            ),
          ],
        ),
        floatingActionButton: currentIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '¡Esta es la aplicación refactorizada!',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Icon(Icons.info),
              )
            : null,
      ),
    );
  }
}
