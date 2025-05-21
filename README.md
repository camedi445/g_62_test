🚀 Aplicación Pokémon - Refactorizada con MVC y Riverpod
Este proyecto es una refactorización de una aplicación Flutter simple para mostrar Pokémon. Se ha transformado de un código monolítico con "malas prácticas" a una arquitectura Modelo-Vista-Controlador (MVC) robusta, utilizando Riverpod para una gestión de estado eficiente y reactiva.

✨ Características Principales
Listado de Pokémon: Muestra una lista de Pokémon obtenidos de la PokeAPI.

Detalles del Pokémon: Al seleccionar un Pokémon, muestra sus detalles (imagen, altura, peso, tipo).

Navegación Inferior: Una barra de navegación simple con múltiples pantallas.

Arquitectura Limpia: Implementación de MVC para una mejor organización y mantenibilidad.

Gestión de Estado con Riverpod: Uso de Provider, StateProvider y StateNotifierProvider para un manejo de estado desacoplado y reactivo.

📁 Estructura del Proyecto
La aplicación sigue una estructura de carpetas modular para separar las responsabilidades de cada componente:

lib/
├── main.dart
├── models/             # 📝 Definición de la estructura de datos (Modelos)
│   └── pokemon.dart
├── providers/          # 💡 Gestión de estado y acceso a datos (Controladores/View Models con Riverpod)
│   └── pokemon_providers.dart
├── repositories/       # ⚙️ Lógica para obtener datos de fuentes externas (Repositorios)
│   └── pokemon_repository.dart
├── views/              # 📱 Componentes de la interfaz de usuario (Vistas)
│   ├── home_page.dart
│   ├── pokemon_detail_dialog.dart
│   └── widgets/
│       └── pokemon_list_item.dart

Esta organización mejora drásticamente la mantenibilidad, escalabilidad y facilidad de prueba del código, ya que cada parte tiene una responsabilidad única y bien definida.

📊 Componentes Principales
lib/main.dart
Este es el punto de entrada de la aplicación.

Envuelve toda la aplicación (MainApp) con ProviderScope.

ProviderScope: Es el widget fundamental de Riverpod. Actúa como el "cerebro" o el "contenedor" de todos los proveedores de la aplicación. Sin él, ningún proveedor de Riverpod funcionaría. Asegura que los proveedores sean accesibles en todo el árbol de widgets.

models/pokemon.dart
Aquí se define la "receta" o la estructura de los datos de un Pokémon.

Clase Pokemon:

Define las propiedades de un Pokémon (name, url, id, imageUrl, height, weight, type).

Todas las propiedades son final, lo que hace que los objetos Pokemon sean inmutables. Una vez creados, sus valores no pueden cambiarse directamente. Esto es una buena práctica para la gestión de estado, ya que cualquier "cambio" implica la creación de una nueva instancia.

Las propiedades con ? (ej. int? id) son anulables, lo que significa que pueden contener un valor o ser null. Esto es útil porque la API de Pokémon no siempre proporciona todos los detalles en la primera llamada.

factory Pokemon.fromJson(Map<String, dynamic> json):

Es un constructor de fábrica especial. No siempre crea una nueva instancia, sino que decide cómo construir el objeto basándose en la lógica interna.

Está diseñado para parsear (convertir) datos JSON (recibidos de la API) en un objeto Pokemon fuertemente tipado.

Contiene lógica condicional (if (json.containsKey('url') && json.containsKey('name'))) para manejar dos tipos de respuestas de la PokeAPI:

Si el JSON es de la lista inicial (solo name y url), crea un Pokemon básico.

Si el JSON es de los detalles de un Pokémon (contiene id, sprites, height, etc.), crea un Pokemon completo con todos sus detalles, extrayendo los datos de las estructuras anidadas del JSON (ej. json['sprites']['front_default']).

Pokemon copyWith({...}):

Es un método que permite crear una nueva instancia de Pokemon a partir de una existente, pero con algunas propiedades modificadas.

Dado que los objetos Pokemon son inmutables (final), no puedes cambiar pokemon.id = 123;. En su lugar, usas pokemon.copyWith(id: 123); para obtener una nueva instancia con el ID actualizado y el resto de propiedades sin cambios.

Utiliza el operador ?? (null-aware coalescing) para que, si no se proporciona un nuevo valor para una propiedad en copyWith, se use el valor existente del objeto original (id ?? this.id).

repositories/pokemon_repository.dart
Este es el "encargado de compras" o la "despensa" de la aplicación.

Clase PokemonRepository:

Contiene la lógica para realizar las llamadas HTTP a la PokeAPI.

fetchPokemonList(): Obtiene la lista inicial de nombres y URLs de Pokémon.

fetchPokemonDetails(String url): Obtiene los detalles completos de un Pokémon específico usando su URL.

Principio de Responsabilidad Única: Su única responsabilidad es saber cómo obtener los datos. No le importa cómo se muestran esos datos en la UI ni cómo se gestiona el estado de la aplicación. Esto lo hace muy flexible: si en el futuro cambias la fuente de datos (ej. de la PokeAPI a una base de datos local), solo tendrías que modificar este archivo, sin afectar el resto de la aplicación.

providers/pokemon_providers.dart
¡Aquí es donde Riverpod gestiona el estado y la lógica de negocio! Este archivo es el "centro de control" o el "cerebro de estado" de tu aplicación.

