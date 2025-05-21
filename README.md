# 🚀 Aplicación Pokémon - Refactorizada con MVC y Riverpod

Este proyecto es una refactorización de una aplicación Flutter para gestionar Pokémon, transformando un código inicial con "malas prácticas" en una arquitectura limpia y modular.

## ✨ Características Principales

* **Listado de Pokémon**: Muestra Pokémon obtenidos de la PokeAPI.
* **Detalles del Pokémon**: Permite ver información detallada de cada Pokémon.
* **Navegación Simple**: Incluye una barra de navegación inferior.

## 📁 Estructura del Proyecto

La aplicación sigue el patrón Modelo-Vista-Controlador (MVC) y está organizada en las siguientes carpetas para una clara separación de responsabilidades:

* **`lib/main.dart`**: Punto de entrada de la aplicación, envuelto en `ProviderScope` de Riverpod.
* **`models/`**: Contiene `pokemon.dart`, que define la estructura de datos del Pokémon. Incluye un constructor `factory` para parsear JSON (con o sin detalles) y un método `copyWith` para crear nuevas instancias inmutables.
* **`repositories/`**: Contiene `pokemon_repository.dart`, encargado de la lógica para obtener datos de la PokeAPI. Esto asegura que la fuente de datos pueda cambiarse fácilmente sin afectar otras partes de la app.
* **`providers/`**: Aquí se gestiona el estado de la aplicación usando Riverpod. Contiene:
    * Un `Provider` para el `PokemonRepository`.
    * Un `StateNotifierProvider` con un `PokemonNotifier` que maneja la carga, el estado (cargando, con datos, error) y la lógica para obtener la lista de Pokémon y sus detalles (actualmente de forma secuencial).
    * Un `StateProvider` para gestionar el índice de la navegación inferior.
* **`views/`**: Contiene los componentes de la interfaz de usuario. La `home_page.dart` es la vista principal, desacoplada y observando los `providers`. El widget `pokemon_list_item.dart` está separado para mostrar cada Pokémon en la lista.

## 🚀 Cómo Ejecutar la Aplicación

1.  Clona este repositorio a tu máquina local.
2.  Navega a la carpeta del proyecto en tu terminal.
3.  Ejecuta `flutter pub get` para instalar las dependencias.
4.  Ejecuta `flutter run` para iniciar la aplicación.
