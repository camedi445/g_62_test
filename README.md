# Taller Práctico Flutter - Pokemon

## Descripción

En este repositorio encontrarás una solución que tiene un menú principal con 3 opciones:

1. **Home**: Contiene una lista de personajes de Pokemon con vista detalle.
2. **Mock**: Pantalla X.
3. **Mock**: Pantalla X.

La funcionalidad principal está en la primera opción, donde se implementa una vista de lista-detalle que consume la API pública de Pokemon.

## Objetivo del Taller

Tu trabajo como experto en Flutter es aplicar las mejores prácticas de programación vistas en clase para convertir esta solución en una aplicación escalable y mantenible.

## Requisitos

Para lograr este objetivo es indispensable que utilices:

- **Riverpod** como gestor de estado
- El patrón arquitectónico **MVC** (Modelo-Vista-Controlador)
- Una clara separación de responsabilidades entre las diferentes clases

## Tiempo y Entrega

- Duración de la actividad: **2 horas**
- Proceso de entrega:
  1. Crear un Fork del proyect en tú cuenta de Github.
  2. Crear una rama con tu solución.
  3. A partir de esta rama, crear un Pull Request a la rama principal
  4. Incluir en el README una explicación detallada de los aspectos que mejoraste en la aplicación

## Criterios de Evaluación

Se valorará especialmente:

- La correcta implementación del patrón MVC
- El uso adecuado de Riverpod para la gestión del estado
- La separación de responsabilidades entre clases
- La claridad y mantenibilidad del código resultante

## SOLUCION:
-se implementa riverpod, se crea un provider para el control de estados.
-Se modifica estructura para hacer uso de patron MVC donde cada uno de los archivos es responsable de una funcion especifica 
-Se genera servicio para poder realizar un llamado a la API
-Se consume servicio por medio del controlador y se muestra en las vistas