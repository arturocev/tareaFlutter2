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
      body:  ListView.builder(
            itemCount: Listafavoritos.personajesFavoritos.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                Listafavoritos.personajesFavoritos[index],
                style: const TextStyle(
                  fontSize: 20,
                ),
              );
          },  
          ),
    );
  }
}