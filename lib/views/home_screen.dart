import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pokemon_provider.dart';
import 'widgets/pokemon_tile.dart';
import 'widgets/pokemon_detail_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonProvider);

    return pokemonAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (list) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index) {
          final pokemon = list[index];

          return PokemonTile(
            pokemon: pokemon,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 12,
                  backgroundColor: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PokemonDetailDialog(pokemon: pokemon),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}