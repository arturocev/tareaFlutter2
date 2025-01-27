import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class listadoApp extends StatefulWidget {
  const listadoApp({super.key});

  @override
  State<listadoApp> createState() => _listadoAppState();
}

class _listadoAppState extends State<listadoApp> {


  // --------------------------------------------------- VARIABLES ESTADO -----------------------------------
  late List<String> personajes;
  late int counter;
  late List<Map<String,dynamic>> personajesMap;
  late int counterPersonaje;


  // Inicializa las variables estado y llama a "listadoPersonajes" para obtener la primera página de los personajes
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

  

  // Realiza una solicitud HTTP a la API para obtener una lista de personajes actualiza el array "personajes" y llama a setState para actualizar la interfaz
  void listadoPersonajes(bool siguiente) async {
    if (siguiente == true) {
      counter++;
    }
    else {
      counter--;
    } 
      personajes = [];

        for (counterPersonaje = 0; counterPersonaje <= 10; counterPersonaje++) {
          final url = Uri.parse("https://www.anapioficeandfire.com/api/characters?page=$counter&pageSize=11");
          final response = await http.get(url);
          
          if (response.statusCode == 200) {
            final json = response.body;
            personajesMap = List<Map<String, dynamic>>.from(jsonDecode(json));
            
            if (personajesMap[counterPersonaje]["name"] == "") {
              personajes.add(personajesMap[counterPersonaje]["aliases"][0]);
            } else {
              personajes.add(personajesMap[counterPersonaje]["name"]); 
            }
            
          }
          else
          {
            print("Respuesta fallida");
          }
        }
        if (mounted) {   
        setState(() {});
      }
  }


 // Construye la interfaz del usuario, incluyendo una barra de aplicaciones, una lista de personajes y botones para navegar entre páginas

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Listado Personajes",
      style: TextStyle(
        color: Colors.white,
      ),),  
      ),
      body: Column(
        children: [
          Expanded(child: 
           ListView.separated(
            itemCount: personajes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(personajes[index]),
                leading: Icon(Icons.person_4),
              );
            }, separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(padding: EdgeInsets.all(8),
            child: ElevatedButton(onPressed: (){
              listadoPersonajes(true);
            }, 
            child: const Text("Siguiente página"),
            style: ElevatedButton.styleFrom (
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            ),
            ),
            Padding(padding: EdgeInsets.all(8),
            child: ElevatedButton(onPressed: (){
              listadoPersonajes(false);
            }, 
            child: const Text("Anterior página"),
            style: ElevatedButton.styleFrom (
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            ),
            ),
          ],
        )
        ],
      ) 
      );
  }
}




