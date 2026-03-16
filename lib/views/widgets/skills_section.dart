import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

class _SkillEntry {
  final String name;
  final dynamic icon;
  final Color color;

  const _SkillEntry({
    required this.name,
    required this.icon,
    required this.color,
  });
}

final List<_SkillEntry> _skills = [
  const _SkillEntry(name: 'Flutter',        icon: FontAwesomeIcons.mobile,        color: Color(0xFF54C5F8)),
  const _SkillEntry(name: 'Dart',           icon: FontAwesomeIcons.code,           color: Color(0xFF00B4AB)),
  const _SkillEntry(name: 'Kotlin',         icon: FontAwesomeIcons.k,              color: Color(0xFF7F52FF)),
  const _SkillEntry(name: 'Java',           icon: FontAwesomeIcons.java,           color: Color(0xFFE76F00)),
  const _SkillEntry(name: 'Android',        icon: FontAwesomeIcons.android,        color: Color(0xFF3DDC84)),
  const _SkillEntry(name: 'Jetpack',        icon: FontAwesomeIcons.layerGroup,     color: Color(0xFF4285F4)),
  const _SkillEntry(name: 'Spring Boot',    icon: FontAwesomeIcons.leaf,           color: Color(0xFF6DB33F)),
  const _SkillEntry(name: 'REST APIs',      icon: FontAwesomeIcons.plug,           color: Color(0xFF00BCD4)),
  const _SkillEntry(name: 'Firebase',       icon: FontAwesomeIcons.fire,           color: Color(0xFFFFCA28)),
  const _SkillEntry(name: 'MySQL',          icon: FontAwesomeIcons.database,       color: Color(0xFF4479A1)),
  const _SkillEntry(name: 'SQLite',         icon: FontAwesomeIcons.server,         color: Color(0xFF7EC8E3)),
  const _SkillEntry(name: 'AWS',            icon: FontAwesomeIcons.aws,            color: Color(0xFFFF9900)),
  const _SkillEntry(name: 'Git',            icon: FontAwesomeIcons.gitAlt,         color: Color(0xFFF05032)),
  const _SkillEntry(name: 'BLE / IoT',      icon: FontAwesomeIcons.bluetooth,      color: Color(0xFF0082FC)),
  const _SkillEntry(name: 'Postman',        icon: FontAwesomeIcons.paperPlane,     color: Color(0xFFFF6C37)),
  const _SkillEntry(name: 'AI Integration', icon: FontAwesomeIcons.robot,          color: Color(0xFF5ABCB5)),
];

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    // Keep the "Our Services" light background vibe or adapt to theme
    final bgColor = isDark ? const Color(0xFF141F2B) : const Color(0xFFF8F9FA);
    final titleColor = isDark ? Colors.white : const Color(0xFF1B2A40);

    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 60.0,
        vertical: 80.0,
      ),
      child: Column(
        children: [
          // Section Title
          Text(
            'MY SKILLS',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 36 : 48,
              fontWeight: FontWeight.w800,
              color: titleColor,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xFF1CB4B8),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 60),

          // Masonry Grid View + Experience Panel
          isMobile
              ? Column(
                  children: [
                    _buildGrid(isMobile, isTablet, isDark),
                    const SizedBox(height: 48),
                    _ExperiencePanel(isDark: isDark),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildGrid(isMobile, isTablet, isDark),
                    ),
                    // const SizedBox(width: 32),
                    // SizedBox(
                    //   width: 200,
                    //   child: _ExperiencePanel(isDark: isDark),
                    // ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildGrid(bool isMobile, bool isTablet, bool isDark) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1400),
      child: MasonryGridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
        ),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemCount: _skills.length,
        itemBuilder: (context, index) {
          return _SkillCard(
            entry: _skills[index],
            isDark: isDark,
          );
        },
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final _SkillEntry entry;
  final bool isDark;

  const _SkillCard({
    required this.entry,
    required this.isDark,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    // Light mode uses white cards like the "Services" design
    final cardBg = widget.isDark ? const Color(0xFF1E2D3D) : Colors.white;
    final titleColor = widget.isDark ? Colors.white : const Color(0xFF1B2A40);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: widget.entry.color.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 15),
              )
            else
              BoxShadow(
                color: widget.isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
          border: Border.all(
            color: _hovered
                ? widget.entry.color.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            AnimatedScale(
              scale: _hovered ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: FaIcon(
                widget.entry.icon,
                color: widget.entry.color,
                size: 38,
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              widget.entry.name,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: titleColor,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Experience Panel ─────────────────────────────────────────────────────────
class _ExperiencePanel extends StatelessWidget {
  final bool isDark;

  const _ExperiencePanel({required this.isDark});

  Future<void> _downloadCV() async {
    const cvUrl = 'https://drive.google.com/your-cv-link';
    final uri = Uri.parse(cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final panelBg = isDark ? const Color(0xFF1E2D3D) : Colors.white;
    final primaryTeal = const Color(0xFF1CB4B8);
    final textColor = isDark ? Colors.white : const Color(0xFF1B2A40);
    final subTextColor = isDark ? Colors.white70 : const Color(0xFF6B7A90);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        color: panelBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryTeal.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryTeal.withValues(alpha: 0.12),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '1.5+',
            style: GoogleFonts.inter(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              color: primaryTeal,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Years',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          Text(
            'Experience',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          Text(
            'Working',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: subTextColor,
            ),
          ),
          const SizedBox(height: 24),
          _HoverCVButton(
            primaryTeal: primaryTeal,
            onTap: _downloadCV,
          ),
        ],
      ),
    );
  }
}

// ─── Hover CV Button ──────────────────────────────────────────────────────────
class _HoverCVButton extends StatefulWidget {
  final Color primaryTeal;
  final VoidCallback onTap;

  const _HoverCVButton({required this.primaryTeal, required this.onTap});

  @override
  State<_HoverCVButton> createState() => _HoverCVButtonState();
}

class _HoverCVButtonState extends State<_HoverCVButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? widget.primaryTeal : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.primaryTeal, width: 1.5),
          ),
          child: Text(
            'DOWNLOAD CV',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _hovered ? Colors.white : widget.primaryTeal,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
