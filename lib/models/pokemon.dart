class Pokemon {
  final String name;
  final String url;
  final int? id;
  final String? imageUrl;
  final int? height;
  final int? weight;
  final String? type;

  Pokemon({
    required this.name,
    required this.url,
    this.id,
    this.imageUrl,
    this.height,
    this.weight,
    this.type,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('url') && json.containsKey('name')) {
      return Pokemon(name: json['name'], url: json['url']);
    }
    return Pokemon(
      name: json['name'],
      url: '',
      id: json['id'],
      imageUrl: json['sprites']['front_default'],
      height: json['height'],
      weight: json['weight'],
      type: json['types'].isNotEmpty ? json['types'][0]['type']['name'] : null,
    );
  }

  Pokemon copyWith({
    int? id,
    String? imageUrl,
    int? height,
    int? weight,
    String? type,
  }) {
    return Pokemon(
      name: name,
      url: url,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      type: type ?? this.type,
    );
  }
}
