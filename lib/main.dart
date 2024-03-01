import 'package:flutter/material.dart';


import 'portada/portada.dart';
import 'personajes/personajes.dart';
import 'momentos/momentos.dart';
import 'enMiVida/enMiVida.dart';
import 'contratame/contratame.dart';
import 'acercaDe/acercaDe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Suits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PortadaPage(), 
    );
  }
}
