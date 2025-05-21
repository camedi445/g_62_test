# Pokémon App Mejorada

## Descripción

Esta aplicación consume la API pública de Pokémon para mostrar una lista de personajes con sus detalles. Se ha refactorizado el código original para aplicar buenas prácticas de desarrollo, mejorar la escalabilidad y la mantenibilidad.

---

## Mejoras realizadas

### 1. Implementación del patrón MVC

- **Modelo:** Se creó una clase `Pokemon` para representar la estructura de los datos obtenidos de la API.
- **Controlador:** Se creó `PokemonController` para gestionar la lógica de negocio y las llamadas a la API.
- **Vista:** La interfaz de usuario está claramente separada en pantallas y widgets reutilizables.

### 2. Uso de Riverpod para la gestión del estado

- Se utiliza `flutter_riverpod` para gestionar el estado de la aplicación de forma reactiva y eficiente.
- La obtención de datos se maneja mediante un `FutureProvider`, mejorando la separación de responsabilidades y facilitando la prueba y mantenimiento.

### 3. Mejora en la experiencia de usuario

- La lista de Pokémon se muestra con tarjetas personalizadas (`PokemonTile`) que mejoran la estética y usabilidad.
- El detalle de cada Pokémon se presenta en un diálogo modal centrado, con diseño moderno y estilizado.
- Se añadieron degradados, sombras y colores contrastantes para mejorar la visualización y accesibilidad.

### 4. Limpieza y organización del código

- Se eliminaron variables globales y se evitaron malas prácticas como el uso de métodos muy largos o llamados directos a la API en el estado de la UI.
- El código está modularizado en carpetas claras (`models`, `controllers`, `providers`, `views/widgets`) para facilitar su escalabilidad.
- Se aplicaron estilos consistentes en toda la aplicación para una mejor apariencia visual.

### 5. Manejo adecuado de pantallas en construcción

- Las pestañas sin funcionalidad están indicadas con mensajes claros de “Pantalla en construcción” para mejorar la comunicación con el usuario.

---

## Tecnologías y librerías

- Flutter SDK
- Flutter Riverpod
- HTTP para consumo de API REST

---

## Cómo ejecutar

1. Clonar el repositorio.
2. Ejecutar `flutter pub get` para instalar dependencias.
3. Ejecutar `flutter run` para iniciar la aplicación en un emulador o dispositivo físico.

---