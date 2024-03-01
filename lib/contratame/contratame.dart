import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContratamePage extends StatefulWidget {
  @override
  _ContratamePageState createState() => _ContratamePageState();
}

class _ContratamePageState extends State<ContratamePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrátame'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: '),
            TextField(controller: _nameController),
            SizedBox(height: 16.0),
            Text('Correo Electrónico: '),
            TextField(controller: _emailController),
            SizedBox(height: 16.0),
            Text('Información Adicional:'),
            TextField(
              controller: _additionalInfoController,
              maxLines: 5,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                enviarCorreo();
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  void enviarCorreo() async {
    final smtpServer = gmail('tu.correo@gmail.com', 'tu_contraseña');

    final message = Message()
      ..from = Address('harveyferreras@gmail.com', 'Harvey Ferreras')
      ..recipients.add('destinatario@example.com') 
      ..subject = 'Solicitud de Contratación'
      ..text = 'Nombre: ${_nameController.text}\n'
          'Correo Electrónico: ${_emailController.text}\n'
          'Información Adicional: ${_additionalInfoController.text}';

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensaje enviado: ${sendReport.toString()}');
    } on MailerException catch (e) {
      print('Error al enviar el mensaje: $e');
    }
  }
}
