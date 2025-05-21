class Pokemon {
  final String name;
  final String url;
  final int? id;
  final int? height;
  final int? weight;
  final String? image;
  final String? type;

  Pokemon({
    required this.name,
    required this.url,
    this.id,
    this.height,
    this.weight,
    this.image,
    this.type,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }

  Pokemon copyWithDetail(Map<String, dynamic> detail) {
    return Pokemon(
      name: name,
      url: url,
      id: detail['id'],
      height: detail['height'],
      weight: detail['weight'],
      image: detail['sprites']['front_default'],
      type: detail['types'][0]['type']['name'],
    );
  }
}
