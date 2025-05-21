class Pokemon {
  final String name;
  final String url;
  final int id;
  final String imageUrl;
  final double height;
  final double weight;
  final String type;

  Pokemon({
    required this.name,
    required this.url,
    required this.id,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.type,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] ?? 'Unknown',
      url: json['url'] ?? '',
      id: json['id'] ?? 0,
      imageUrl: json['sprites']?['front_default'] ?? '',
      height: json['height']?.toDouble() ?? 0.0,
      weight: json['weight']?.toDouble() ?? 0.0,
      type: json['types']?[0]['type']['name'] ?? 'Unknown',
    );
  }
}