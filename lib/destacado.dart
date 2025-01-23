import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/personaje.dart';


class destacadoApp extends StatefulWidget {
  const destacadoApp({super.key});

  @override
  State<destacadoApp> createState() => _destacadoAppState();
}


class _destacadoAppState extends State<destacadoApp> {
  String personajeTexto = "";
  int idPersonaje = 2122;
  Random random = Random();
  late Icon icono = const Icon(Icons.timer_off);

  @override
  void initState()
  {
    super.initState();
    personajeRandom();
  }
  
  void personajeRandom() async
  {
    idPersonaje = random.nextInt(2121);
    final url = Uri.parse("https://www.anapioficeandfire.com/api/characters/$idPersonaje");
    final response = await http.get(url);

    if (response.statusCode == 200) 
    {
      final json = response.body;
      Personaje personaje = Personaje.fromJson(jsonDecode(json));
      personajeTexto = "${personaje.name}: ${personaje.gender}";
      if (personaje.gender == "Male") 
      {
        icono = const Icon(Icons.male,
      color: Color.fromARGB(255, 94, 141, 179),
    size: 50,);
      }
      else
      {
        icono = const Icon(Icons.female,
      color: Color.fromARGB(255, 230, 106, 147),
    size: 50,);
      }
    }
    else
    {
      personajeTexto = "Error al cargar el personaje";
    }
    if (mounted) {
      setState(() {}); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Personaje Aleatorio",
          style: TextStyle(
            color: Colors.white,
          ),
          
      ),
        backgroundColor: Colors.black,
      ),
      body:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
            personajeTexto.isEmpty ?
            const CircularProgressIndicator(): 
            icono,
              Text(
                personajeTexto,
                style: const TextStyle
                ( 
                  fontSize: 20.0,
                  fontFamily: "verdana",
                ), 
                textAlign: TextAlign.center,
              ),
              
            ],
            ),
            ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            personajeRandom();
          }, 
          label: const Text("Personaje Aleatorio"),
      ),
      );
  }
}

