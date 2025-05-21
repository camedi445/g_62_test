// lib/features/pokemon_list/presentation/controllers/pokemon_detail_controller.dart
import 'package:riverpod/riverpod.dart'; // Importa Riverpod
import 'package:pokemon_app/features/pokemon_list/data/models/pokemon_model.dart'; // Importa tus modelos
import 'package:pokemon_app/features/pokemon_list/data/repositories/pokemon_repository.dart'; // Importa el repositorio

// Controlador para el detalle de un Pokémon específico.
// Extiende AsyncNotifier porque la carga del detalle es asíncrona y el estado
// puede ser loading, data o error. El tipo de estado que maneja es PokemonDetail?
// (puede ser nulo si no hay selección o si el detalle se ha limpiado).
class PokemonDetailNotifier extends AsyncNotifier<PokemonDetail?> {
  // Este StateProvider auxiliar se usa para "inyectar" el URL del Pokémon
  // que queremos ver en detalle. Es como un "argumento" para este notifier.
  // Cuando este provider cambia, el build() de PokemonDetailNotifier se re-ejecuta.
  static final selectedPokemonUrlProvider = StateProvider<String?>((ref) => null);

  // El método `build` se llama una vez cuando el provider es accedido por primera vez,
  // y cada vez que sus dependencias (como selectedPokemonUrlProvider) cambian.
  @override
  Future<PokemonDetail?> build() async {
    // Observa el selectedPokemonUrlProvider. Si su valor cambia, este build()
    // se ejecutará de nuevo para cargar el nuevo detalle.
    final pokemonUrl = ref.watch(selectedPokemonUrlProvider);

    if (pokemonUrl == null) {
      // Si no hay URL seleccionada (ej. al volver a la lista), no hay detalle para cargar.
      return null;
    }

    // Obtiene una instancia del PokemonRepository.
    final repository = ref.read(pokemonRepositoryProvider);
    try {
      // Llama al método del repositorio para obtener los detalles del Pokémon
      // usando la URL proporcionada.
      return await repository.getPokemonDetail(pokemonUrl);
    } catch (e) {
      // Si hay un error, lo lanzamos para que AsyncValue.error lo capture
      // y la UI pueda mostrar un mensaje de error.
      throw Exception('Failed to load Pokemon detail: $e');
    }
  }

  // Método público para que la UI pueda solicitar limpiar el detalle actual.
  // Esto es útil al navegar de vuelta a la lista para evitar mostrar un detalle obsoleto.
  void clearDetail() {
    // Establece el estado a AsyncValue.data(null) para indicar que no hay detalle seleccionado.
    state = const AsyncValue.data(null);
    // También es buena práctica resetear el provider que guarda la URL seleccionada.
    ref.read(selectedPokemonUrlProvider.notifier).state = null;
  }
}

// Este es el Provider que exponemos a la UI para el controlador de detalle de Pokémon.
// Permite que cualquier ConsumerWidget escuche los cambios en el estado de PokemonDetailNotifier.
final pokemonDetailControllerProvider =
    AsyncNotifierProvider<PokemonDetailNotifier, PokemonDetail?>(() {
  return PokemonDetailNotifier();
});
