import 'package:flutter/material.dart';
import '/mock/screen_three.dart';
import '/mock/screen_two.dart';
import '../pokemon/pokemon_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    PokemonListView(),
    ScreenTwo(),
    ScreenThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon App MVC + Riverpod'),
        actions: currentIndex == 0
            ? [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {

                  },
                )
              ]
            : null,
      ),
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon), label: 'Pokémon'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Pantalla 2'),
          BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset), label: 'Pantalla 3'),
        ],
      ),
    );
  }
}
