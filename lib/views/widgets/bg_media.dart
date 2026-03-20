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
  bool _initialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    
    print('initState for link: ${widget.path}');

    if (widget.isVideo) {
      _initVideo();
    }
  }

  Future<void> _initVideo() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.path)
      )
        ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
        });

      print('Initializing');

      // await _controller!.initialize();

      // ✅ FIX 1: Mute BEFORE play — browsers block autoplay with sound
      await _controller!.setVolume(0.0);

      print('Mute BEFORE play ');

      // ✅ FIX 2: Set looping BEFORE play
      await _controller!.setLooping(true);

      print('looping BEFORE play');

      // ✅ FIX 3: Play only after everything is configured
      await _controller!.play();

      print('Play only after everything is configured');

      if (mounted) {
        setState(() => _initialized = true);
      }
    } catch (e) {
      debugPrint('BgMedia video error: $e');
      if (mounted) {
        setState(() => _hasError = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVideo) {
      return Image.asset(
        widget.path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _fallbackUI(),
      );
    }

    // Show video only when fully ready
    if (_initialized && !_hasError && _controller!.value.isInitialized) {
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

    // Show fallback while loading or on error
    return _fallbackUI();
  }

  Widget _fallbackUI() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
      return [Colors.black, Colors.grey.shade900];
    } else if (path.contains('profile')) {
      return [Colors.blue, Colors.purple];
    } else {
      return [Colors.grey.shade800, Colors.grey.shade600];
    }
  }
}