import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/personaje.dart';

class detalleApp extends StatefulWidget {
  const detalleApp({super.key});

  @override
  State<detalleApp> createState() => _detalleAppState();
}



class _detalleAppState extends State<detalleApp> {

  late int idPersonaje;
  late String nombrePersonaje;
  late String generoPersonaje;
  late Text texto;

  @override
  void initState() {
    idPersonaje = 1;
    nombrePersonaje = "";
    generoPersonaje = "";
    texto = const Text("0");
    primerPersonaje();
    super.initState();
  }

  void primerPersonaje() async
  {
    final url = Uri.parse("https://www.anapioficeandfire.com/api/characters/$idPersonaje");
    final response = await http.get(url);

    if (response.statusCode == 200) 
    {
      final json = response.body;
      Personaje personaje = Personaje.fromJson(jsonDecode(json));
      generoPersonaje = personaje.gender;
      if (personaje.name.isEmpty) {
         nombrePersonaje = "Personaje $idPersonaje";
      }
      else
      {
        nombrePersonaje = personaje.name;
      }
    }
    texto = Text("$nombrePersonaje: $generoPersonaje");
    setState(() {});
  }

  Text personajeSiguiente() {
    texto = const Text(
      "Hola",
    );
    return texto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 300),
                child: texto,
              ),
          ),
        FloatingActionButton(
          onPressed: personajeSiguiente,
          child: const Icon(Icons.arrow_circle_right_rounded),
        ),
        ],
      ),
    );
  }
}