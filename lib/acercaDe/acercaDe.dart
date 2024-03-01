import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca De'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suits',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Creador: Aaron Korsh',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Cantidad de Temporadas: 9',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            Text(
              'Suits es una serie de televisión legal estadounidense creada y escrita por Aaron Korsh.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
