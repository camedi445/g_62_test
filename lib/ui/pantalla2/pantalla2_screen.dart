import 'package:flutter/material.dart';

class Pantalla2Screen extends StatelessWidget {
  const Pantalla2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.catching_pokemon, size: 100, color: Colors.red),
          SizedBox(height: 20),
          Text(
            'Pantalla 2 - Vacía',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
