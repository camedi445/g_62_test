import 'package:flutter/material.dart';
import 'package:g_62_test/ui/detail/DetailScreen.dart';
import 'package:go_router/go_router.dart';

class PokemonItemList extends StatelessWidget {
  final pokemon;
  final detail;

  const PokemonItemList({super.key, this.pokemon, this.detail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/detail', extra: detail);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              detail != null && detail['sprites'] != null
                  ? Image.network(
                    detail['sprites']['front_default'],
                    height: 100,
                    width: 100,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[300],
                          child: Icon(Icons.error),
                        ),
                  )
                  : Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[300],
                    child: CircularProgressIndicator(),
                  ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${pokemon['name']}'.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (detail != null) ...[
                      SizedBox(height: 8),
                      Text('ID: #${detail['id']}'),
                      Text('Tipo: ${detail['types'][0]['type']['name']}'),
                      Text('Altura: ${detail['height']} dm'),
                      Text('Peso: ${detail['weight']} hg'),
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
