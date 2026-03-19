import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tech_stack_game.dart';

class TechStackSection extends StatefulWidget {
  const TechStackSection({super.key});

  @override
  State<TechStackSection> createState() => _TechStackSectionState();
}

class _TechStackSectionState extends State<TechStackSection> {
  late final TechStackGame _game;

  @override
  void initState() {
    super.initState();
    _game = TechStackGame();
  }

  @override
  Widget build(BuildContext context) {
    // Determine responsive height
    final height = MediaQuery.of(context).size.height;
    
    return Container(
      height: height > 800 ? height : 800,
      width: double.infinity,
      color: const Color(0xFF111111), // Dark bg matching physics space
      child: Stack(
        children: [
          // Physics Engine Layer
          Positioned.fill(
            child: GameWidget(game: _game),
          ),
          
          // UI Overlay
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: IgnorePointer( // Let touches pass through to physics
              child: Text(
                "My Techstack",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: [
                     Shadow(
                       color: Colors.black.withValues(alpha: 0.5),
                       blurRadius: 10,
                     ),
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
