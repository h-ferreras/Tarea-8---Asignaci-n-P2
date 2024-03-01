import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PortadaPage extends StatefulWidget {
  @override
  _PortadaPageState createState() => _PortadaPageState();
}

class _PortadaPageState extends State<PortadaPage> {
  late VideoPlayerController _controller;
  bool _isVideoLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Download.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoLoaded = true;
        });
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isVideoLoaded
          ? Stack(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
