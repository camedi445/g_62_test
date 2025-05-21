// lib/features/pokemon_list/data/models/pokemon_model.dart

// Clase que representa un Pokémon en la lista (nombre y URL para obtener detalles)
class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  // Constructor de fábrica para crear una instancia de Pokemon desde un mapa JSON
  // Se usa para mapear los elementos de la lista de resultados de la API
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}

// Clase que representa los detalles completos de un Pokémon
// Incluye altura, peso, habilidades, tipos, sprites (imágenes) y el ID
class PokemonDetail {
  final String name;
  final int height; // Altura en decímetros
  final int weight; // Peso en hectogramos
  final List<Ability> abilities;
  final List<Type> types;
  final Sprites sprites;
  final int id; // ID único del Pokémon

  PokemonDetail({
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
    required this.sprites,
    required this.id,
  });

  // Constructor de fábrica para crear una instancia de PokemonDetail desde un mapa JSON
  // Se usa para mapear la respuesta de la API cuando se piden los detalles de un Pokémon específico
  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      id: json['id'],
      // Mapea la lista de habilidades del JSON a una lista de objetos Ability
      abilities: (json['abilities'] as List)
          .map((e) => Ability.fromJson(e as Map<String, dynamic>))
          .toList(),
      // Mapea la lista de tipos del JSON a una lista de objetos Type
      types: (json['types'] as List)
          .map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
      // Crea una instancia de Sprites desde la sub-estructura 'sprites' del JSON
      sprites: Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
    );
  }
}

// Clase para representar una habilidad de Pokémon
// Contiene el nombre y la URL de la habilidad
class Ability {
  final String name;
  final String url;

  Ability({required this.name, required this.url});

  // Constructor de fábrica para crear una instancia de Ability desde un mapa JSON
  // Nota: la estructura de la API es { "ability": { "name": "...", "url": "..." } }
  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['ability']['name'],
      url: json['ability']['url'],
    );
  }
}

// Clase para representar un tipo de Pokémon
// Contiene el nombre y la URL del tipo
class Type {
  final String name;
  final String url;

  Type({required this.name, required this.url});

  // Constructor de fábrica para crear una instancia de Type desde un mapa JSON
  // Nota: la estructura de la API es { "type": { "name": "...", "url": "..." } }
  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['type']['name'],
      url: json['type']['url'],
    );
  }
}

// Clase para representar las URLs de las imágenes (sprites) de Pokémon
// Contiene la URL de la imagen frontal por defecto y opcionalmente la trasera
class Sprites {
  final String frontDefault;
  final String? backDefault; // backDefault puede ser nulo en la API

  Sprites({required this.frontDefault, this.backDefault});

  // Constructor de fábrica para crear una instancia de Sprites desde un mapa JSON
  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      // Proporciona una cadena vacía si 'front_default' es nulo para evitar errores
      frontDefault: json['front_default'] ?? '',
      // 'back_default' puede ser nulo, por lo que se mantiene como String?
      backDefault: json['back_default'],
    );
  }
}
