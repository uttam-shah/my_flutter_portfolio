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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1C1C1C) : const Color(0xFF232323);

    return Container(
      color: bgColor,
      width: double.infinity,
      // ✅ Removed fixed height — let content dictate height on mobile
      height: isMobile ? null : 800,
      child: isMobile
          ? SingleChildScrollView(
        // ✅ Wrapped in scroll view to prevent overflow on small devices
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, bottom: 64 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImageContent(context, isMobile: true),
              const SizedBox(height: 24),
              _buildLeftContent(context, isMobile: true),
            ],
          ),
        ),
      )
          : Stack(
        children: [
          //Image part
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: MediaQuery.of(context).size.width * 0.45,
            child: _buildImageContent(context, isMobile: false),
          ),
          // Left content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 80.0, right: 40.0, top: 120, bottom: 40),
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
    final name =
    UserData.name.isNotEmpty ? UserData.name : "Uttam Shah";

    return Column(
      crossAxisAlignment:
      isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Greeting ──────────────────────────────────────────
        Text(
          "Hi There! 👋",
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 20 : 32,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),

        // ── Name + Role ────────────────────────────────────────
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            style: GoogleFonts.poppins(
              // ✅ Scaled down font size for mobile to prevent overflow
              fontSize: isMobile ? 32 : 64,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.15,
              letterSpacing: -1,
            ),
            children: [
              TextSpan(text: "I am $name\n"),
              const TextSpan(text: "Flutter Developer"),
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

        // ── Bio ────────────────────────────────────────────────
        Text(
          "I build high-performance Android & Flutter\napps with clean architecture and great\nuser experience.",
          style: GoogleFonts.poppins(
            // ✅ Scaled font size for mobile
            fontSize: isMobile ? 15 : 22,
            fontWeight: FontWeight.w400,
            color: Colors.white54,
            height: 1.6,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 36),

        // ── CTA Button ─────────────────────────────────────────
        InkWell(
          onTap: () => launchUrl(Uri.parse('mailto:${UserData.email}')),
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: EdgeInsets.symmetric(
              // ✅ Slightly smaller padding on mobile
              horizontal: isMobile ? 24 : 32,
              vertical: isMobile ? 14 : 16,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1db954),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "Contact Me",
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SizedBox(height: isMobile ? 40 : 0),
        if (!isMobile) const Spacer(),

        // ── Contact Info Row ────────────────────────────────────
        // ✅ On mobile: wrap into a column to avoid horizontal overflow
        isMobile
            ? Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildContactInfoBlock("Email", UserData.email,
                isMobile: true),
            const SizedBox(height: 16),
            _buildContactInfoBlock("Phone", UserData.phone,
                isMobile: true),
            const SizedBox(height: 16),
            _buildContactInfoBlock("Location", "New Delhi, India",
                isMobile: true),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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

  Widget _buildContactInfoBlock(String title, String value,
      {bool isMobile = false}) {
    return Column(
      // ✅ Center-align on mobile, left-align on desktop
      crossAxisAlignment:
      isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 13 : 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.w400,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  // Widget _buildImageContent(BuildContext context, {required bool isMobile}) {
  //   final width = MediaQuery.of(context).size.width;
  //
  //   // Square size: reasonable on mobile, capped on large desktops
  //   final double imageSize = isMobile
  //       ? (width * 0.55).clamp(180.0, 280.0)   // bigger than the old width*0.2
  //       : (width * 0.40).clamp(240.0, 460.0);  // capped so it doesn't explode
  //
  //   return Align(
  //     alignment: isMobile ? Alignment.center : Alignment.centerRight,
  //     child: SizedBox(
  //       width: imageSize,
  //       height: imageSize, // square cutout
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(isMobile ? 20 : 0),
  //         child: Image.asset(
  //           'assets/images/uttam_image2.png',
  //           width: imageSize,
  //           height: imageSize,
  //           fit: BoxFit.cover,
  //           // Anchors to the top → face always visible, crops from bottom
  //           alignment: const Alignment(0.0, -0.6),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildImageContent(BuildContext context, {required bool isMobile}) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      width: isMobile ? 420 : double.infinity,
      height: isMobile ? 420 : double.infinity,
      // width: isMobile ? width * 0.2 : double.infinity,
      // height: isMobile ? width * 0.2 : double.infinity,
      child: ClipRect(
        child: Transform.scale(
          scale: 1.4,                          // 👈 Zoom level (2x = zoom into 50% of image)
          alignment: Alignment(0.0, -0.6),
          child: Image.asset(
            'assets/images/uttam_image2.png',
            // width: isMobile ? 320 : double.infinity,
            // height: isMobile ? 320 : double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}