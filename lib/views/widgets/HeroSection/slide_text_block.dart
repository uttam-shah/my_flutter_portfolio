
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_portfolio/views/widgets/HeroSection/smart_hero_section.dart';

class SlideTextBlock extends StatelessWidget {
  final SlideData slide;
  const SlideTextBlock({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          slide.headline,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            textStyle: Theme.of(context).textTheme.headlineLarge,
            fontWeight: FontWeight.bold,
            fontSize: 66,
            color: Colors.white,
          ),
          // style: TextStyle(
          //   fontSize: 48,
          //   fontWeight: FontWeight.bold,
          //   height: 1.15,
          //   letterSpacing: -0.5,
          //   color: Colors.white,
          //   shadows: [
          //     Shadow(
          //       blurRadius: 20,
          //       color: Colors.black.withOpacity(0.85),
          //       offset: const Offset(0, 3),
          //     ),
          //     Shadow(
          //         blurRadius: 40,
          //         color: Colors.black.withOpacity(0.6)),
          //   ],
          //
          // ),
        ),
        // const SizedBox(height: 14),
        // AnimatedContainer(
        //   duration: const Duration(milliseconds: 600),
        //   width: 180,
        //   height: 2.5,
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Colors.transparent,
        //         slide.accentColor,
        //         Colors.transparent,
        //       ],
        //     ),
        //     borderRadius: BorderRadius.circular(2),
        //   ),
        // ),
        const SizedBox(height: 14),
        Text(
          slide.subline,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            textStyle: Theme.of(context).textTheme.headlineLarge,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
          // style: TextStyle(
          //   fontSize: 15,
          //   letterSpacing: 1.0,
          //   color: Colors.white.withOpacity(0.80),
          //   shadows: [
          //     Shadow(
          //         blurRadius: 14,
          //         color: Colors.black.withOpacity(0.9)),
          //   ],
          // ),
        ),
      ],
    );
  }
}