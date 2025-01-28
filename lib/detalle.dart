
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/listaFavoritos.dart';
import 'package:tarea_flutter/personaje.dart';

class DetalleApp extends StatefulWidget {
  const DetalleApp({super.key});

  @override
  State<DetalleApp> createState() => _detalleAppState();
}



class _detalleAppState extends State<DetalleApp> {

  // --------------------------------------------- VARIABLES DE ESTADO -------------------------------------------------
  late String nombrePersonaje;
  late String generoPersonaje;
  late String culturaPersonaje;
  late String fechaNacimiento;
  late String fechaMuerte;
  late List<dynamic> aliases;
  late List<dynamic> titles;
  late Text texto;
  late bool siNo;
  late bool actual;

  // La variable customizations es una lista que contiene personalizaciones para el color y la forma. index se utiliza para la personalización actual

  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
      <(Color?, Color?, ShapeBorder?)>[
    (null, null, null),
    (Colors.red, null, null),
  ];
  int index = 0; 

 // El método initState inicializa las variables de estado y llama al método "personajeSiguiente" para obtener el primer personaje.

  @override
  void initState() {
    nombrePersonaje = "";
    culturaPersonaje = "";
    aliases = [];
    titles = [];
    generoPersonaje = "";
    siNo = true;
    actual = true;
    personajeSiguiente();
    texto = const Text("");
    super.initState();
  }

  // Este método verifica si el personaje actual está en la lista de favoritos y actualiza las variables "siNo" e "index". 

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

  // Este método obtiene el siguiente personaje de la API y actualiza las variables de estado con la información obtenida. Luego, llama a "esFavorito" y actualiza el Widget con setState 

  void personajeSiguiente() async
  {
    if (siNo == true && actual == false) {
      Personaje.idPersonaje++;
    } else if (siNo == false && actual == false) {
      Personaje.idPersonaje--;
    }
    final url = Uri.parse("https://www.anapioficeandfire.com/api/characters/${Personaje.idPersonaje}");
    final response = await http.get(url);

    if (response.statusCode == 200) 
    {
      final json = response.body;
      Personaje personaje = Personaje.fromJson(jsonDecode(json));
      generoPersonaje = personaje.gender;

      if (personaje.aliases.isEmpty) {
        
        aliases = ["Sin alias"];
      } else {
        aliases = [personaje.aliases[0]];
      }

      if (personaje.titles.isEmpty) {
        
        titles = ["Sin título"];
      } else {
        titles = [personaje.titles[0]];
      }

      if (personaje.culture.isEmpty) {
        culturaPersonaje = "Sin cultura";
      } else {
        culturaPersonaje = personaje.culture;
      }

      
      if (personaje.name.isEmpty) {
         nombrePersonaje = personaje.aliases[0];
      }
      else
      {
        nombrePersonaje = personaje.name;
      }

      if (personaje.born.isEmpty) {
        fechaNacimiento = "Desconocida";
      } else {
        fechaNacimiento = personaje.born;
      }

      if (personaje.died.isEmpty) {
        fechaMuerte = "Desconocida";
      } else {
        fechaMuerte = personaje.died;
      }
    }
    esFavorito();
    texto = Text(" Genero: $generoPersonaje \n Cultura: $culturaPersonaje \n Alias: ${aliases[0]} \n Fecha de nacimiento: $fechaNacimiento \n Fecha de muerte: $fechaMuerte \n Título: ${titles[0]}",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: MediaQuery.of(context).size.width > 600 ? 20.0 : 16.0,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
              );
    actual = false;
    if (mounted) {
      setState(() {});
    }
  }

// Define la interfaz de usuario con Appbar, texto y botones
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var titleFontSize = screenSize.width > 600 ? 50.0 : 30.0;
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
              Text(nombrePersonaje,
            style: TextStyle(
              fontSize: titleFontSize,
              fontStyle: FontStyle.normal,
            ),
          ),
            ], 
          ),
          Row(
            children: [
              texto,
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
                  Listafavoritos.generosFavoritos.add(generoPersonaje);
                } else {
                  Listafavoritos.personajesFavoritos.remove(nombrePersonaje);
                  Listafavoritos.generosFavoritos.remove(generoPersonaje);
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
