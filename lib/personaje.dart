class Personaje 
{
  final String name;
  final String gender;
  final String culture;
  final List<dynamic> aliases;
  final String born;
  final String died;
  final List<dynamic> titles;

  const Personaje({required this.name, required this.gender, required this.culture, required this.aliases, required this.born, required this.died, required this.titles});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
        name: json['name'] as String, gender: json['gender'] as String, culture: json['culture'] as String, aliases: json['aliases'] as List<dynamic>, born: json['born'], died: json['died'], titles: json['titles'] as List<dynamic>);
  }
}