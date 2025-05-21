import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class DetailScreen extends StatefulWidget {
  final Pokemon pokemon;

  const DetailScreen({super.key, required this.pokemon});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic>? detail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPokemonDetail();
  }

  Future<void> fetchPokemonDetail() async {
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemon.name.toUpperCase())),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : detail == null
              ? const Center(child: Text('No se pudo cargar la información'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (detail!['sprites'] != null)
                        Image.network(
                          detail!['sprites']['front_default'],
                          height: 200,
                          errorBuilder: (_, __, ___) => const Icon(Icons.error),
                        ),
                      const SizedBox(height: 16),
                      Text('ID: #${detail!['id']}'),
                      Text('Tipo: ${detail!['types'][0]['type']['name']}'),
                      Text('Altura: ${detail!['height']} dm'),
                      Text('Peso: ${detail!['weight']} hg'),
                    ],
                  ),
                ),
    );
  }
}