import 'package:flutter/material.dart';

/// Circle indicators connected by animated glowing bars.
///
/// Positioned(
///   bottom: 32,
///   right: 32,
///   child: SlidePreviewIndicators(
///     slides: kIndicators,
///     current: _current,
///     accentColor: kSlides[_current].accentColor,
///     autoPlayDuration: const Duration(seconds: 4),
///     onTap: (i) { ... },
///   ),
/// )

class SlidePreviewIndicators extends StatefulWidget {
  final List<SlideIndicatorData> slides;
  final int current;
  final Color accentColor;
  final Duration autoPlayDuration;
  final ValueChanged<int> onTap;

  const SlidePreviewIndicators({
    super.key,
    required this.slides,
    required this.current,
    required this.accentColor,
    required this.autoPlayDuration,
    required this.onTap,
  });

  @override
  State<SlidePreviewIndicators> createState() =>
      _SlidePreviewIndicatorsState();
}

class _SlidePreviewIndicatorsState extends State<SlidePreviewIndicators>
    with TickerProviderStateMixin {
  late AnimationController _progressCtrl;
  late Animation<double> _progressAnim;

  late AnimationController _entranceCtrl;
  late Animation<Offset> _entranceSlide;
  late Animation<double> _entranceFade;

  late List<AnimationController> _connectorCtrls;
  late List<Animation<double>> _connectorAnims;

  List<bool> _hovered = [];

  @override
  void initState() {
    super.initState();
    _hovered = List.filled(widget.slides.length, false);

    // Entrance
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _entranceSlide = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic));
    _entranceFade = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);

    // Active tile progress sweep
    _progressCtrl = AnimationController(
      vsync: this,
      duration: widget.autoPlayDuration,
    );
    _progressAnim = CurvedAnimation(parent: _progressCtrl, curve: Curves.linear);

    // Connector bars
    final gapCount = widget.slides.length - 1;
    _connectorCtrls = List.generate(
      gapCount,
          (_) => AnimationController(vsync: this, duration: widget.autoPlayDuration),
    );
    _connectorAnims = _connectorCtrls
        .map((c) => CurvedAnimation(parent: c, curve: Curves.linear) as Animation<double>)
        .toList();

    _entranceCtrl.forward();
    _progressCtrl.forward(from: 0);
    _syncConnectors();
  }

  void _syncConnectors() {
    for (int i = 0; i < _connectorCtrls.length; i++) {
      if (i < widget.current) {
        _connectorCtrls[i].value = 1.0;
      } else if (i == widget.current) {
        _connectorCtrls[i].forward(from: 0);
      } else {
        _connectorCtrls[i].value = 0.0;
      }
    }
  }

  @override
  void didUpdateWidget(SlidePreviewIndicators oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.current != widget.current) {
      _progressCtrl.forward(from: 0);
      _syncConnectors();
    }
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    _entranceCtrl.dispose();
    for (final c in _connectorCtrls) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _entranceFade,
      child: SlideTransition(
        position: _entranceSlide,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < widget.slides.length; i++) ...[
              _buildCircle(i),
              SizedBox(width: 16,)
              // if (i < widget.slides.length - 1) _buildConnector(i),
            ],
          ],
        ),
      ),
    );
  }

  // ─────────────────── CIRCLE TILE ──────────────────────────────────────
  Widget _buildCircle(int index) {
    final isActive = index == widget.current;
    final isPast = index < widget.current;
    final slide = widget.slides[index];

    // All circles — size grows when active or hovered
    final size = isActive ? 110.0 : (_hovered[index] ? 78.0 : 66.0);

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered[index] = true),
        onExit: (_) => setState(() => _hovered[index] = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive
                  ? widget.accentColor
                  : isPast
                  ? widget.accentColor.withOpacity(0.50)
                  : Colors.white.withOpacity(0.20),
              width: isActive ? 2.5 : 1.5,
            ),
            boxShadow: isActive
                ? [
              BoxShadow(
                color: widget.accentColor.withOpacity(0.45),
                blurRadius: 28,
                spreadRadius: 4,
              ),
              BoxShadow(
                color: widget.accentColor.withOpacity(0.15),
                blurRadius: 56,
                spreadRadius: 10,
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                blurRadius: 12,
              ),
            ],
          ),
          // ClipOval clips the Stack content into a circle shape
          child: ClipOval(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ── Thumbnail image ──
                Image.asset(
                  slide.thumbnailPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                      ),
                    ),
                  ),
                ),

                // ── Dark overlay — lighter when active ──
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  color: Colors.black.withOpacity(isActive ? 0.10 : 0.55),
                ),

                // ── Active: arc progress sweep at bottom ──
                // if (isActive)
                //   Positioned(
                //     left: 0,
                //     right: 0,
                //     bottom: 0,
                //     child: AnimatedBuilder(
                //       animation: _progressAnim,
                //       builder: (_, __) => LayoutBuilder(
                //         builder: (_, c) => Align(
                //           alignment: Alignment.centerLeft,
                //           child: Container(
                //             width: c.maxWidth * _progressAnim.value,
                //             height: 4,
                //             decoration: BoxDecoration(
                //               color: widget.accentColor,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: widget.accentColor.withOpacity(0.9),
                //                   blurRadius: 10,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),

                // ── Past slides: full bottom bar ──
                // if (isPast)
                //   Positioned(
                //     left: 0,
                //     right: 0,
                //     bottom: 0,
                //     child: Container(
                //       height: 4,
                //       color: widget.accentColor.withOpacity(0.55),
                //     ),
                //   ),

                // // ── Slide number badge ──
                // Positioned(
                //   top: 8,
                //   right: 8,
                //   child: AnimatedContainer(
                //     duration: const Duration(milliseconds: 400),
                //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                //     decoration: BoxDecoration(
                //       color: isActive
                //           ? widget.accentColor
                //           : Colors.black.withOpacity(0.55),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //     child: Text(
                //       '0${index + 1}',
                //       style: TextStyle(
                //         fontSize: 10,
                //         fontWeight: FontWeight.w800,
                //         color: isActive ? Colors.black : Colors.white70,
                //         letterSpacing: 0.5,
                //       ),
                //     ),
                //   ),
                // ),

                // ── Hovered inactive: play hint ──
                if (!isActive && _hovered[index])
                  Center(
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────── CONNECTOR BAR ────────────────────────────────────
  Widget _buildConnector2(int gapIndex) {
    final isPast = gapIndex < widget.current;
    final isCurrentGap = gapIndex == widget.current;

    return SizedBox(
      width: 36,
      height: 36,
      child: Center(
        child: Stack(
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.none,
          children: [
            // Base dim track
            Container(
              width: 36,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            // Filled animated portion
            AnimatedBuilder(
              animation: gapIndex < _connectorAnims.length
                  ? _connectorAnims[gapIndex]
                  : const AlwaysStoppedAnimation(0.0),
              builder: (_, __) {
                final fill = isPast
                    ? 1.0
                    : isCurrentGap && gapIndex < _connectorAnims.length
                    ? _connectorAnims[gapIndex].value
                    : 0.0;

                return Container(
                  width: 36 * fill,
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.accentColor.withOpacity(0.6),
                        widget.accentColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: widget.accentColor.withOpacity(0.7),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                );
              },
            ),

            // Glowing travelling dot on active connector
            if (isCurrentGap && gapIndex < _connectorAnims.length)
              AnimatedBuilder(
                animation: _connectorAnims[gapIndex],
                builder: (_, __) {
                  const dotSize = 10.0;
                  final t = _connectorAnims[gapIndex].value;
                  final left = (36 * t - dotSize / 2).clamp(0.0, 36 - dotSize);

                  return Positioned(
                    left: left,
                    top: -(dotSize / 2 - 1.5),
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: widget.accentColor,
                            blurRadius: 12,
                            spreadRadius: 3,
                          ),
                          BoxShadow(
                            color: widget.accentColor.withOpacity(0.4),
                            blurRadius: 24,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────
class SlideIndicatorData {
  /// Image slides  → same path as the hero image
  /// Video slides  → path to a .jpg thumbnail frame
  ///                 e.g. 'assets/hero1_thumb.jpg'
  final String thumbnailPath;

  const SlideIndicatorData({required this.thumbnailPath});
}