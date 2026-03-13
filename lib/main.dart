import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_portfolio/core/theme/app_colors.dart';
import 'package:my_flutter_portfolio/core/theme/theme_provider.dart';
import 'package:my_flutter_portfolio/viewmodels/portfolio_viewmodel.dart';
import 'package:my_flutter_portfolio/views/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PortfolioViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Uttam Shah Portfolio',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
