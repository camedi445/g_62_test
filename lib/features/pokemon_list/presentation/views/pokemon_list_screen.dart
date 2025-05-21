// lib/features/pokemon_list/presentation/views/pokemon_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Necesario para ConsumerWidget y ref

// Importa el controlador de la lista de Pokémon
import 'package:pokemon_app/features/pokemon_list/presentation/controllers/pokemon_list_controller.dart';
// Importa el controlador de detalle para poder seleccionar un Pokémon
import 'package:pokemon_app/features/pokemon_list/presentation/controllers/pokemon_detail_controller.dart';
// Importa la pantalla de detalle para la navegación
import 'package:pokemon_app/features/pokemon_list/presentation/views/pokemon_detail_screen.dart';


class PokemonListScreen extends ConsumerWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa el estado del pokemonListControllerProvider.
    // Cuando el estado (loading, data, error) cambie, este widget se reconstruirá.
    final pokemonListAsyncValue = ref.watch(pokemonListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pokémon'),
        actions: [
          // Botón para refrescar la lista.
          // Llama al método refreshPokemons() del notifier.
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(pokemonListControllerProvider.notifier).refreshPokemons();
            },
          ),
        ],
      ),
      body: pokemonListAsyncValue.when(
        // Estado de carga: muestra un CircularProgressIndicator.
        loading: () => const Center(child: CircularProgressIndicator()),
        // Estado de error: muestra un mensaje de error.
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error al cargar Pokémon: $error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ),
        // Estado de datos: muestra la lista de Pokémon.
        data: (pokemons) {
          if (pokemons.isEmpty) {
            return const Center(
              child: Text('No se encontraron Pokémon.'),
            );
          }
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    // Puedes usar una imagen por defecto o la primera letra del nombre
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      pokemon.name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(pokemon.url), // Temporalmente la URL, luego será el ID o tipo
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Cuando se toca un Pokémon, actualizamos el selectedPokemonUrlProvider
                    // para que el PokemonDetailNotifier sepa qué detalle cargar.
                    ref.read(PokemonDetailNotifier.selectedPokemonUrlProvider.notifier).state = pokemon.url;
                    // Navegamos a la pantalla de detalle.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PokemonDetailScreen(),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}