import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/listaFavoritos.dart';
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
  late bool siNo;

  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
      <(Color?, Color?, ShapeBorder?)>[
    (null, null, null),
    (Colors.red, null, null),
  ];
  int index = 0; 

  @override
  void initState() {
    idPersonaje = 1;
    nombrePersonaje = "";
    generoPersonaje = "";
    siNo = false;
    personajeSiguiente();
    texto = const Text("0");
    super.initState();
  }

  void esFavorito() {
    siNo = false;
    for (var i in Listafavoritos.personajesFavoritos) {
      if (nombrePersonaje == i) {
        index = 1 % customizations.length;
        siNo = true;
      }
      else if (nombrePersonaje != i && siNo == false) {
        index = 0 % customizations.length;
      }
    }
    siNo = false;
    setState(() {});
  }

  void personajeSiguiente() async
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
    esFavorito();
    texto = Text("$nombrePersonaje: $generoPersonaje");
    idPersonaje++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 300, bottom: 100),
                child: texto,
              ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
          onPressed: () {
            personajeSiguiente();
          },
          child: const Icon(Icons.arrow_forward_sharp),
        ),
        ),
        FloatingActionButton(onPressed: () {
          if (index == 0) {
            Listafavoritos.personajesFavoritos.add(nombrePersonaje);
          } else {
            Listafavoritos.personajesFavoritos.remove(nombrePersonaje);
          }
          setState(() {
            index = (index + 1) % customizations.length;
          });
        },
        foregroundColor: customizations[index].$1,
        child: Icon(Icons.favorite),
        ),
        ],
      ),
    );
  }
}