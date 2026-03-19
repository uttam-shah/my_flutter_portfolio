import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BgMedia extends StatefulWidget {
  final String path;
  final bool isVideo;

  const BgMedia({
    super.key,
    required this.path,
    required this.isVideo,
  });

  @override
  State<BgMedia> createState() => _BgMediaState();
}

class _BgMediaState extends State<BgMedia> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.isVideo) {
      _controller = VideoPlayerController.asset(widget.path)
        ..initialize().then((_) {
          setState(() {});
          _controller!.setLooping(true);
          _controller!.play();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVideo) {
      // ✅ IMAGE
      return Image.asset(
        widget.path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _fallbackUI(),
      );
    }

    // ✅ VIDEO
    if (_controller != null && _controller!.value.isInitialized) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        ),
      );
    }

    return _fallbackUI();
  }

  Widget _fallbackUI() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _fallback(widget.path),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  List<Color> _fallback(String path) {
    if (path.contains('video')) {
      return [
        Colors.black,
        Colors.grey.shade900,
      ];
    } else if (path.contains('profile')) {
      return [
        Colors.blue,
        Colors.purple,
      ];
    } else {
      return [
        Colors.grey.shade800,
        Colors.grey.shade600,
      ];
    }
  }
}