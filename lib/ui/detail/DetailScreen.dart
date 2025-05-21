import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.detail});

  final dynamic detail;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Pokémon'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            detail['sprites']?['front_default'] != null
                ? Image.network(
                  detail['sprites']['front_default'],
                  height: 200,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(Icons.error),
                )
                : const SizedBox.shrink(),
            const SizedBox(height: 10),
            Text('Altura: ${detail['height'] ?? '?'} dm'),
            Text('Peso: ${detail['weight'] ?? '?'} hg'),
            Text(
              'Tipo: ${detail['types'] != null && detail['types'].isNotEmpty ? detail['types'][0]['type']['name'] : '?'}',
            ),
          ],
        ),
      ),
    );
  }
}
