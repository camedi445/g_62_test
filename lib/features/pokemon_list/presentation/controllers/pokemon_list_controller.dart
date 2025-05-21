// lib/features/pokemon_list/presentation/controllers/pokemon_list_controller.dart
import 'package:riverpod/riverpod.dart'; // Importa Riverpod
import 'package:pokemon_app/features/pokemon_list/data/models/pokemon_model.dart'; // Importa tus modelos
import 'package:pokemon_app/features/pokemon_list/data/repositories/pokemon_repository.dart'; // Importa el repositorio

// Este es nuestro "Controlador" para la lista de Pokémon.
// Extiende AsyncNotifier porque la carga de datos es asíncrona y el estado
// puede ser loading, data o error. El tipo de estado que maneja es List<Pokemon>.
class PokemonListNotifier extends AsyncNotifier<List<Pokemon>> {
  // El método `build` se llama una vez cuando el provider es accedido por primera vez.
  // Aquí es donde realizamos la carga inicial de datos.
  @override
  Future<List<Pokemon>> build() async {
    // Usamos ref.read para obtener una instancia del PokemonRepository.
    // No usamos ref.watch aquí porque no queremos que el notifier se reconstruya
    // si el provider del repositorio cambia (lo cual es raro).
    final repository = ref.read(pokemonRepositoryProvider);
    try {
      // Llama al método del repositorio para obtener la lista de Pokémon.
      return await repository.getPokemons(limit: 50); // Puedes ajustar el límite
    } catch (e) {
      // Si hay un error, lo lanzamos para que AsyncValue.error lo capture.
      throw Exception('Error cargando lista $e');
    }
  }

  // Método público para que la UI pueda solicitar un refresco de la lista.
  Future<void> refreshPokemons() async {
    // Establece el estado a loading mientras se recargan los datos.
    state = const AsyncValue.loading();
    // Usa AsyncValue.guard para manejar automáticamente los estados de éxito/error
    // de una operación asíncrona.
    state = await AsyncValue.guard(() => build());
  }
}

// Este es el Provider que exponemos a la UI.
// Permite que cualquier ConsumerWidget escuche los cambios en el estado de PokemonListNotifier.
final pokemonListControllerProvider =
    AsyncNotifierProvider<PokemonListNotifier, List<Pokemon>>(() {
  return PokemonListNotifier();
});

// -------------------------------------------------------------------------

// Controlador para el detalle de un Pokémon específico.
// También AsyncNotifier porque la carga del detalle es asíncrona.
// El tipo de estado que maneja es PokemonDetail? (puede ser nulo si no hay selección).
class PokemonDetailNotifier extends AsyncNotifier<PokemonDetail?> {
  // Este StateProvider auxiliar se usa para "inyectar" el URL del Pokémon
  // que queremos ver en detalle. Es como un "argumento" para este notifier.
  static final selectedPokemonUrlProvider = StateProvider<String?>((ref) => null);

  @override
  Future<PokemonDetail?> build() async {
    // Observa el selectedPokemonUrlProvider. Cuando su valor cambie,
    // este build() se ejecutará de nuevo para cargar el nuevo detalle.
    final pokemonUrl = ref.watch(selectedPokemonUrlProvider);

    if (pokemonUrl == null) {
      return null; // Si no hay URL seleccionada, no hay detalle.
    }

    final repository = ref.read(pokemonRepositoryProvider);
    try {
      // Carga los detalles usando la URL proporcionada.
      return await repository.getPokemonDetail(pokemonUrl);
    } catch (e) {
      throw Exception('Error obteniendo detalles del Pokemon: $e');
    }
  }

  // Método para limpiar el detalle cuando ya no es necesario (ej. al volver a la lista).
  void clearDetail() {
    state = const AsyncValue.data(null);
  }
}

// Provider para el controlador de detalle de Pokémon.
final pokemonDetailControllerProvider =
    AsyncNotifierProvider<PokemonDetailNotifier, PokemonDetail?>(() {
  return PokemonDetailNotifier();
});