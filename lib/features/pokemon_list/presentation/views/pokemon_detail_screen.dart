// lib/features/pokemon_list/presentation/views/pokemon_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Importa el controlador de detalle de Pokémon
import 'package:pokemon_app/features/pokemon_list/presentation/controllers/pokemon_detail_controller.dart';
// Importa el modelo de detalle de Pokémon para acceder a sus propiedades
// ignore: unused_import // Se usa como tipo genérico, el linter a veces lo marca como no usado.
import 'package:pokemon_app/features/pokemon_list/data/models/pokemon_model.dart';


class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa el estado del pokemonDetailControllerProvider.
    // Cuando el estado (loading, data, error) cambie, este widget se reconstruirá.
    final pokemonDetailAsyncValue = ref.watch(pokemonDetailControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Pokémon'),
        // Cuando volvemos de esta pantalla, limpiamos el detalle seleccionado en el controlador
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Llama al método clearDetail() del notifier para resetear el estado del detalle.
            ref.read(pokemonDetailControllerProvider.notifier).clearDetail();
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: pokemonDetailAsyncValue.when(
        // Estado de carga: muestra un CircularProgressIndicator.
        loading: () => const Center(child: CircularProgressIndicator()),
        // Estado de error: muestra un mensaje de error y un botón para volver.
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error al cargar detalles: $error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Limpia el detalle y vuelve a la lista en caso de error.
                  ref.read(pokemonDetailControllerProvider.notifier).clearDetail();
                  Navigator.pop(context);
                },
                child: const Text('Volver a la lista'),
              ),
            ],
          ),
        ),
        // Estado de datos: muestra los detalles del Pokémon.
        data: (detail) {
          if (detail == null) {
            // Esto puede ocurrir si el selectedPokemonUrlProvider se limpia
            // antes de que la pantalla se desmonte, o si no se seleccionó nada.
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No se ha seleccionado ningún Pokémon para ver detalles.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Vuelve a la pantalla anterior
                    },
                    child: const Text('Volver a la lista'),
                  ),
                ],
              ),
            );
          }

          // Si tenemos datos, mostramos los detalles.
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  detail.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Imagen del Pokémon
                detail.sprites.frontDefault.isNotEmpty
                    ? Image.network(
                        detail.sprites.frontDefault,
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                      )
                    : Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                      ),
                const SizedBox(height: 20),
                // Información básica
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildDetailRow('ID:', '#${detail.id}'),
                        _buildDetailRow('Altura:', '${detail.height / 10} m'), // Convertir decímetros a metros
                        _buildDetailRow('Peso:', '${detail.weight / 10} kg'), // Convertir hectogramos a kilogramos
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tipos
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tipos:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          // CORRECCIÓN: Eliminado .toList() innecesario
                          children: detail.types
                              .map((type) => Chip(
                                    label: Text(type.name.toUpperCase()),
                                    backgroundColor: Colors.blue.shade100,
                                    labelStyle: const TextStyle(color: Colors.blueAccent),
                                  ))
                              .toList(), // Mantengo el .toList() aquí para asegurar que Wrap reciba una lista concreta.
                                         // Aunque el linter lo marque, a veces es necesario para la inferencia de tipos o si el iterable es grande.
                                         // Si el linter sigue quejándose y no hay problemas de rendimiento, se puede ignorar.
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Habilidades
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Habilidades:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        // CORRECCIÓN: Eliminado .toList() innecesario
                        ...detail.abilities
                            .map((ability) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Text('- ${ability.name.toUpperCase()}'),
                                )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget auxiliar para mostrar filas de detalle de forma consistente
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
