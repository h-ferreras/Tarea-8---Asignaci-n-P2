import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MomentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Momentos Favoritos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MomentoCard(
            titulo: 'Firma del Contrato',
            imagen: 'assets/images/momento1.jpg',
            video: 'assets/videos/momento1.mp4',
            detalles: 'Harvey y Mike firmando un contrato importante.',
          ),
          MomentoCard(
            titulo: 'Revelación Impactante',
            imagen: 'assets/images/momento2.jpg',
            video: 'assets/videos/momento2.mp4',
            detalles: 'Giro inesperado en la trama que cambió todo.',
          ),
          MomentoCard(
            titulo: 'Donna Siempre Lista',
            imagen: 'assets/images/momento3.jpg',
            video: 'assets/videos/momento3.mp4',
            detalles: 'Donna demostrando su ingenio y lealtad.',
          ),
        ],
      ),
    );
  }
}

class MomentoCard extends StatefulWidget {
  final String titulo;
  final String imagen;
  final String video;
  final String detalles;

  MomentoCard({required this.titulo, required this.imagen, required this.video, required this.detalles});

  @override
  _MomentoCardState createState() => _MomentoCardState();
}

class _MomentoCardState extends State<MomentoCard> {
  late VideoPlayerController _controller;
  bool _isVideoLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video)
      ..initialize().then((_) {
        setState(() {
          _isVideoLoaded = true;
        });
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(widget.imagen, height: 200, width: double.infinity, fit: BoxFit.cover),
          ListTile(
            title: Text(widget.titulo),
            subtitle: Text(widget.detalles),
            onTap: () {
              _isVideoLoaded
                  ? showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar'),
                          ),
                        ],
                      ),
                    )
                  : null;
            },
          ),
        ],
      ),
    );
  }
}