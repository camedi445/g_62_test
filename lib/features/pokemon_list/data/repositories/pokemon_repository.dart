// lib/features/pokemon_list/data/repositories/pokemon_repository.dart
import 'dart:convert'; // Necesario para json.decode
import 'package:http/http.dart' as http; // Para realizar las peticiones HTTP
import 'package:riverpod/riverpod.dart'; // Para definir el provider del repositorio

// Importa los modelos de datos que acabamos de crear
import 'package:pokemon_app/features/pokemon_list/data/models/pokemon_model.dart';

// URL base de la API de Pokémon
const String _pokeApiBaseUrl = 'https://pokeapi.co/api/v2';

// 1. Interfaz (Contrato) del Repositorio
// Define los métodos que cualquier implementación de PokemonRepository debe tener.
// Esto es una buena práctica para la inyección de dependencias y la testabilidad.
abstract class PokemonRepository {
  /// Obtiene una lista paginada de Pokémon.
  /// [limit]: El número máximo de Pokémon a retornar.
  /// [offset]: El número de Pokémon a saltar desde el inicio (para paginación).
  Future<List<Pokemon>> getPokemons({int limit = 20, int offset = 0});

  /// Obtiene los detalles completos de un Pokémon usando su URL específica.
  /// [url]: La URL completa proporcionada por la API para los detalles del Pokémon.
  Future<PokemonDetail> getPokemonDetail(String url);
}

// 2. Implementación Concreta del Repositorio
// Aquí es donde reside la lógica real para interactuar con la API de Pokémon.
class PokemonRepositoryImpl implements PokemonRepository {
  // Usamos un cliente HTTP para facilitar la inyección de dependencias y las pruebas.
  final http.Client _client;

  PokemonRepositoryImpl({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<Pokemon>> getPokemons({int limit = 20, int offset = 0}) async {
    final uri = Uri.parse('$_pokeApiBaseUrl/pokemon?limit=$limit&offset=$offset');
    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        // Mapea cada elemento de la lista 'results' del JSON a un objeto Pokemon.
        return results.map((json) => Pokemon.fromJson(json)).toList();
      } else {
        // Si la respuesta no es 200 OK, lanzamos una excepción con el código de estado.
        throw Exception('Failed to load pokemons with status: ${response.statusCode}');
      }
    } catch (e) {
      // Capturamos cualquier error durante la petición o el parsing.
      throw Exception('Error fetching pokemons: $e');
    }
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String url) async {
    final uri = Uri.parse(url);
    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Mapea la respuesta JSON completa a un objeto PokemonDetail.
        return PokemonDetail.fromJson(data);
      } else {
        // Si la respuesta no es 200 OK, lanzamos una excepción con el código de estado.
        throw Exception('Failed to load pokemon detail with status: ${response.statusCode}');
      }
    } catch (e) {
      // Capturamos cualquier error durante la petición o el parsing.
      throw Exception('Error fetching pokemon detail: $e');
    }
  }
}

// 3. Provider de Riverpod para el Repositorio
// Este provider hace que la instancia de PokemonRepositoryImpl esté disponible
// para cualquier parte de la aplicación que la necesite, facilitando la inyección
// de dependencias y la testabilidad.
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(); // Retorna la implementación concreta del repositorio.
});