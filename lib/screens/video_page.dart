import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Opens with: Navigator.pushNamed(context, '/video');
// Plays assets/videos/achievements.mp4 using the video_player package.
// If the video can't be loaded, a friendly message is shown instead.
class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final VideoPlayerController _controller;
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/achievements.mp4');
    _initFuture = _controller.initialize(); // loads the video (async)
  }

  @override
  void dispose() {
    _controller.dispose(); // free video resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('My Achievements')),
      body: Center(
        child: FutureBuilder<void>(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError || _controller.value.hasError) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.videocam_off, size: 64, color: scheme.primary),
                    const SizedBox(height: 12),
                    const Text(
                      'Video could not be loaded.\n'
                      'Place your video at assets/videos/achievements.mp4',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  const SizedBox(height: 8),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                  const SizedBox(height: 16),
                  IconButton.filled(
                    iconSize: 36,
                    icon: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    // setState -> icon changes between play / pause
                    onPressed: () => setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
