import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicacion Caja de Herremientas :)'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Image.network('assets/caja.jpg'),

            
            GenderPredictionWidget(),

            
            AgePredictionWidget(),

            
            UniversitiesWidget(),

            
            WeatherWidget(),

            
            WordPressNewsWidget(),

            
            AboutWidget(),
          ],
        ),
      ),
    );
  }
}

class GenderPredictionWidget extends StatefulWidget {
  @override
  _GenderPredictionWidgetState createState() => _GenderPredictionWidgetState();
}

class _GenderPredictionWidgetState extends State<GenderPredictionWidget> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';

  Future<void> predictGender() async {
    String name = _nameController.text;
    String apiUrl = 'https://api.genderize.io/?name=$name';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String gender = data['gender'] ?? '';

        setState(() {
          _gender = gender;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Ingrese un nombre'),
        ),
        ElevatedButton(
          onPressed: () => predictGender(),
          child: Text('Predecir Género'),
        ),
        _gender.isNotEmpty
            ? Container(
                child: _gender.toLowerCase() == 'male'
                    ? Text('Género: Masculino', style: TextStyle(color: Colors.blue))
                    : Text('Género: Femenino', style: TextStyle(color: Colors.pink)),
              )
            : Container(),
      ],
    );
  }
}

class AgePredictionWidget extends StatefulWidget {
  @override
  _AgePredictionWidgetState createState() => _AgePredictionWidgetState();
}

class _AgePredictionWidgetState extends State<AgePredictionWidget> {
  TextEditingController _nameController = TextEditingController();
  int _age = 0;

  Future<void> predictAge() async {
    String name = _nameController.text;
    String apiUrl = 'https://api.agify.io/?name=$name';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        int age = data['age'] ?? 0;

        setState(() {
          _age = age;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Ingrese un nombre'),
        ),
        ElevatedButton(
          onPressed: () => predictAge(),
          child: Text('Predecir Edad'),
        ),
        _age > 0
            ?  Container(
              child: Column(
                children: [
                  Text('Edad: $_age'),
                  if (_age < 18)
                    Image.asset('assets/nino.jpg')
                  else if (_age < 65)
                    Image.asset('assets/adulto.jpg')
                  else
                    Image.asset('assets/viejo.jpg'),
                ],
              ),
            )
            : Container(),
      ],
    );
  }
}

class UniversitiesWidget extends StatefulWidget {
  @override
  _UniversitiesWidgetState createState() => _UniversitiesWidgetState();
}

class _UniversitiesWidgetState extends State<UniversitiesWidget> {
  TextEditingController _countryController = TextEditingController();
  List<University> _universities = [];

  Future<void> fetchUniversities() async {
    String country = _countryController.text;
    String apiUrl = 'http://universities.hipolabs.com/search?country=$country';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<University> universities = data.map((e) => University.fromJson(e)).toList();

        setState(() {
          _universities = universities;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _countryController,
          decoration: InputDecoration(labelText: 'Ingrese un país en inglés'),
        ),
        ElevatedButton(
          onPressed: () => fetchUniversities(),
          child: Text('Mostrar Universidades'),
        ),
        if (_universities.isNotEmpty)
          Column(
            children: _universities
                .map(
                  (uni) => ListTile(
                    title: Text(uni.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dominio: ${uni.domains.join(', ')}'),
                        Text('Link: ${uni.webPages.join(', ')}'),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class University {
  final String name;
  final List<String> domains;
  final List<String> webPages;

  University({
    required this.name,
    required this.domains,
    required this.webPages,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '',
      domains: List<String>.from(json['domains'] ?? []),
      webPages: List<String>.from(json['web_pages'] ?? []),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
 

  @override
  Widget build(BuildContext context) {
    return Container(); 
  }
}


class WordPressNewsWidget extends StatefulWidget {
  @override
  _WordPressNewsWidgetState createState() => _WordPressNewsWidgetState();
}

class _WordPressNewsWidgetState extends State<WordPressNewsWidget> {
  List<News> _newsList = [];

  Future<void> getWordPressNews() async {
    String apiUrl = 'https://www.teamviewer.com/en-us/';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
    
        List<dynamic> data = json.decode(response.body);
        List<News> newsList = data.map((e) => News.fromJson(e)).toList();

        setState(() {
          _newsList = newsList;
        });
      } else {
        print('Error al obtener las noticias: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener las noticias: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => getWordPressNews(),
          child: Text('Obtener Noticias de WordPress'),
        ),
        _newsList.isNotEmpty
            ? Column(
                children: _newsList
                    .map((news) => ListTile(
                          title: Text(news.title),
                          subtitle: Text(news.summary),
                          onTap: () {
                   
                          },
                        ))
                    .toList(),
              )
            : Container(),
      ],
    );
  }
}

class News {
  final String title;
  final String summary;
  final String link;

  News({
    required this.title,
    required this.summary,
    required this.link,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      link: json['link'] ?? '',
    );
  }
}

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Harvey Ferreras harveyferreras@gmail.com'),
      ],
    );
  }
}
