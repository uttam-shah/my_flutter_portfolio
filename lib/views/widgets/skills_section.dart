import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/core/theme/app_colors.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    // Dynamic grid layout mapping categories to icons
    final iconMapping = {
      "Programming Languages": FontAwesomeIcons.code,
      "Mobile Development": FontAwesomeIcons.mobileScreenButton,
      "Backend Development": FontAwesomeIcons.server,
      "Databases": FontAwesomeIcons.database,
      "Cloud & Services": FontAwesomeIcons.cloud,
      "Tools": FontAwesomeIcons.toolbox,
      "Other": FontAwesomeIcons.lightbulb,
    };

    final colorMapping = {
      "Programming Languages": AppColors.accentGreen,
      "Mobile Development": AppColors.accentYellow,
      "Backend Development": theme.primaryColor,
      "Databases": AppColors.accentRed,
      "Cloud & Services": theme.primaryColor,
      "Tools": AppColors.accentGreen,
      "Other": AppColors.accentYellow,
    };

    return Container(
      color: theme.brightness == Brightness.light
          ? Colors.grey.shade50
          : theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 80.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "What do I help with?",
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Skills Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 2.5 : 2.0,
            ),
            itemCount: UserData.skills.length,
            itemBuilder: (context, index) {
              final skill = UserData.skills[index];
              final icon = iconMapping[skill.category] ?? FontAwesomeIcons.circleCheck;
              final accentColor = colorMapping[skill.category] ?? theme.primaryColor;

              return HoverSkillCard(
                category: skill.category,
                skills: skill.skills,
                iconWidget: FaIcon(
                  icon,
                  color: accentColor,
                  size: 24,
                ),
                accentColor: accentColor,
              );
            },
          ),
        ],
      ),
    );
  }
}

class HoverSkillCard extends StatefulWidget {
  final String category;
  final List<String> skills;
  final Widget iconWidget;
  final Color accentColor;

  const HoverSkillCard({
    super.key,
    required this.category,
    required this.skills,
    required this.iconWidget,
    required this.accentColor,
  });

  @override
  State<HoverSkillCard> createState() => _HoverSkillCardState();
}

class _HoverSkillCardState extends State<HoverSkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: widget.accentColor.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
          ],
          border: Border.all(
            color: isHovered ? widget.accentColor.withOpacity(0.5) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: widget.iconWidget,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.category,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.skills.join(" • "),
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
