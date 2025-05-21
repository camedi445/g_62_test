// lib/features/mock_screens/presentation/views/mock_screen.dart
import 'package:flutter/material.dart';

class MockScreen extends StatelessWidget {
  final String title;

  const MockScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            title.contains('1') ? Icons.apps : Icons.videogame_asset,
            size: 100,
            color: title.contains('1') ? Colors.red : Colors.blue,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Pantalla hecha para el quiz.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}