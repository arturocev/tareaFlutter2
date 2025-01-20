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
  late List<Map<String,dynamic>> personajesMap;
  late int counterPersonaje;

  @override
  void initState()
  {
    personajes = [];
    personajesMap = [];
    counter = 0;
    counterPersonaje = 0;
    listadoPersonajes();
    super.initState();
  }

  void listadoPersonajes() async {
      counter++;
      while (counterPersonaje <= personajesMap.length)
      {
        final url = Uri.parse("https://www.anapioficeandfire.com/api/characters?page=$counter&pageSize=10");
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final json = response.body;
          personajesMap = List<Map<String, dynamic>>.from(jsonDecode(json));

          personajes.add(personajesMap[counterPersonaje]["name"]); 
        }
        else
        {
          print("Respuesta fallida");
        }
        counterPersonaje++;
      }
      print(personajes);
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
