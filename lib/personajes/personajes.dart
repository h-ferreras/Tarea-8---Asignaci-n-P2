import 'package:flutter/material.dart';

class PersonajesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PersonajeCard(
            nombre: 'Harvey Specter',
            imagen: 'assets/images/harvey.jpg',
            detalles: 'Socio principal en Pearson Specter, conocido por su astucia y carisma.',
          ),
          PersonajeCard(
            nombre: 'Mike Ross',
            imagen: 'assets/images/mike.jpg',
            detalles: 'Asociado brillante con una memoria fotográfica, trabajó sin título universitario.',
          ),
          PersonajeCard(
            nombre: 'Donna Paulsen',
            imagen: 'assets/images/donna.jpg',
            detalles: 'Secretaria ejecutiva con habilidades excepcionales y un sentido del humor único.',
          ),
        ],
      ),
    );
  }
}

class PersonajeCard extends StatelessWidget {
  final String nombre;
  final String imagen;
  final String detalles;

  PersonajeCard({required this.nombre, required this.imagen, required this.detalles});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(imagen, height: 200, width: double.infinity, fit: BoxFit.cover),
          ListTile(
            title: Text(nombre),
            subtitle: Text(detalles),
          ),
        ],
      ),
    );
  }
}
