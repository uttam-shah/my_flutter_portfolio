import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {

    final isMobile = ResponsiveLayout.isMobile(context);
    final height = isMobile ? null : MediaQuery.of(context).size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1C1C1C) : const Color(0xFF232323);

    return Container(
      // Using the exact dark background color from the image mockup
      color: bgColor,
      width: double.infinity,
      height: 800,
      child: isMobile
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                children: [
                  _buildLeftContent(context, isMobile: true),
                  const SizedBox(height: 60),
                  _buildImageContent(context, isMobile: true),
                ],
              ),
            )
          : Stack(
              children: [
                // Right side image (absolutely positioned)
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: _buildImageContent(context, isMobile: false),
                ),
                
                // Left side textual content
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80.0, right: 40.0, top: 120, bottom: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildLeftContent(context, isMobile: false),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildLeftContent(BuildContext context, {required bool isMobile}) {
    // Determine the name to show (extracted from UserData or fallback)
    final name = UserData.name.isNotEmpty ? UserData.name : "Uttam Shah";

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isMobile) const SizedBox(height: 40),
        Text(
          "Hi There!",
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 40 : 64,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -1,
            ),
            children: [
              TextSpan(text: "I am $name\n"),
              const TextSpan(text: "Flutter Developer"),
              // The terminal typing cursor effect
              TextSpan(
                text: "|",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "I make the complex simple.",
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 28,
            fontWeight: FontWeight.w400,
            color: Colors.white54,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 48),
        // Action Button
        InkWell(
          onTap: () => launchUrl(Uri.parse('mailto:${UserData.email}')),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1db954), // Green action button from image
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "Contact Me",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        if (!isMobile) const Spacer(),
        if (isMobile) const SizedBox(height: 60),
        
        // Bottom details
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Keep tight bound
          children: [
            _buildContactInfoBlock("Email", UserData.email),
            _buildDivider(),
            _buildContactInfoBlock("Phone", UserData.phone),
            _buildDivider(),
            _buildContactInfoBlock("Location", "New Delhi, India"),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }

  Widget _buildContactInfoBlock(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildImageContent(BuildContext context, {required bool isMobile}) {
    // In desktop, the image spans the right half
    return Container(
      width: isMobile ? 300 : double.infinity,
      height: isMobile ? 400 : double.infinity,
      decoration: const BoxDecoration(
        // For accurate representation we need a placeholder or the actual asset
        // The previous code had "assets/images/uttam_image.png"
      ),
      child: Image.asset(
        'assets/images/uttam_image2.png',
        fit: isMobile ? BoxFit.contain : BoxFit.cover,
        alignment: isMobile ? Alignment.center : Alignment.centerLeft,
      ),
    );
  }
}
