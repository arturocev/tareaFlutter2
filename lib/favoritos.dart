import 'package:flutter/material.dart';

class favoritosApp extends StatefulWidget {
  const favoritosApp({super.key});

  @override
  State<favoritosApp> createState() => _favoritosAppState();
}

class _favoritosAppState extends State<favoritosApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Text(
          "Estoy en la página de favoritos",
        ),
      ),
    );
  }
}