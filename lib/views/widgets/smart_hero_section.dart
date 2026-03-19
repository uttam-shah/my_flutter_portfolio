import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'bg_media.dart';

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class SlideData {
  final String imagePath;
  final String headline;
  final String subline;
  final Color accentColor;
  final bool isVideo;

  const SlideData({
    required this.imagePath,
    required this.headline,
    required this.subline,
    required this.accentColor,
    required this.isVideo,
  });
}

const List<SlideData> kSlides = [
  SlideData(
    imagePath: 'assets/images/image1.jpg',
    headline: 'Developing Full‑Stack\nFlutter Apps',
    subline: 'End-to-end, pixel-perfect, blazing fast.',
    accentColor: Color(0xFF00E5FF),
    isVideo: false
  ),
  SlideData(
    imagePath: 'assets/images/video2.mp4',
    headline: 'Ready to Push Your\nIdeas to Production',
    subline: 'From concept to deployment — smartly.',
    accentColor: Color(0xFF69FF47),
    isVideo: true
  ),
  SlideData(
    imagePath: 'assets/images/video3.mp4',
    headline: 'Architecting Modern\nScalable Systems',
    subline: 'Clean code. Solid foundations.',
    accentColor: Color(0xFFFF6B6B),
    isVideo: true
  ),
  SlideData(
    imagePath: 'assets/images/video4.mp4',
    headline: 'Crafting Beautiful\nUI Experiences',
    subline: 'Motion, depth and delight — built in.',
    accentColor: Color(0xFFFFD93D),
    isVideo: true
  ),
  SlideData(
    imagePath: 'assets/images/video5.mp4',
    headline: 'Turning Complex\nProblems into Products',
    subline: 'Strategy meets engineering.',
    accentColor: Color(0xFFB47AEA),
    isVideo: true
  ),
];

const List<String> kNavItems = ['Home', 'About', 'Work', 'Skills', 'Contact'];

// ─────────────────────────────────────────────
//  SMART HERO SECTION  ← drop this into HomeScreen
// ─────────────────────────────────────────────
class SmartHeroSection extends StatefulWidget {
  /// Pass viewModel.scrollController so this widget can
  /// listen to scroll and fade itself + the nav out.
  final ScrollController scrollController;

  const SmartHeroSection({
    super.key,
    required this.scrollController,
  });

  @override
  State<SmartHeroSection> createState() => _SmartHeroSectionState();
}

class _SmartHeroSectionState extends State<SmartHeroSection>
    with TickerProviderStateMixin {
  // ── Slide state ──
  int _current = 0;
  int _previous = 0;
  Timer? _timer;

  // ── Scroll-driven opacity ──
  double _heroOpacity = 1.0;

  // ── Background cross-fade ──
  late AnimationController _bgCtrl;
  late Animation<double> _bgAnim;

  // ── Text slide-up + fade ──
  late AnimationController _textCtrl;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    // Background cross-fade
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _bgAnim = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeInOut);

    // Text animation
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textFade = CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut);
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));

    _textCtrl.forward();
    _startTimer();

    // Listen to the ViewModel's scroll controller for fade-out
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    final offset = widget.scrollController.offset;
    setState(() {
      _heroOpacity = (1.0 - offset / 300).clamp(0.0, 1.0);
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) => _advance());
  }

  void _advance({int? to}) {
    final next = to ?? (_current + 1) % kSlides.length;
    if (next == _current) return;
    setState(() {
      _previous = _current;
      _current = next;
    });
    _bgCtrl.forward(from: 0);
    _textCtrl.forward(from: 0);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _timer?.cancel();
    _bgCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    // The whole hero (bg + nav + text + dots) fades as user scrolls
    return Opacity(
      opacity: _heroOpacity,
      child: SizedBox(
        height: screenH,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background: previous slide ──
            BgMedia(path: kSlides[_previous].imagePath, isVideo: kSlides[_current].isVideo,),

            // ── Background: current slide fading in ──
            FadeTransition(
              opacity: _bgAnim,
              child: BgMedia(path: kSlides[_current].imagePath, isVideo: kSlides[_current].isVideo,),
            ),

            // ── Gradient overlay ──
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.black.withOpacity(0.20),
                    Colors.black.withOpacity(0.65),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),

            // ── Centered profile + text ──
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ProfileBadge(
                      accentColor: kSlides[_current].accentColor),
                  const SizedBox(height: 22),
                  SlideTransition(
                    position: _textSlide,
                    child: FadeTransition(
                      opacity: _textFade,
                      child:
                      _SlideTextBlock(slide: kSlides[_current]),
                    ),
                  ),
                ],
              ),
            ),

            // ── Nav bar overlaid on top ──
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _TopNavBar(),
            ),

            // ── Dot indicators ──
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: _DotIndicators(
                count: kSlides.length,
                current: _current,
                accentColor: kSlides[_current].accentColor,
                onTap: (i) {
                  _timer?.cancel();
                  _advance(to: i);
                  _startTimer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TOP NAV BAR
// ─────────────────────────────────────────────
class _TopNavBar extends StatelessWidget {
  const _TopNavBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'YN.',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                      blurRadius: 12,
                      color: Colors.black.withOpacity(0.8)),
                ],
              ),
            ),
            Row(
              children: kNavItems
                  .map((item) => Padding(
                padding: const EdgeInsets.only(left: 28),
                child: _NavLink(label: item),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  const _NavLink({required this.label});
  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          fontSize: 13,
          letterSpacing: 1.4,
          fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
          color: _hovered ? Colors.white : Colors.white70,
          shadows: [
            Shadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.9)),
          ],
        ),
        child: Text(widget.label.toUpperCase()),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  BACKGROUND IMAGE
// ─────────────────────────────────────────────


// ─────────────────────────────────────────────
//  PROFILE BADGE
// ─────────────────────────────────────────────
class _ProfileBadge extends StatelessWidget {
  final Color accentColor;
  const _ProfileBadge({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: accentColor, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.45),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/profile.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF1E1E2E),
                child: Icon(Icons.person, size: 44, color: accentColor),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: accentColor.withOpacity(0.35),
                  width: 1,
                ),
              ),
              child: const Text(
                'Your Name', // ← replace with your name
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  SLIDE TEXT BLOCK
// ─────────────────────────────────────────────
class _SlideTextBlock extends StatelessWidget {
  final SlideData slide;
  const _SlideTextBlock({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          slide.headline,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.85),
                offset: const Offset(0, 3),
              ),
              Shadow(
                  blurRadius: 40,
                  color: Colors.black.withOpacity(0.6)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: 180,
          height: 2.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                slide.accentColor,
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          slide.subline,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            letterSpacing: 1.0,
            color: Colors.white.withOpacity(0.80),
            shadows: [
              Shadow(
                  blurRadius: 14,
                  color: Colors.black.withOpacity(0.9)),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  DOT INDICATORS
// ─────────────────────────────────────────────
class _DotIndicators extends StatelessWidget {
  final int count;
  final int current;
  final Color accentColor;
  final ValueChanged<int> onTap;

  const _DotIndicators({
    required this.count,
    required this.current,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return GestureDetector(
          onTap: () => onTap(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: isActive ? 28 : 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isActive
                  ? accentColor
                  : Colors.white.withOpacity(0.35),
              boxShadow: isActive
                  ? [
                BoxShadow(
                  color: accentColor.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
                  : [],
            ),
          ),
        );
      }),
    );
  }
}