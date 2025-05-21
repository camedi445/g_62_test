import 'package:flutter/material.dart';

class MockScreenX extends StatelessWidget {
  const MockScreenX({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.catching_pokemon, size: 100, color: Colors.red),
          SizedBox(height: 20),
          Text(
            'Pantalla 2 - Mock X',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
