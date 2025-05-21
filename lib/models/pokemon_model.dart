class Pokemon {
  final String name;
  final String url;
  final int? id;
  final String? imageUrl;
  final int? height;
  final int? weight;
  final List<String>? types;

  Pokemon({
    required this.name,
    required this.url,
    this.id,
    this.imageUrl,
    this.height,
    this.weight,
    this.types,
  });

  factory Pokemon.fromListJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }

  factory Pokemon.fromDetailJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: '',
      id: json['id'],
      imageUrl: json['sprites']['front_default'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
    );
  }

  Pokemon copyWith({
    int? id,
    String? imageUrl,
    int? height,
    int? weight,
    List<String>? types,
  }) {
    return Pokemon(
      name: this.name,
      url: this.url,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      types: types ?? this.types,
    );
  }
}
