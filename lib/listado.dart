import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/personaje.dart';
import 'package:tarea_flutter/listaFavoritos.dart';

class listadoApp extends StatefulWidget {
  int selectedIndex;
  listadoApp({super.key, required this.selectedIndex});

  @override
  State<listadoApp> createState() => _listadoAppState();
}

class _listadoAppState extends State<listadoApp> {


  // --------------------------------------------------- VARIABLES ESTADO -----------------------------------
  late int counter;


  // Inicializa las variables estado y llama a "listadoPersonajes" para obtener la primera página de los personajes
  @override
  void initState()
  {
    super.initState();
    counter = 1;
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
      Personaje.personajes = [];

        for (Personaje.counterPersonaje = 0; Personaje.counterPersonaje <= 10; Personaje.counterPersonaje++) {
          final url = Uri.parse("https://www.anapioficeandfire.com/api/characters?page=$counter&pageSize=11");
          final response = await http.get(url);
          
          if (response.statusCode == 200) {
            final json = response.body;
            Personaje.personajesMap = List<Map<String, dynamic>>.from(jsonDecode(json));
            
            if (Personaje.personajesMap[Personaje.counterPersonaje]["name"].toString() == "") {
              Personaje.personajes.add(Personaje.personajesMap[Personaje.counterPersonaje]["aliases"][0]);
            } else {
              Personaje.personajes.add(Personaje.personajesMap[Personaje.counterPersonaje]["name"]); 
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
            itemCount: Personaje.personajes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(Personaje.personajes[index]),
                leading: Icon(Icons.person_4),
                onTap: () {
                    Personaje.indicePersonaje = index;
                    Personaje.personajes[0] = Personaje.personajes[Personaje.indicePersonaje];
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaDetalle()));
            },
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

class PantallaDetalle extends StatefulWidget {
  var personajes = [];
  PantallaDetalle({super.key});

  @override
  State<PantallaDetalle> createState() => _PantallaDetalleState();
}

class _PantallaDetalleState extends State<PantallaDetalle> {

static const List<(Color?, Color? background, ShapeBorder?)> customizations =
  <(Color?, Color?, ShapeBorder?)>[
  (null, null, null),
  (Colors.white, null, null),
];
int index = 0; 

String nombrePersonaje = "";
String generoPersonaje = "";
List<String> alias = [];
List<String> titulos = [];
String cultura = "";
String fechaMuerte = "";
String fechaNacimiento = "";
bool siNo = true;

void informacionPersonaje() {

        if(Personaje.personajesMap[Personaje.indicePersonaje]["name"].toString() == "") {
          nombrePersonaje = Personaje.personajesMap[Personaje.indicePersonaje]["aliases"][0];
        } 
        else 
        {
          nombrePersonaje = Personaje.personajesMap[Personaje.indicePersonaje]["name"];
        }

        if (Personaje.personajesMap[Personaje.indicePersonaje]["aliases"].toString() == "[]") {
           alias = ["Sin alias"];
        } else {
          alias = [Personaje.personajesMap[Personaje.indicePersonaje]["aliases"][0]];
        }
        
        generoPersonaje = (Personaje.personajesMap[Personaje.indicePersonaje]["gender"].toString());

        if (Personaje.personajesMap[Personaje.indicePersonaje]["culture"].toString() == "") {
          cultura = "Sin cultura";
        }
        else
        {
          cultura = Personaje.personajesMap[Personaje.indicePersonaje]["culture"];
        }


        if (Personaje.personajesMap[Personaje.indicePersonaje]["titles"].toString() == "[]") {
          titulos = ["Sin titulo"];
        }
        else {
          titulos = [Personaje.personajesMap[Personaje.indicePersonaje]["titles"][0]];
        }

        if (Personaje.personajesMap[Personaje.indicePersonaje]["born"].toString() == "") {
          fechaNacimiento = "Desconocido";
        }
        else {
          fechaNacimiento = Personaje.personajesMap[Personaje.indicePersonaje]["born"];
        }

        if (Personaje.personajesMap[Personaje.indicePersonaje]["died"].toString() == "") {
          fechaMuerte = "Desconocido";
        }
        else {
          fechaMuerte = Personaje.personajesMap[Personaje.indicePersonaje]["died"];
        }
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

  void initState() {
    informacionPersonaje();
    esFavorito();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var titleFontSize = screenSize.width > 600 ? 50.0 : 30.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Listado Personajes",
      style: TextStyle(
        color: Colors.white,
        ),
        ),  
      ),
      body: Column(children: [
        Text(nombrePersonaje,
          style: TextStyle(
              fontSize: titleFontSize,
              fontStyle: FontStyle.normal,
            ),
            ),
        Text("Genero: " + generoPersonaje + "\nAlias:" + alias[0] + "\nTitulos: " + titulos[0] + "\nCultura: " + cultura + "\nFecha de Nacimiento: " + fechaNacimiento + "\nFecha de Muerte: " + fechaMuerte,
          style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: MediaQuery.of(context).size.width > 600 ? 20.0 : 16.0,
                  decorationStyle: TextDecorationStyle.dashed,
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
              backgroundColor: Colors.black,
              foregroundColor: customizations[index].$1,
              child: const Icon(Icons.favorite),
              ),
            ],
          ),
      ],
      )
      
    );
  }
}