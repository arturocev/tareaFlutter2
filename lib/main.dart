import 'package:flutter/material.dart';
import 'package:tarea_flutter/destacado.dart';
import 'package:tarea_flutter/detalle.dart';
import 'package:tarea_flutter/favoritos.dart';
import 'package:tarea_flutter/listado.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget 
{
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget 
{
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> 
{
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>
  [
      destacadoApp(),
      listadoApp(selectedIndex: 0),
      DetalleApp(),
      favoritosApp(),

  ];

  void _onItemTapped(int index) 
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Destacado',
            backgroundColor:  Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listado',
            backgroundColor:  Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Detalle',
            backgroundColor:  Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
            backgroundColor:  Color.fromARGB(255, 0, 0, 0),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
