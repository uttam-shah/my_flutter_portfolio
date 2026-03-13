import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_portfolio/models/user_models.dart';

class WorkSection extends StatefulWidget {
  const WorkSection({super.key});

  @override
  State<WorkSection> createState() => _WorkSectionState();
}

class _WorkSectionState extends State<WorkSection> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < UserData.works.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Background color mimicking the image for dark mode, adapting for light mode
    final bgColor = isDark ? const Color(0xFF0A0F1B) : theme.colorScheme.surface;
    final accentTeal = isDark ? const Color(0xFF4AC2B7) : theme.primaryColor;
    final textWhite = theme.colorScheme.onSurface;
    final textGray = isDark ? const Color(0xFF8B949E) : theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 80.0,
        vertical: 80.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                "My ",
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 40 : 56,
                  fontWeight: FontWeight.bold,
                  color: textWhite,
                ),
              ),
              Text(
                "Work",
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 40 : 56,
                  fontWeight: FontWeight.bold,
                  color: accentTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: textGray.withValues(alpha: 0.2), thickness: 1),
          const SizedBox(height: 60),

          // Horizontal Page View and Arrows
          Stack(
            alignment: Alignment.center,
            children: [
              // Page View
              SizedBox(
                height: isMobile ? 600 : 450, // Height is taller on mobile since it stacks
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: UserData.works.length,
                  itemBuilder: (context, index) {
                    final work = UserData.works[index];
                    return _buildWorkItem(work, index, isMobile, textWhite, textGray, accentTeal);
                  },
                ),
              ),

              // Navigation Arrows (Desktop/Tablet)
              if (!isMobile) ...[
                Positioned(
                  left: 0,
                  child: _buildNavArrow(Icons.arrow_back, _prevPage, _currentPage > 0, textWhite),
                ),
                Positioned(
                  right: 0,
                  child: _buildNavArrow(Icons.arrow_forward, _nextPage, _currentPage < UserData.works.length - 1, textWhite),
                ),
              ],
            ],
          ),

          const SizedBox(height: 60),

          // Page Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              UserData.works.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? accentTeal : Colors.transparent,
                  border: Border.all(
                    color: _currentPage == index ? accentTeal : textGray.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavArrow(IconData icon, VoidCallback onTap, bool isEnabled, Color iconColor) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isEnabled ? 1.0 : 0.3,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withValues(alpha: 0.05),
            border: Border.all(color: iconColor.withValues(alpha: 0.1)),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
      ),
    );
  }

  Widget _buildWorkItem(WorkModel work, int index, bool isMobile, Color textWhite, Color textGray, Color accentTeal) {
    final numberStr = (index + 1).toString().padLeft(2, '0');

    final leftContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              numberStr,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 48 : 72,
                fontWeight: FontWeight.w900,
                color: textGray.withValues(alpha: 0.3),
                height: 1.0,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    work.title,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: textWhite,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    work.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: textGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "TOOLS & FEATURES",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: textGray.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    work.tools.join(", "),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: textGray,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );

    final rightContent = Container(
      width: double.infinity, // takes available space
      decoration: BoxDecoration(
        color: textWhite.withValues(alpha: 0.05), // Placeholder for image
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textWhite.withValues(alpha: 0.1)),
      ),
      child: Center(
        child: Text(
          "Image Placeholder\n(Add your project image)",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: textGray.withValues(alpha: 0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            leftContent,
            const SizedBox(height: 40),
            Expanded(child: rightContent),
          ],
        ),
      );
    }

    // Desktop/Tablet
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100), // padding to avoid arrows
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 2, child: leftContent),
          const SizedBox(width: 40),
          Expanded(flex: 3, child: rightContent),
        ],
      ),
    );
  }
}
