import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ─── Skill Entry ─────────────────────────────────────────────────────────────
class _SkillEntry {
  final String name;
  final FaIconData icon;
  final Color color;

  const _SkillEntry({
    required this.name,
    required this.icon,
    required this.color,
  });
}

// ─── Skill Data ──────────────────────────────────────────────────────────────
final List<_SkillEntry> _skills = [
  _SkillEntry(name: 'Flutter',        icon: FontAwesomeIcons.mobile,        color: const Color(0xFF54C5F8)),
  _SkillEntry(name: 'Dart',           icon: FontAwesomeIcons.code,           color: const Color(0xFF00B4AB)),
  _SkillEntry(name: 'Kotlin',         icon: FontAwesomeIcons.k,              color: const Color(0xFF7F52FF)),
  _SkillEntry(name: 'Java',           icon: FontAwesomeIcons.java,           color: const Color(0xFFE76F00)),
  _SkillEntry(name: 'Android',        icon: FontAwesomeIcons.android,        color: const Color(0xFF3DDC84)),
  _SkillEntry(name: 'Jetpack',        icon: FontAwesomeIcons.layerGroup,     color: const Color(0xFF4285F4)),
  _SkillEntry(name: 'Spring Boot',    icon: FontAwesomeIcons.leaf,           color: const Color(0xFF6DB33F)),
  _SkillEntry(name: 'REST APIs',      icon: FontAwesomeIcons.plug,           color: const Color(0xFF00BCD4)),
  _SkillEntry(name: 'Firebase',       icon: FontAwesomeIcons.fire,           color: const Color(0xFFFFCA28)),
  _SkillEntry(name: 'MySQL',          icon: FontAwesomeIcons.database,       color: const Color(0xFF4479A1)),
  _SkillEntry(name: 'SQLite',         icon: FontAwesomeIcons.server,         color: const Color(0xFF7EC8E3)),
  _SkillEntry(name: 'AWS',            icon: FontAwesomeIcons.aws,            color: const Color(0xFFFF9900)),
  _SkillEntry(name: 'Git',            icon: FontAwesomeIcons.gitAlt,         color: const Color(0xFFF05032)),
  _SkillEntry(name: 'BLE / IoT',      icon: FontAwesomeIcons.bluetooth,      color: const Color(0xFF0082FC)),
  _SkillEntry(name: 'Postman',        icon: FontAwesomeIcons.paperPlane,     color: const Color(0xFFFF6C37)),
  _SkillEntry(name: 'AI Integration', icon: FontAwesomeIcons.robot,          color: const Color(0xFF5ABCB5)),
];

// ─── Section ──────────────────────────────────────────────────────────────────
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    // Slightly lighter than the footer (0x0A1118 dark / 0x1B2A40 light)
    // so both sections feel distinct even on the same dark background
    final bgColor = isDark ? const Color(0xFF141F2B) : const Color(0xFF243345);
    final primaryTeal = theme.primaryColor;
    // final bgColor = isDark ? const Color(0xFF1C1C1C) : const Color(0xFF232323);

    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 60.0,
        vertical: 70.0,
      ),
      child: Column(
        children: [
          // ── Title ──────────────────────────────────────────────────────────
          Text(
            'MY SKILLS',
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 4,
              color: primaryTeal,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 48),

          // ── Body: Grid + Stats panel ────────────────────────────────────────
          isMobile
              ? Column(
                  children: [
                    _SkillsGrid(
                      skills: _skills,
                      crossAxisCount: 3,
                      isDark: isDark,
                      primaryTeal: primaryTeal,
                    ),
                    const SizedBox(height: 32),
                    _ExperiencePanel(primaryTeal: primaryTeal, isDark: isDark),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _SkillsGrid(
                        skills: _skills,
                        crossAxisCount: isTablet ? 3 : 4,
                        isDark: isDark,
                        primaryTeal: primaryTeal,
                      ),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 200,
                      child: _ExperiencePanel(
                        primaryTeal: primaryTeal,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

// ─── Skills Grid ──────────────────────────────────────────────────────────────
class _SkillsGrid extends StatelessWidget {
  final List<_SkillEntry> skills;
  final int crossAxisCount;
  final bool isDark;
  final Color primaryTeal;

  const _SkillsGrid({
    required this.skills,
    required this.crossAxisCount,
    required this.isDark,
    required this.primaryTeal,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        return _SkillLogoCard(
          entry: skills[index],
          isDark: isDark,
        );
      },
    );
  }
}

// ─── Skill Logo Card ──────────────────────────────────────────────────────────
class _SkillLogoCard extends StatefulWidget {
  final _SkillEntry entry;
  final bool isDark;

  const _SkillLogoCard({required this.entry, required this.isDark});

  @override
  State<_SkillLogoCard> createState() => _SkillLogoCardState();
}

class _SkillLogoCardState extends State<_SkillLogoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBg = widget.isDark
        ? const Color(0xFF1E2D3D)
        : const Color(0xFF2E3F52);
    final borderColor = _hovered
        ? widget.entry.color.withValues(alpha: 0.8)
        : Colors.white.withValues(alpha: 0.08);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _hovered
              ? widget.entry.color.withValues(alpha: widget.isDark ? 0.12 : 0.08)
              : cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.entry.color.withValues(alpha: 0.28),
                    blurRadius: 18,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: _hovered ? 1.18 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: FaIcon(
                widget.entry.icon,
                color: widget.entry.color,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.entry.name,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _hovered
                    ? widget.entry.color
                    : Colors.white.withValues(alpha: 0.60),
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Experience Panel ─────────────────────────────────────────────────────────
class _ExperiencePanel extends StatelessWidget {
  final Color primaryTeal;
  final bool isDark;

  const _ExperiencePanel({required this.primaryTeal, required this.isDark});

  Future<void> _downloadCV() async {
    // Replace with your actual Google Drive / CV URL
    const cvUrl = 'https://drive.google.com/your-cv-link';
    final uri = Uri.parse(cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final panelBg = isDark ? const Color(0xFF1E2D3D) : const Color(0xFF2E3F52);
    final textColor = Colors.white;
    final subTextColor = Colors.white70;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 52,
              fontWeight: FontWeight.w800,
              color: primaryTeal,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Years',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          Text(
            'Experience',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          Text(
            'Working',
            style: TextStyle(
              fontFamily: 'Inter',
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
            style: TextStyle(
              fontFamily: 'Inter',
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
