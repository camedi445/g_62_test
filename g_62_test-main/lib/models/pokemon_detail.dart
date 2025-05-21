class PokemonDetail {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
  });

  
  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return PokemonDetail(
      id: id,
      name: json['name'],
      
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      height: json['height'],
      weight: json['weight'],
      
      types: (json['types'] as List)
          .map((typeJson) => typeJson['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((abilityJson) => abilityJson['ability']['name'] as String)
          .toList(),
    );
  }
}
