import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/pokemon.dart';

class PokemonDetailDialog extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailDialog({super.key, required this.pokemon});

  @override
  State<PokemonDetailDialog> createState() => _PokemonDetailDialogState();
}

class _PokemonDetailDialogState extends State<PokemonDetailDialog> {
  Map<String, dynamic>? detail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    final response = await http.get(Uri.parse(widget.pokemon.url));
    if (response.statusCode == 200) {
      setState(() {
        detail = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.indigo.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      detail!['sprites']['front_default'],
                      height: 160,
                      width: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.error, size: 80),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.pokemon.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'ID: #${detail!['id']}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  'Tipo: ${detail!['types'][0]['type']['name']}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  'Altura: ${detail!['height']} dm',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  'Peso: ${detail!['weight']} hg',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
  }
}
