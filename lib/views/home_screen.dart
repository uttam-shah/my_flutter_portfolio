import 'package:flutter/material.dart';
import 'package:my_flutter_portfolio/views/widgets/smart_hero_section.dart' hide HeroSection;
import 'package:provider/provider.dart';
import 'package:my_flutter_portfolio/viewmodels/portfolio_viewmodel.dart';
import 'package:my_flutter_portfolio/views/widgets/header.dart';
import 'package:my_flutter_portfolio/views/widgets/hero_section.dart';
import 'package:my_flutter_portfolio/views/widgets/work_section.dart';
import 'package:my_flutter_portfolio/views/widgets/skills_section.dart';
import 'package:my_flutter_portfolio/views/widgets/experience_section.dart';
import 'package:my_flutter_portfolio/views/widgets/education_section.dart';
import 'package:my_flutter_portfolio/views/widgets/footer.dart';

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
          SliverList(
            delegate: SliverChildListDelegate([
              WorkSection(key: viewModel.worksKey),
              SkillsSection(key: viewModel.skillsKey),
              ExperienceSection(key: viewModel.experienceKey),
              EducationSection(key: viewModel.educationKey),
              const Footer(),
            ]),
          ),
        ],
      ),
    );
  }
}
