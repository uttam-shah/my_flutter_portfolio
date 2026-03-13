import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/core/theme/app_colors.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final height = MediaQuery.of(context).size.height;

    // If mobile, we stack vertically
    if (isMobile) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
             _buildLeftContent(context),
             const SizedBox(height: 40),
             _buildCenterImagePlaceholder(context),
             const SizedBox(height: 40),
             _buildRightContent(context),
          ],
        ),
      );
    }

    // Desktop/Tablet Layout Stack
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Brush shape + User Image
          _buildCenterImagePlaceholder(context),
          
          // Foreground Content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildLeftContent(context)
                    )
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _buildRightContent(context)
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterImagePlaceholder(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Brush Placeholder (Abstract rotated container)
        // Transform.rotate(
        //   angle: -0.2, // Slight tilt
        //   child: Container(
        //     width: 450,
        //     height: 550,
        //     decoration: BoxDecoration(
        //       color: theme.primaryColor,
        //       borderRadius: BorderRadius.circular(100),
        //     ),
        //   ),
        // ),
        // User Image Placeholder
        Align(
          alignment: Alignment.bottomCenter,
          // child: Container(
          //   width: 350,
          //   height: 500,
          //   decoration: BoxDecoration(
          //     color: AppColors.accentYellow.withValues(alpha: 0.9),
          //     borderRadius: const BorderRadius.only(
          //       topLeft: Radius.circular(30),
          //       topRight: Radius.circular(30),
          //     ),
          //   ),
          //   child: Center(
          //     child: Image.asset('assets/images/uttam_image.png', fit: BoxFit.cover),
          //     // child: Text(
          //     //   "Your Image Here\n(Add transparent PNG)",
          //     //   textAlign: TextAlign.center,
          //     //   style: theme.textTheme.titleMedium?.copyWith(
          //     //     color: Colors.black54,
          //     //     fontWeight: FontWeight.bold,
          //     //   ),
          //     // ),
          //   ),
          // ),
          child: Center(
            child: Image.asset('assets/images/uttam_image.png', fit: BoxFit.cover),
            // child: Text(
            //   "Your Image Here\n(Add transparent PNG)",
            //   textAlign: TextAlign.center,
            //   style: theme.textTheme.titleMedium?.copyWith(
            //     color: Colors.black54,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hey There,\nI'm ${UserData.name.split(' ')[0]}",
          style: theme.textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
            height: 1.1,
            fontSize: isMobile ? 48 : 64,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () => launchUrl(Uri.parse('mailto:${UserData.email}')),
          child: Text(
            UserData.email,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.accentRed, 
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.accentRed,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        SizedBox(height: isMobile ? 40 : 120),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "1.5+",
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "YEARS\nEXPERIENCE",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                height: 1.3,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightContent(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: Text(
            "I design beautifully simple\nthings, And I love what i do.",
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.5,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        SizedBox(height: isMobile ? 40 : 150),
        Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: theme.colorScheme.onSurface, width: 2),
              ),
              child: Center(
                child: Icon(Icons.park, size: 40, color: theme.colorScheme.onSurface),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "DEV CERTIFIED\nPROFESSIONAL\nUI/UX EXPERT",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
