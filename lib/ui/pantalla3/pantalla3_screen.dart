import 'package:flutter/material.dart';

class Pantalla3Screen extends StatelessWidget {
  const Pantalla3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videogame_asset, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Pantalla 3 - También vacía',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