final pokemonRepositoryProvider = Provider((ref) => PokemonRepository());:

Provider: Es el tipo de proveedor más básico de Riverpod. Se usa para proporcionar un valor que no cambia o cambia muy raramente.

En este caso, proporciona una instancia de PokemonRepository.

Cuando cualquier parte de la aplicación necesita un PokemonRepository, lo "pide" a este proveedor, asegurando que siempre se use la misma instancia (un "singleton" gestionado por Riverpod). Esto facilita la inyección de dependencias y las pruebas.

class PokemonNotifier extends StateNotifier<AsyncValue<List<Pokemon>>>:

StateNotifier: Es una clase de Riverpod diseñada para manejar estados complejos que cambian con el tiempo y contienen lógica de negocio.

<AsyncValue<List<Pokemon>>>: Define el tipo de estado que PokemonNotifier va a gestionar.

AsyncValue: Es una utilidad poderosa de Riverpod para representar el resultado de operaciones asíncronas (como llamadas a la API). Puede estar en tres estados:

AsyncValue.loading(): La operación está en curso (mostrando un indicador de carga).

AsyncValue.data(value): La operación se completó con éxito y value es el resultado (aquí, la List<Pokemon>).

AsyncValue.error(error, stackTrace): La operación falló (mostrando un mensaje de error).

Al usar AsyncValue, la UI puede reaccionar fácilmente a estos diferentes estados sin lógica condicional manual compleja.

PokemonNotifier(this._repository) : super(const AsyncValue.loading()):

El constructor recibe una instancia de PokemonRepository (_repository). Esto es inyección de dependencias: el Notifier no crea su propio repositorio, sino que se le "da" uno.

: super(const AsyncValue.loading()): Inicializa el estado base de StateNotifier a loading. Así, la UI muestra un cargador desde el principio.

fetchPokemons(): Se llama inmediatamente en el constructor para iniciar la carga de datos tan pronto como el Notifier es creado.

Future<void> fetchPokemons() async { ... }:

Este método contiene la lógica de negocio para obtener la lista completa de Pokémon.

Primero, establece el state a AsyncValue.loading().

Llama a _repository.fetchPokemonList() para obtener los nombres y URLs iniciales.

Luego, itera sobre cada Pokémon para llamar a _repository.fetchPokemonDetails(pokemon.url) y obtener sus detalles completos.

Nota: En la versión inicial, esto se hacía en paralelo con Future.wait para mayor eficiencia. Si lo modificaste para que sea secuencial (con un bucle for simple y await dentro), la lógica espera por cada detalle antes de pasar al siguiente.

Después de obtener todos los detalles, actualiza el state a AsyncValue.data(detailedPokemons).

Si ocurre algún error en el proceso, actualiza el state a AsyncValue.error(e, st).

final pokemonListProvider = StateNotifierProvider<PokemonNotifier, AsyncValue<List<Pokemon>>>((ref) { ... });:

StateNotifierProvider: Es el proveedor que expone nuestro PokemonNotifier y su estado (AsyncValue<List<Pokemon>>) al resto de la aplicación.

Cuando un widget "observa" (ref.watch()) este proveedor, obtiene el estado actual del PokemonNotifier y se reconstruye automáticamente cada vez que el estado cambia.

return PokemonNotifier(ref.watch(pokemonRepositoryProvider));: Aquí es donde PokemonNotifier obtiene su dependencia (PokemonRepository) de otro proveedor de Riverpod. ref.watch() asegura que si pokemonRepositoryProvider cambiara (lo cual no sucede en este caso, pero es un buen patrón), el PokemonNotifier se reconstruiría.

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);:

StateProvider: Es un proveedor más simple que StateNotifierProvider. Se usa para gestionar estados simples que pueden cambiar (como un int, bool, String).

En este caso, gestiona el índice de la barra de navegación inferior.

ref.read(bottomNavIndexProvider.notifier).state = index; se usa para actualizar su valor.

views/
Aquí se encuentran los componentes de la interfaz de usuario. Su principal responsabilidad es mostrar la información y enviar las interacciones del usuario a los proveedores/controladores. No contienen lógica de negocio compleja ni llamadas directas a la API.

home_page.dart:

Es la pantalla principal de la aplicación.

Extiende ConsumerWidget (de Riverpod) para poder "observar" (ref.watch()) los proveedores (bottomNavIndexProvider y pokemonListProvider).

La UI se construye reactivamente en función del estado de pokemonListProvider (loading, data, error).

Las acciones del usuario (ej. botón de refrescar, tap en un ítem de la lista) se delegan a los métodos de los StateNotifier o a la navegación.

pokemon_detail_dialog.dart:

Un StatelessWidget que muestra los detalles de un Pokemon específico en un diálogo.

Recibe un objeto Pokemon completo como parámetro.

widgets/pokemon_list_item.dart:

Un StatelessWidget reutilizable que representa un solo elemento en la lista de Pokémon.

Recibe un objeto Pokemon y una función onTap como parámetros.

🚀 Cómo Ejecutar la Aplicación
Clona este repositorio a tu máquina local.

git clone <URL_DE_TU_FORK>
cd <nombre_de_tu_proyecto>

Instala las dependencias de Flutter y Riverpod:

flutter pub get

Ejecuta la aplicación:

flutter run
