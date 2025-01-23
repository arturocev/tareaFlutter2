class Personaje 
{
  final String name;
  final String gender;
  final String culture;
  final List<dynamic> aliases;

  const Personaje({required this.name, required this.gender, required this.culture, required this.aliases});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
        name: json['name'] as String, gender: json['gender'] as String, culture: json['culture'] as String, aliases: json['aliases'] as List<dynamic>);
  }
}