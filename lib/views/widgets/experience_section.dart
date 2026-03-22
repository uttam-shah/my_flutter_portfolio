import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final isDark = theme.brightness == Brightness.dark;
    final textGray = isDark ? const Color(0xFF8B949E) : theme.colorScheme.onSurface.withValues(alpha: 0.6);
    final titleColor = isDark ? Colors.white : const Color(0xFF1B2A40);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 80.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "My Work Experience ",
                style: GoogleFonts.lexend(
                  fontSize: isMobile ? 40 : 56,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: textGray.withValues(alpha: 0.2), thickness: 1),
          const SizedBox(height: 60),
          
          // Timeline logic
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: UserData.experience.length,
            itemBuilder: (context, index) {
              final exp = UserData.experience[index];
              return _buildExperienceTimelineBlock(context, exp, isLast: index == UserData.experience.length - 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTimelineBlock(BuildContext context, dynamic exp, {bool isLast = false}) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Company & Duration (Desktop/Tablet)
          if (!isMobile)
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    exp.company,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exp.duration,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
          // Middle: Timeline Line & Dot
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: isMobile ? 4 : 6, left: 16, right: 32),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.scaffoldBackgroundColor,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.4),
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 32),
                    width: 2,
                    color: theme.primaryColor.withOpacity(0.3),
                  ),
                ),
            ],
          ),

          // Right side: Role & Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.role,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isMobile) ...[
                    const SizedBox(height: 4),
                    Text(
                      "${exp.company} • ${exp.duration}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  
                  // Descriptions
                  ...exp.descriptions.map<Widget>((desc) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, right: 12.0),
                          child: Icon(Icons.circle, size: 6, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                        ),
                        Expanded(
                          child: Text(
                            desc,
                            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),

                  // Links (if any)
                  if (exp.linkText != null) ...[
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        // Launch demo link or play store link
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.link, size: 16, color: theme.primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            exp.linkText!,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
