class Personaje 
{
  final String name;
  final String gender;

  const Personaje({required this.name, required this.gender});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
        name: json['name'] as String, gender: json['gender'] as String);
  }
}