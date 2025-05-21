import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonDetailDialog extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailDialog({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(pokemon.name.toUpperCase()),
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pokemon.imageUrl != null)
              Image.network(
                pokemon.imageUrl!,
                height: 200,
                errorBuilder:
                    (context, error, stackTrace) => const Icon(Icons.error),
              )
            else
              const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text('Altura: ${pokemon.height ?? '?'} dm'),
            Text('Peso: ${pokemon.weight ?? '?'} hg'),
            Text('Tipo: ${pokemon.type ?? '?'}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
