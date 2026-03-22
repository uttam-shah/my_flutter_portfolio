import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_portfolio/views/widgets/HeroSection/slide_text_block.dart';
import 'package:my_flutter_portfolio/views/widgets/HeroSection/slider_preview_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/user_data.dart';
import '../bg_media.dart';
import '../profle_badge.dart';

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
      imagePath: 'https://cdn.pixabay.com/video/2018/02/09/14214-255797028_large.mp4',
      headline: 'Developing Full‑Stack\nFlutter Apps',
      subline: 'End-to-end, pixel-perfect, blazing fast.',
      accentColor: Colors.white,
      isVideo: true
  ),

  SlideData(
      imagePath: 'https://cdn.pixabay.com/video/2015/08/08/117-135736418_large.mp4',
      headline: 'Architecting Modern\nScalable Systems',
      subline: 'Engineered with clarity, performance, and reliability.',
      accentColor: Colors.white,
      isVideo: true
  ),
  SlideData(
    imagePath: 'https://cdn.pixabay.com/video/2020/10/19/52823-471089056_large.mp4',
      headline: 'Let’s Turn Your Ideas\nInto Real Products',
      subline: 'From concept to production — fast, scalable, reliable.',
    accentColor: Colors.white,
    isVideo: true
  ),

  SlideData(
    imagePath: 'https://cdn.pixabay.com/video/2019/08/30/26419-358778810_large.mp4',
      headline: 'Designing Interfaces\nThat Feel Alive',
      subline: 'Where motion meets meaning — crafted to inspire.',
    accentColor: Colors.white,
    isVideo: true
  ),
  SlideData(
    imagePath: 'https://cdn.pixabay.com/video/2025/04/07/270432_large.mp4',
      headline: 'From Complex Problems\nto Scalable Products',
      subline: 'Driven by strategy. Built with precision.',
    accentColor: Colors.white,
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
      begin: const Offset(-0.18, 0),
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
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _advance());
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

  static const List<SlideIndicatorData> kIndicators = [
    SlideIndicatorData(thumbnailPath: 'assets/images/image1.jpg'),
    SlideIndicatorData(thumbnailPath: 'assets/images/image1.jpg'),
    SlideIndicatorData(thumbnailPath: 'assets/images/image1.jpg'),
    SlideIndicatorData(thumbnailPath: 'assets/images/image1.jpg'),
    SlideIndicatorData(thumbnailPath: 'assets/images/image1.jpg'),
  ];

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
    final screenW = MediaQuery.of(context).size.width;

    // The whole hero (bg + nav + text + dots) fades as user scrolls
    return Opacity(
      opacity: _heroOpacity,
      child: SizedBox(
        height: screenH,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background: previous slide ──
            BgMedia(
              key: ValueKey(kSlides[_current].imagePath),
              path: kSlides[_previous].imagePath,
              isVideo: kSlides[_previous].isVideo,),

            // ── Background: current slide fading in ──
            FadeTransition(
              opacity: _bgAnim,
              child: BgMedia(
                key: ValueKey("fade_${kSlides[_current].imagePath}"),
                path: kSlides[_current].imagePath,
                isVideo: kSlides[_current].isVideo,),
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
            Positioned(

              left: screenW * 0.05,
              top: 0,
              bottom: screenH * 0.28,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // _ProfileBadge(
                    //     accentColor: kSlides[_current].accentColor),
                    // const SizedBox(height: 22),
                    SlideTransition(
                      position: _textSlide,
                      child: FadeTransition(
                        opacity: _textFade,
                        child:
                        SlideTextBlock(slide: kSlides[_current]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Nav bar overlaid on top ──
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _TopNavBar(),
            ),

            // Positioned(
            //   bottom: 62,
            //   right: 32,
            //   child: SlidePreviewIndicators(
            //     slides: kIndicators,
            //     current: _current,
            //     accentColor: kSlides[_current].accentColor,
            //     autoPlayDuration: const Duration(seconds: 4),
            //     onTap: (i) {
            //       _timer?.cancel();
            //       _advance(to: i);
            //       _startTimer();
            //     },
            //   ),
            // ),

            //── Dot indicators ──
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

            Row(
              children: [
                ProfileBadge(
                    accentColor: Colors.white),
                const SizedBox(width: 12),

                Text(
                  UserData.name.split(' ')[0], // "Uttam"
                  style: GoogleFonts.caveat(
                    textStyle: Theme.of(context).textTheme.headlineLarge,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ],
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