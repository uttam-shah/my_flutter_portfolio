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
      backgroundColor: const Color(0xFF1C1C1C),
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
                 color: Colors.white,
               ),
             ),

             // Navigation Links
             if (!ResponsiveLayout.isMobile(context))
               Expanded(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     _buildNavText(context, 'HOME', 'Home'),
                     const SizedBox(width: 30),
                     _buildNavText(context, 'WORKS', 'Resume'),
                     const SizedBox(width: 30),
                     _buildNavText(context, 'SKILLS', 'Portfolio'),
                     const SizedBox(width: 30),
                     _buildNavText(context, 'EXPERIENCE', 'Blog'),
                     const SizedBox(width: 30),
                     _buildNavText(context, 'EDUCATION', 'Contact'),
                   ],
                 ),
               ),

             if (ResponsiveLayout.isMobile(context))
               IconButton(
                 icon: const Icon(Icons.menu, color: Colors.white),
                 onPressed: () {},
               )
             else
               // Keeping dark mode toggle just in case the user wants it, but blending it in
               Consumer<ThemeProvider>(
                 builder: (context, themeProvider, child) {
                   final isDark = Theme.of(context).brightness == Brightness.dark;
                   return IconButton(
                     icon: Icon(
                       isDark ? Icons.light_mode : Icons.dark_mode,
                       color: Colors.white70,
                       size: 20,
                     ),
                     onPressed: () => themeProvider.toggleTheme(!isDark),
                   );
                 },
               ),
           ],
        ),
      ),
    );
  }

  Widget _buildNavText(BuildContext context, String sectionKey, String displayText) {
    return Consumer<PortfolioViewModel>(
      builder: (context, viewModel, child) {
        final isActive = viewModel.activeSection == sectionKey;
        return InkWell(
          onTap: () => viewModel.scrollToSectionByTitle(sectionKey),
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
             duration: const Duration(milliseconds: 300),
             padding: const EdgeInsets.symmetric(vertical: 4),
             child: Row(
               children: [
                 Text(
                   displayText,
                   style: GoogleFonts.poppins(
                     color: isActive ? Colors.white : Colors.white70,
                     fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                     fontSize: 14,
                   ),
                 ),
                 if (displayText == 'Home') ...[
                   const SizedBox(width: 4),
                   Icon(
                     Icons.keyboard_arrow_down,
                     color: isActive ? Colors.white : Colors.white70,
                     size: 16,
                   ),
                 ]
               ],
             ),
          ),
        );
      },
    );
  }
}
