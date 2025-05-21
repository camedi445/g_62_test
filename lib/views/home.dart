import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';
import '../models/pokemon.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(pokemonProvider.notifier).fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    final List<Pokemon> pokemons = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon App'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(pokemonProvider.notifier).fetchPokemonData();
            },
          ),
        ],
      ),

      body: pokemons.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.network(
                      pokemon.imageUrl,
                      height: 100,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) =>
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[300],
                          child: Icon(Icons.error),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pokemon.name.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('ID: #${pokemon.id}'),
                            Text('Tipo: ${pokemon.type}'),
                            Text('Altura: ${pokemon.height} dm'),
                            Text('Peso: ${pokemon.weight} hg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
