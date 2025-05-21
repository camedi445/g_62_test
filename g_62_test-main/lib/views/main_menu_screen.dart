import 'package:flutter/material.dart';
import 'package:g_62_test/views/home/home_screen.dart';
import 'package:g_62_test/views/mock_screen_x.dart';
import 'package:g_62_test/views/mock_screen_y.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('Home: Lista de Pokémon'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MockScreenX()),
                );
              },
              child: const Text('Mock: Pantalla X'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MockScreenY()),
                );
              },
              child: const Text('Mock: Pantalla Y'),
            ),
          ],
        ),
      ),
    );
  }
}