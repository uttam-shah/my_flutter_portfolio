import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileBadge extends StatelessWidget {
  final Color accentColor;
  const ProfileBadge({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: 60,
            height: 60,
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
              child: Transform.scale(
                scale: 1.8,
                alignment: Alignment(0.0, -0.9),
                child: Image.asset(
                  'assets/images/uttam_image2.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF1E1E2E),
                    child: Icon(Icons.person, size: 44, color: accentColor),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 12),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(30),
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          //     child: AnimatedContainer(
          //       duration: const Duration(milliseconds: 600),
          //       padding:
          //       const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
          //       decoration: BoxDecoration(
          //         color: Colors.white.withOpacity(0.10),
          //         borderRadius: BorderRadius.circular(30),
          //         border: Border.all(
          //           color: accentColor.withOpacity(0.35),
          //           width: 1,
          //         ),
          //       ),
          //       child: const Text(
          //         'Your Name', // ← replace with your name
          //         style: TextStyle(
          //           fontSize: 13,
          //           letterSpacing: 2.2,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}