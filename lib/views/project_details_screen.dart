import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_portfolio/models/user_models.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
// Note: url_launcher might be used here if it's already in pubspec.yaml. 
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final WorkModel work;

  const ProjectDetailsScreen({super.key, required this.work});

  Future<void> _launchUrl(String? urlString) async {
    if (urlString == null) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF000000) : theme.colorScheme.surface;
    final accentTeal = isDark ? const Color(0xFF4AC2B7) : theme.primaryColor;
    final textWhite = theme.colorScheme.onSurface;
    final textGray = isDark ? const Color(0xFF8B949E) : theme.colorScheme.onSurface.withValues(alpha: 0.6);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textWhite),
        title: Text(
          work.title,
          style: GoogleFonts.lexend(
            color: textWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24.0 : 80.0,
          vertical: 40.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              work.title,
              style: GoogleFonts.lexend(
                fontSize: isMobile ? 32 : 48,
                fontWeight: FontWeight.bold,
                color: textWhite,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              work.subtitle,
              style: GoogleFonts.lexend(
                fontSize: 20,
                color: accentTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),

            // Description and Links split vs stack depending on mobile
            if (isMobile) 
              _buildInfoColumn(isMobile, textWhite, textGray, accentTeal)
            else 
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildInfoColumn(isMobile, textWhite, textGray, accentTeal),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: _buildLinksColumn(textWhite, textGray, accentTeal),
                  )
                ],
              ),
            
            if (isMobile) ...[
              const SizedBox(height: 40),
              _buildLinksColumn(textWhite, textGray, accentTeal),
            ],

            const SizedBox(height: 60),
            Divider(color: textGray.withValues(alpha: 0.2)),
            const SizedBox(height: 40),

            // Screenshots
            Text(
              "SCREENSHOTS",
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: textGray.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: work.screenshots.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: textGray.withValues(alpha: 0.2)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      work.screenshots[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(bool isMobile, Color textWhite, Color textGray, Color accentTeal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ABOUT THE PROJECT",
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: textGray.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          work.description,
          style: GoogleFonts.lexend(
            fontSize: 16,
            color: textGray,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "TOOLS & TECHNOLOGIES",
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: textGray.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: work.tools.map((t) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: accentTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accentTeal.withValues(alpha: 0.3)),
            ),
            child: Text(
              t,
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: textWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildLinksColumn(Color textWhite, Color textGray, Color accentTeal) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: textGray.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: textGray.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "LINKS",
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: textGray.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 24),
          if (work.projectUrl != null)
            _buildLinkButton("Live Project / App", Icons.public, work.projectUrl!, textWhite, accentTeal),
          if (work.projectUrl != null && work.githubUrl != null)
            const SizedBox(height: 16),
          if (work.githubUrl != null)
            _buildLinkButton("Source Code", Icons.code, work.githubUrl!, textWhite, accentTeal),
          if (work.projectUrl == null && work.githubUrl == null)
            Text(
              "No public links available.",
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: textGray,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLinkButton(String label, IconData icon, String url, Color textWhite, Color accentTeal) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: accentTeal.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: accentTeal, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.lexend(
                  color: textWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: textWhite.withValues(alpha: 0.5), size: 14),
          ],
        ),
      ),
    );
  }
}
