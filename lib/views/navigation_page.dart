import 'package:flutter/material.dart';
import 'home_page.dart';
import 'screen_two.dart';
import 'screen_three.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;

  final screens = const [HomePage(), ScreenTwo(), ScreenThree()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon App Arreglado')),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokémon',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Pantalla 2'),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Pantalla 3',
          ),
        ],
      ),
    );
  }
}
