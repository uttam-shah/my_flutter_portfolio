import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';


class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl(String urlText) async {
    final uri = Uri.parse(urlText.startsWith('http') ? urlText : 'https://$urlText');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F0F13) : const Color(0xFFF5F5F7);
    final cardColor = isDark ? const Color(0xFF1E1E24).withOpacity(0.7) : Colors.white.withOpacity(0.7);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Background decorative blobs
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.1),
              ),
            ),
          ),
          // Backdrop filter for the blur effect over the blobs
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),
          
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(color: textColor),
                  pinned: true,
                  title: Text(
                    'About Me',
                    style: GoogleFonts.lexend(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Image Hero
                        Hero(
                          tag: 'profile_image_hero',
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 1.5,
                                alignment: const Alignment(0.0, -0.6),
                                child: Image.asset(
                                  'assets/images/uttam_image2.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: const Color(0xFF1E1E2E),
                                    child: Icon(Icons.person, size: 64, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          UserData.name,
                          style: GoogleFonts.lexend(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          UserData.roleTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Summary Card
                        _buildGlassCard(
                          cardColor: cardColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person_outline, color: Theme.of(context).primaryColor, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Overview',
                                    style: GoogleFonts.lexend(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                UserData.summary,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  height: 1.6,
                                  color: subtitleColor,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Contact Details Card
                        _buildGlassCard(
                          cardColor: cardColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.contact_mail_outlined, color: Theme.of(context).primaryColor, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Contact Information',
                                    style: GoogleFonts.lexend(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildContactRow(
                                primaryColor: Theme.of(context).primaryColor,
                                icon: Icons.email_outlined,
                                label: 'Email',
                                value: UserData.email,
                                textColor: textColor,
                                subtitleColor: subtitleColor,
                                onTap: () => _launchEmail(UserData.email),
                              ),
                              const SizedBox(height: 16),
                              _buildContactRow(
                                primaryColor: Theme.of(context).primaryColor,
                                icon: Icons.phone_outlined,
                                label: 'Phone',
                                value: UserData.phone,
                                textColor: textColor,
                                subtitleColor: subtitleColor,
                                onTap: () => _launchPhone(UserData.phone),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Social Links Card
                        _buildGlassCard(
                          cardColor: cardColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.link, color: Theme.of(context).primaryColor, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Social Profiles',
                                    style: GoogleFonts.lexend(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSocialButton(
                                    icon: FontAwesomeIcons.github,
                                    label: 'GitHub',
                                    color: textColor,
                                    onTap: () => _launchUrl(UserData.github),
                                  ),
                                  _buildSocialButton(
                                    icon: FontAwesomeIcons.linkedin,
                                    label: 'LinkedIn',
                                    color: const Color(0xFF0077b5),
                                    onTap: () => _launchUrl(UserData.linkedin),
                                  ),
                                  _buildSocialButton(
                                    icon: FontAwesomeIcons.twitter,
                                    label: 'Twitter',
                                    color: const Color(0xFF1DA1F2),
                                    onTap: () => _launchUrl(UserData.twitter),
                                  ),
                                  _buildSocialButton(
                                    icon: FontAwesomeIcons.instagram,
                                    label: 'Instagram',
                                    color: const Color(0xFFE1306C),
                                    onTap: () => _launchUrl(UserData.instagram),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48), // Padding at bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Color cardColor, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    required Color textColor,
    required Color subtitleColor,
    required Color primaryColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: primaryColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: subtitleColor,
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: subtitleColor, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required dynamic icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.1),
              border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            ),
            child: FaIcon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
