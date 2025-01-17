import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/personaje.dart';

class listadoApp extends StatefulWidget {
  const listadoApp({super.key});

  @override
  State<listadoApp> createState() => _listadoAppState();
}

class _listadoAppState extends State<listadoApp> {

  late List<String> personajes;
  late int counter;

  @override
  void initState()
  {
    personajes = [];
    counter = 0;
    listadoPersonajes();
    super.initState();
  }

  void listadoPersonajes() async {
    while (counter < 100) {
      counter++;
      final url = Uri.parse("https://www.anapioficeandfire.com/api/characters/$counter");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = response.body;
        Personaje personaje = Personaje.fromJson(jsonDecode(json));
        if (personaje.name.isEmpty) {
          personajes.add("Personaje $counter");
        }
        else {
          personajes.add(personaje.name);
        }

      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: personajes.length,
        itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 50,
          child: Center(child: 
          Text(
            personajes[index],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black
            ),
            ),
            ),
         );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
  }
}
