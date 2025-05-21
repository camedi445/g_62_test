import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_62_test/providers/pokemon_providers.dart';

class PokemonDetailScreen extends ConsumerWidget {
  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonDetailAsyncValue = ref.watch(pokemonDetailProvider(pokemonId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Pokémon #$pokemonId'),
        centerTitle: true,
      ),
      body: pokemonDetailAsyncValue.when(
        data: (pokemonDetail) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'pokemon-${pokemonDetail.id}',
                  child: Image.network(
                    pokemonDetail.imageUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 200,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  pokemonDetail.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow('ID:', '#${pokemonDetail.id}'),
                _buildDetailRow('Altura:', '${pokemonDetail.height / 10} m'), 
                _buildDetailRow('Peso:', '${pokemonDetail.weight / 10} kg'), 
                _buildDetailRow('Tipos:', pokemonDetail.types.join(', ')),
                _buildDetailRow('Habilidades:', pokemonDetail.abilities.join(', ')),
              ],
            ),
          );
        },
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
                  'Error al cargar detalle de Pokémon: $error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                  onPressed: () {
                    ref.invalidate(pokemonDetailProvider(pokemonId));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}