import 'package:flutter/material.dart';
import '../../models/pokemon.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonListItem({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (pokemon.imageUrl != null)
                Image.network(
                  pokemon.imageUrl!,
                  height: 100,
                  width: 100,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                )
              else
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (pokemon.id != null) ...[
                      const SizedBox(height: 8),
                      Text('ID: #${pokemon.id}'),
                      Text('Tipo: ${pokemon.type ?? '?'}'),
                      Text('Altura: ${pokemon.height ?? '?'} dm'),
                      Text('Peso: ${pokemon.weight ?? '?'} hg'),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
