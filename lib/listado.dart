import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    super.initState();
    personajes = [];
    personajesMap = [];
    counter = 1;
    counterPersonaje = 0;
    listadoPersonajes(true);
  }

  

  void listadoPersonajes(bool siguiente) async {
    if (siguiente == true) {
      counter++;
    }
    else {
      counter--;
    } 
      personajes = [];
      while (counterPersonaje <= 10)
      {
        final url = Uri.parse("https://www.anapioficeandfire.com/api/characters?page=$counter&pageSize=11");
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
        setState(() {});
      counterPersonaje = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(padding: 
          const EdgeInsets.only(right: 500),
          child: FloatingActionButton(
              onPressed: () {
                listadoPersonajes(true);
              },
              child: const Icon(Icons.arrow_forward_ios_sharp),
            ),
          ),
          Padding(padding: 
          const EdgeInsets.only(right: 300
          ),
          child: FloatingActionButton(onPressed: () {
            listadoPersonajes(false);
          } ,
          child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          ),
        ],
      ),
      body: ListView.builder(
      itemCount: personajes.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          personajes[index],
          style: const TextStyle(
            fontSize: 20,
          ),
        );
                },  
                ),
      );
  }
}




