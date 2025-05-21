import 'package:flutter/material.dart';
import '../../models/pokemon.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonTile({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.indigo,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.indigo),
        onTap: onTap,
      ),
    );
  }
}