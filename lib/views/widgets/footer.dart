import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  // ─── Color helpers ────────────────────────────────────────────────────────
  static const Color _darkBg = Color(0xFF0A1118);       // footer bg (dark)
  static const Color _darkCard = Color(0xFF111B24);      // slightly lighter than bg

  // light theme: very dark navy so it reads as "dark footer" even in light mode
  static const Color _lightBg  = Color(0xFF1B2A40);
  static const Color _lightCard = Color(0xFF243345);

  // ─── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final primary = Theme.of(context).primaryColor;

    final bg   = isDark ? _darkBg   : _lightBg;
    final card = isDark ? _darkCard : _lightCard;

    final bgColor = isDark ? const Color(0xFF1C1C1C) : const Color(0xFF232323);

    const bodyColor  = Color(0xFFADBDCC);
    const titleColor = Colors.white;

    return Container(
      color: bgColor,
      child: Column(
        children: [
          // ── Top subscribe-style banner ────────────────────────────────────
          Container(
            color: card,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: 24,
            ),
            child: isMobile
                ? Column(
                    children: [
                      _BannerText(primary: primary),
                      const SizedBox(height: 16),
                      _EmailBar(primary: primary),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _BannerText(primary: primary)),
                      const SizedBox(width: 40),
                      Expanded(child: _EmailBar(primary: primary)),
                    ],
                  ),
          ),

          // ── Main columns ──────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: 50,
            ),
            child: isMobile || isTablet
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AboutColumn(bodyColor: bodyColor, titleColor: titleColor),
                      const SizedBox(height: 36),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _LinksColumn(
                              titleColor: titleColor,
                              bodyColor: bodyColor,
                              primary: primary,
                            ),
                          ),
                          Expanded(
                            child: _ContactColumn(
                              titleColor: titleColor,
                              bodyColor: bodyColor,
                              primary: primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _AboutColumn(
                            bodyColor: bodyColor, titleColor: titleColor),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 2,
                        child: _LinksColumn(
                          titleColor: titleColor,
                          bodyColor: bodyColor,
                          primary: primary,
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 3,
                        child: _ContactColumn(
                          titleColor: titleColor,
                          bodyColor: bodyColor,
                          primary: primary,
                        ),
                      ),
                    ],
                  ),
          ),

          // ── Divider ───────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
            child: Divider(color: Colors.white.withValues(alpha: 0.08)),
          ),

          // ── Bottom bar ────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: 20,
            ),
            child: isMobile
                ? Column(
                    children: [
                      _SocialRow(primary: primary),
                      const SizedBox(height: 14),
                      _CopyrightText(),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CopyrightText(),
                      _SocialRow(primary: primary),
                    ],
                  ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─── Banner text widget ───────────────────────────────────────────────────────
class _BannerText extends StatelessWidget {
  final Color primary;
  const _BannerText({required this.primary});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        children: [
          const TextSpan(text: 'Let\'s build something '),
          TextSpan(
            text: 'amazing',
            style: TextStyle(color: primary),
          ),
          const TextSpan(text: ' together.'),
        ],
      ),
    );
  }
}

