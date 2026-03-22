import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/views/widgets/HeroSection/smart_hero_section.dart' hide HeroSection;
import 'package:provider/provider.dart';
import 'package:my_flutter_portfolio/viewmodels/portfolio_viewmodel.dart';
import 'package:my_flutter_portfolio/views/widgets/header.dart';
import 'package:my_flutter_portfolio/views/widgets/hero_section.dart';
import 'package:my_flutter_portfolio/views/widgets/work_section.dart';
import 'package:my_flutter_portfolio/views/widgets/skills_section.dart';
import 'package:my_flutter_portfolio/views/widgets/experience_section.dart';
import 'package:my_flutter_portfolio/views/widgets/education_section.dart';
import 'package:my_flutter_portfolio/views/widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PortfolioViewModel>();

    return Scaffold(
      body: CustomScrollView(
        controller: viewModel.scrollController,
        slivers: [
          // ❌ Remove HeaderSliver — nav is now inside SmartHeroSection
          SliverToBoxAdapter(
            child: SmartHeroSection(
              key: viewModel.homeKey,
              scrollController: viewModel.scrollController, // ✅ passed in
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                WorkSection(key: viewModel.worksKey),
                SkillsSection(key: viewModel.skillsKey),
                ExperienceSection(key: viewModel.experienceKey),
                EducationSection(key: viewModel.educationKey),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (viewModel.activeSection != 'HOME') ...[
            FloatingActionButton(
              heroTag: 'scrollToTop',
              backgroundColor: Theme.of(context).primaryColor,
              mini: true,
              onPressed: () {
                viewModel.scrollToSectionByTitle('HOME');
              },
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
            const SizedBox(height: 12),
          ],
          // FloatingActionButton(
          //   heroTag: 'whatsappBtn',
          //   backgroundColor: const Color(0xFF25D366),
          //   onPressed: () async {
          //     final url = Uri.parse('https://wa.me/918860406497?text=Hello');
          //     if (await canLaunchUrl(url)) {
          //       await launchUrl(url, mode: LaunchMode.externalApplication);
          //     }
          //   },
          //   child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 34),
          // ),
        ],
      ),
    );
  }
}
