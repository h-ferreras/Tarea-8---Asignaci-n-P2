import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class EnMiVidaPage extends StatefulWidget {
  @override
  _EnMiVidaPageState createState() => _EnMiVidaPageState();
}

class _EnMiVidaPageState extends State<EnMiVidaPage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/en_mi_vida.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('En Mi Vida'),
      ),
      body: Column(
        children: [
          Chewie(
            controller: _chewieController,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Descubrir a Mike, aburrido en la pandemia, la confianza y seguridad del personaje principal, y la inspiradora frase "La vida está aquí (abajo) y yo quiero aquí (arriba)" son elementos que me han conectado profundamente con la serie "Suits". Explorar los giros y lecciones de la trama ha sido una fuente constante de inspiración y motivación para mí.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
