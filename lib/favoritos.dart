import 'package:flutter/material.dart';
import 'package:tarea_flutter/listaFavoritos.dart';

class favoritosApp extends StatefulWidget {
  const favoritosApp({super.key});
  @override
  State<favoritosApp> createState() => _favoritosAppState();
}

class _favoritosAppState extends State<favoritosApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Listado de personajes favoritos",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
      ),
      body:  
      Center (
            child: Hero(tag: "Listado favoritos", 
            child: ListView.separated(
            itemCount: Listafavoritos.personajesFavoritos.length,
            itemBuilder: (BuildContext context, int index) {
              return Material(
                  child: ListTile(
                    title: Text(Listafavoritos.personajesFavoritos[index]),
                    subtitle: Text(Listafavoritos.generosFavoritos[index]),
                    leading: const Icon(Icons.person),
                  ), 
              );
          },  separatorBuilder: (BuildContext context, int index) => const Divider(),
          ), 
            ),
      ),
    );
  }
}