import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      color: theme.colorScheme.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 80.0,
        vertical: 40.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              if (!isMobile)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "US.",
                        style: GoogleFonts.caveat(
                          textStyle: theme.textTheme.headlineLarge,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Building digital products, brands, and experience.",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                
              Expanded(
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Let's make something\namazing together.",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.right,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Start by saying hi",
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse('mailto:${UserData.email}');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      child: Text(
                        UserData.email,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Divider(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          const SizedBox(height: 20),
          isMobile
              ? Column(
                  children: [
                    _buildSocialLinks(context),
                    const SizedBox(height: 16),
                    Text(
                      "© ${DateTime.now().year} Uttam Shah. All Rights Reserved.",
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "© ${DateTime.now().year} Uttam Shah. All Rights Reserved.",
                      style: theme.textTheme.bodySmall,
                    ),
                    _buildSocialLinks(context),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(context, FontAwesomeIcons.linkedinIn, 'https://${UserData.linkedin}'),
        const SizedBox(width: 16),
        _buildSocialIcon(context, FontAwesomeIcons.instagram, 'https://${UserData.instagram}'),
        const SizedBox(width: 16),
        _buildSocialIcon(context, FontAwesomeIcons.twitter, 'https://${UserData.twitter}'),
        const SizedBox(width: 16),
        _buildSocialIcon(context, FontAwesomeIcons.github, 'https://${UserData.github}'),
      ],
    );
  }

  Widget _buildSocialIcon(BuildContext context, dynamic icon, String urlString) {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(urlString);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),
        ),
        child: FaIcon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
