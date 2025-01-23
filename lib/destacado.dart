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
        icono = const Icon(Icons.male);
      }
      else
      {
        icono = const Icon(Icons.female);
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
      body: Column(
        children: [
          Center(
            child: 
          Padding(
          padding: const EdgeInsets.only(top: 300),
          child: personajeTexto.isEmpty ? 
          const CircularProgressIndicator(): 
          Text(
          personajeTexto,
          style: const TextStyle
          ( 
            fontSize: 17.0,
          ),
        ),
        ),
          ),
        personajeTexto.isEmpty ?
        const CircularProgressIndicator(): icono
        ],
      ),
    );
  }
}

