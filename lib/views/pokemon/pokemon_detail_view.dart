import 'package:flutter/material.dart';

import '../../models/pokemon_model.dart';

class PokemonDetailView extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(pokemon.name.toUpperCase()),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pokemon.imageUrl != null)
              Image.network(
                pokemon.imageUrl!,
                height: 200,
                errorBuilder: (_, __, ___) => Icon(Icons.error),
              ),
            SizedBox(height: 10),
            Text('ID: #${pokemon.id ?? '?'}'),
            Text('Altura: ${pokemon.height ?? '?'} dm'),
            Text('Peso: ${pokemon.weight ?? '?'} hg'),
            Text('Tipo: ${pokemon.types?.join(", ") ?? '?'}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cerrar'),
        ),
      ],
    );
  }
}
