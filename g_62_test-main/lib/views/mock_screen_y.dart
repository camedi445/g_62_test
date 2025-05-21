import 'package:flutter/material.dart';

class MockScreenY extends StatelessWidget {
  const MockScreenY({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videogame_asset, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Pantalla 3 - Mock Y',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}