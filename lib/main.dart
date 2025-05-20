import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Variables globales (mala práctica)
List<dynamic> pokemonList = [];
int currentIndex = 0;
bool isLoading = true;

void main() {
  runApp(MainApp());
}

// No usar const (mala práctica)
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, // Dejar el banner de debug
      title: 'Pokemon App Con Malas Prácticas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// StatefulWidget innecesariamente complejo
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Método exageradamente largo y mal estructurado
  @override
  void initState() {
    super.initState();
    // Llamada directa a la API en el initState (mala práctica)
    fetchPokemonData();
  }

  // Método que hace de todo (mala práctica: responsabilidad única violada)
  void fetchPokemonData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Modificando variable global directamente
        pokemonList = data['results'];

        // Obtener detalles de cada pokemon (manera ineficiente)
        for (int i = 0; i < pokemonList.length; i++) {
          final detailResponse = await http.get(
            Uri.parse(pokemonList[i]['url']),
          );
          if (detailResponse.statusCode == 200) {
            final detailData = json.decode(detailResponse.body);
            pokemonList[i]['detail'] = detailData;
          }
        }

        setState(() {
          isLoading = false;
        });
      } else {
        print('Error al cargar datos: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Excepción al cargar datos: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista de widgets para las diferentes pantallas (todo junto y acoplado)
    List<Widget> _screens = [
      // Primera pantalla: Lista de Pokemon
      isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              final detail = pokemon['detail'];

              return GestureDetector(
                onTap: () {
                  // Mostrar detalles en un diálogo (mala práctica)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(pokemon['name'].toString().toUpperCase()),
                        content: Container(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              detail != null
                                  ? Image.network(
                                    detail['sprites']['front_default'],
                                    height: 200,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.error),
                                  )
                                  : Container(),
                              SizedBox(height: 10),
                              Text(
                                'Altura: ${detail != null ? detail['height'] : '?'} dm',
                              ),
                              Text(
                                'Peso: ${detail != null ? detail['weight'] : '?'} hg',
                              ),
                              Text(
                                'Tipo: ${detail != null ? detail['types'][0]['type']['name'] : '?'}',
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        detail != null && detail['sprites'] != null
                            ? Image.network(
                              detail['sprites']['front_default'],
                              height: 100,
                              width: 100,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.error),
                                  ),
                            )
                            : Container(
                              height: 100,
                              width: 100,
                              color: Colors.grey[300],
                              child: CircularProgressIndicator(),
                            ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${pokemon['name']}'.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              if (detail != null) ...[
                                SizedBox(height: 8),
                                Text('ID: #${detail['id']}'),
                                Text(
                                  'Tipo: ${detail['types'][0]['type']['name']}',
                                ),
                                Text('Altura: ${detail['height']} dm'),
                                Text('Peso: ${detail['weight']} hg'),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

      // Segunda pantalla (vacía con solo un texto)
      Center(
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
      ),

      // Tercera pantalla (vacía con solo un texto)
      Center(
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
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon App Con Malas Prácticas'),
        // No extraer widgets ni usar métodos para simplificar (mala práctica)
        actions: [
          if (currentIndex == 0)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                fetchPokemonData(); // Llamar directamente al método
              },
            ),
        ],
      ),
      // Usar el índice global en lugar de un estado local
      body: _screens[currentIndex],
      // Bottom Navigation Bar sin extraer en un widget separado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // Modificar directamente la variable global
          setState(() {
            currentIndex = index;
          });
        },
        items: [
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
      floatingActionButton:
          currentIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  // Mala práctica: no usar métodos separados
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '¡Esta es una aplicación con malas prácticas!',
                      ),
                    ),
                  );
                },
                child: Icon(Icons.info),
              )
              : null,
    );
  }
}
