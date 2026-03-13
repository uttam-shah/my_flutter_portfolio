import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_portfolio/core/theme/theme_provider.dart';
import 'package:my_flutter_portfolio/core/utils/responsive_layout.dart';
import 'package:my_flutter_portfolio/core/constants/user_data.dart';
import 'package:my_flutter_portfolio/viewmodels/portfolio_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderSliver extends StatelessWidget {
  const HeaderSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveLayout.isMobile(context) ? 0.0 : 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Text(
              UserData.name.split(' ')[0], // "Uttam"
              style: GoogleFonts.caveat(
                textStyle: Theme.of(context).textTheme.headlineLarge,
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            // Navigation Links
            if (!ResponsiveLayout.isMobile(context))
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavText(context, 'HOME'),
                    const SizedBox(width: 30),
                    _buildNavText(context, 'WORKS'),
                    const SizedBox(width: 30),
                    _buildNavText(context, 'SKILLS'),
                    const SizedBox(width: 30),
                    _buildNavText(context, 'EXPERIENCE'),
                    const SizedBox(width: 30),
                    _buildNavText(context, 'EDUCATION'),
                  ],
                ),
              ),

            // Phone & Action
            if (!ResponsiveLayout.isMobile(context))
              Row(
                children: [
                   Text(
                    UserData.phone,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.phone_in_talk_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Dark mode toggle inside header for convenience
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      final isDark = Theme.of(context).brightness == Brightness.dark;
                      return IconButton(
                        icon: Icon(
                          isDark ? Icons.light_mode : Icons.dark_mode,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () => themeProvider.toggleTheme(!isDark),
                      );
                    },
                  ),
                ],
              )
            else
              IconButton(
                icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () {},
              )
          ],
        ),
      ),
    );
  }

  Widget _buildNavText(BuildContext context, String title) {
    return Consumer<PortfolioViewModel>(
      builder: (context, viewModel, child) {
        final isActive = viewModel.activeSection == title;
        return InkWell(
          onTap: () => viewModel.scrollToSectionByTitle(title),
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isActive
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
            ),
          ),
        );
      },
    );
  }
}