// ─── Email bar widget ─────────────────────────────────────────────────────────
class _EmailBar extends StatelessWidget {
  final Color primary;
  const _EmailBar({required this.primary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse('mailto:${UserData.email}');
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.envelope, color: primary, size: 16),
            const SizedBox(width: 10),
            Text(
              UserData.email,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── About column ─────────────────────────────────────────────────────────────
class _AboutColumn extends StatelessWidget {
  final Color bodyColor;
  final Color titleColor;
  const _AboutColumn({required this.bodyColor, required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          UserData.summary,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            color: bodyColor,
            height: 1.7,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// ─── Quick links column ───────────────────────────────────────────────────────
class _LinksColumn extends StatelessWidget {
  final Color titleColor;
  final Color bodyColor;
  final Color primary;
  const _LinksColumn({
    required this.titleColor,
    required this.bodyColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 14),
        ...[
          ('Home', '#hero'),
          ('Projects', '#works'),
          ('Skills', '#skills'),
          ('Experience', '#experience'),
          ('Education', '#education'),
        ].map((e) => _LinkItem(label: e.$1, color: bodyColor, primary: primary)),
      ],
    );
  }
}

class _LinkItem extends StatefulWidget {
  final String label;
  final Color color;
  final Color primary;
  const _LinkItem({required this.label, required this.color, required this.primary});

  @override
  State<_LinkItem> createState() => _LinkItemState();
}

class _LinkItemState extends State<_LinkItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: _hovered ? 14 : 0,
              height: 1.5,
              color: widget.primary,
            ),
            if (_hovered) const SizedBox(width: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.5,
                color: _hovered ? widget.primary : widget.color,
                fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Contact column ───────────────────────────────────────────────────────────
class _ContactColumn extends StatelessWidget {
  final Color titleColor;
  final Color bodyColor;
  final Color primary;
  const _ContactColumn({
    required this.titleColor,
    required this.bodyColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get In Touch',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 14),
        _ContactRow(
          icon: FontAwesomeIcons.locationDot,
          text: 'Delhi, India',
          color: bodyColor,
          primary: primary,
        ),
        const SizedBox(height: 10),
        _ContactRow(
          icon: FontAwesomeIcons.envelope,
          text: UserData.email,
          color: bodyColor,
          primary: primary,
          isLink: true,
          linkUrl: 'mailto:${UserData.email}',
        ),
        const SizedBox(height: 10),
        _ContactRow(
          icon: FontAwesomeIcons.phone,
          text: UserData.phone,
          color: bodyColor,
          primary: primary,
        ),
        const SizedBox(height: 10),
        _ContactRow(
          icon: FontAwesomeIcons.github,
          text: UserData.github,
          color: bodyColor,
          primary: primary,
          isLink: true,
          linkUrl: 'https://${UserData.github}',
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final FaIconData icon;
  final String text;
  final Color color;
  final Color primary;
  final bool isLink;
  final String? linkUrl;

  const _ContactRow({
    required this.icon,
    required this.text,
    required this.color,
    required this.primary,
    this.isLink = false,
    this.linkUrl,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: FaIcon(icon, size: 13, color: primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: color,
              height: 1.5,
            ),
          ),
        ),
      ],
    );

    if (!isLink) return widget;
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(linkUrl!);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      child: widget,
    );
  }
}

// ─── Social row ───────────────────────────────────────────────────────────────
class _SocialRow extends StatelessWidget {
  final Color primary;
  const _SocialRow({required this.primary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIcon(icon: FontAwesomeIcons.linkedinIn,  url: 'https://${UserData.linkedin}', primary: primary),
        const SizedBox(width: 10),
        _SocialIcon(icon: FontAwesomeIcons.github,       url: 'https://${UserData.github}',   primary: primary),
        const SizedBox(width: 10),
        _SocialIcon(icon: FontAwesomeIcons.twitter,      url: 'https://${UserData.twitter}',  primary: primary),
        const SizedBox(width: 10),
        _SocialIcon(icon: FontAwesomeIcons.instagram,    url: 'https://${UserData.instagram}', primary: primary),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final FaIconData icon;
  final String url;
  final Color primary;
  const _SocialIcon({required this.icon, required this.url, required this.primary});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered ? widget.primary : Colors.transparent,
            border: Border.all(
              color: _hovered ? widget.primary : Colors.white.withValues(alpha: 0.15),
              width: 1.2,
            ),
          ),
          child: FaIcon(
            widget.icon,
            size: 14,
            color: _hovered ? Colors.white : Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}

// ─── Copyright text ───────────────────────────────────────────────────────────
class _CopyrightText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '© ${DateTime.now().year} Uttam Shah. All Rights Reserved.',
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        color: Color(0xFF6B7C8D),
      ),
    );
  }
}
