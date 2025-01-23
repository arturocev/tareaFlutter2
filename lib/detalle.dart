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
    siNo = true;
    personajeSiguiente();
    texto = const Text("");
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
    if (mounted) {
      setState(() {});
    }

  }

  void personajeSiguiente() async
  {
    if (siNo == true) {
      idPersonaje++;
    } else {
      idPersonaje--;
    }
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
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Información de personaje",
        style: TextStyle(
          color: Colors.white
        )),
      ),
      body: Column(
        children: [
          Row(
            children: [
              texto
            ],
          ),
          Padding(padding: const EdgeInsets.all(20),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
                onPressed: () {
                  siNo = true;
                  if (siNo) {
                    personajeSiguiente();
                  }
                },
                child: const Icon(Icons.arrow_forward_sharp),
              ),
            ),
              FloatingActionButton(onPressed: () {
                siNo = false;
                if (!siNo) {
                  personajeSiguiente();
                } 
              },
              child: const Icon(Icons.arrow_back_sharp),
              ),
            ],
          ),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              child: const Icon(Icons.favorite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}