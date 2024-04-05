import 'dart:io';
//Harvey Ferreras 20197792
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late File _imageFile;
  late String _audioPath;
  late Database _database;
  late final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  @override
  void initState() {
    super.initState();
    _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    _initializeDatabase();
    _imageFile = File(''); 
    _audioPath = '';
  }

  Future<void> _initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'events.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE events (
          id INTEGER PRIMARY KEY,
          title TEXT,
          description TEXT,
          imagePath TEXT,
          audioPath TEXT
        )
      ''');
    });
  }

  Future<void> _addEvent() async {
    if (_formKey.currentState!.validate()) {
      await _database.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO events(title, description, imagePath, audioPath) VALUES("${_titleController.text}", "${_descriptionController.text}", "${_imageFile.path}", "$_audioPath")');
      });
      _titleController.clear();
      _descriptionController.clear();
      _imageFile = File(''); // Limpia
      _audioPath = '';
      _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
        content: Text('Evento agregado con éxito'),
      ));
      setState(() {}); // Actualiza :)
    }
  }
//Harvey Ferreras 20197792
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      _audioPath = result.files.single.path!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Eventos'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Seleccionar Imagen'),
              ),
              SizedBox(height: 20),
              _imageFile != null
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(_imageFile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox(), 
              SizedBox(height: 20),
              _audioPath.isNotEmpty
                  ? Text('Audio seleccionado: $_audioPath')
                  : ElevatedButton(
                      onPressed: _pickAudio,
                      child: Text('Seleccionar Audio'),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addEvent,
                child: Text('Guardar Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Harvey Ferreras 20197792