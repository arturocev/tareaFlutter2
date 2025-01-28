class Personaje 
{
  final String name;
  final String gender;
  final String culture;
  final List<dynamic> aliases;
  final String born;
  final String died;
  final List<dynamic> titles;
  static int idPersonaje = 1;

  const Personaje({required this.name, required this.gender, required this.culture, required this.aliases, required this.born, required this.died, required this.titles});


  // Este método permite crear una instancia de Personaje a partir de un objeto JSON. Extrae los valores de las claves correspondientes del mapa JSON
  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
        name: json['name'] as String, gender: json['gender'] as String, culture: json['culture'] as String, aliases: json['aliases'] as List<dynamic>, born: json['born'], died: json['died'], titles: json['titles'] as List<dynamic>);
  }
}