import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_portfolio/views/profile_details_screen.dart';

import '../../core/constants/user_data.dart';

class ProfileBadge extends StatefulWidget {
  final Color accentColor;
  const ProfileBadge({super.key, required this.accentColor});

  @override
  State<ProfileBadge> createState() => _ProfileBadgeState();
}

class _ProfileBadgeState extends State<ProfileBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileDetailsScreen()),
          );
        },
        child: Align(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.accentColor, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: widget.accentColor.withOpacity(0.45),
                          blurRadius: _isHovered ? 36 : 24,
                          spreadRadius: _isHovered ? 8 : 4,
                        ),
                      ],
                    ),
                    child: Hero(
                      tag: 'profile_image_hero',
                      child: ClipOval(
                        child: Transform.scale(
                          scale: 1.8,
                          alignment: const Alignment(0.0, -0.9),
                          child: Image.asset(
                            'assets/images/uttam_image2.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFF1E1E2E),
                              child: Icon(Icons.person, size: 44, color: widget.accentColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
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
              
              // Hover Tooltip: "More information about me"
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: _isHovered ? 1.0 : 0.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.only(top: _isHovered ? 12.0 : 0.0),
                  height: _isHovered ? 32 : 0, 
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.accentColor.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'More information about me',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}