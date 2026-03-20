import 'package:flutter/cupertino.dart';

class WipeClipper extends CustomClipper<Rect> {
  final double progress;
  WipeClipper(this.progress);

  @override
  Rect getClip(Size size) {
    // Reveal edge moves from right → left as progress goes 0.0 → 1.0
    final revealedLeft = size.width * (1.0 - progress);
    return Rect.fromLTWH(revealedLeft, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(WipeClipper old) => old.progress != progress;
}