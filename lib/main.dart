import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const NavigationController(),
    );
  }
}

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _currentIndex = 0;

  final _screens = [
    const HomeScreen(),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.construction, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Pantalla en construcción',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.construction, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Pantalla en construcción',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon App')),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.catching_pokemon), label: 'Pokémon'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Pantalla 2'),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: 'Pantalla 3'),
        ],
      ),
    );
  }
}
