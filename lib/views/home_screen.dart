import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_portfolio/viewmodels/portfolio_viewmodel.dart';
import 'package:my_flutter_portfolio/views/widgets/header.dart';
import 'package:my_flutter_portfolio/views/widgets/hero_section.dart';
import 'package:my_flutter_portfolio/views/widgets/tech_stack/tech_stack_section.dart';
import 'package:my_flutter_portfolio/views/widgets/work_section.dart';
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
          const HeaderSliver(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                HeroSection(key: viewModel.homeKey),
                WorkSection(key: viewModel.worksKey),
                TechStackSection(key: viewModel.skillsKey),
                ExperienceSection(key: viewModel.experienceKey),
                EducationSection(key: viewModel.educationKey),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
