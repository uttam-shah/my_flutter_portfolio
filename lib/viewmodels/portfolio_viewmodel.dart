import 'package:flutter/material.dart';

class PortfolioViewModel extends ChangeNotifier {
  PortfolioViewModel() {
    scrollController.addListener(_onScroll);
  }

  final ScrollController scrollController = ScrollController();
  
  // To keep track of the current active section for navigation highlighting
  String _activeSection = 'HOME';
  String get activeSection => _activeSection;

  // Keys for scrolling
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey worksKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();

  void _onScroll() {
    final Map<String, GlobalKey> offsets = {
      'HOME': homeKey,
      'WORKS': worksKey,
      'SKILLS': skillsKey,
      'EXPERIENCE': experienceKey,
      'EDUCATION': educationKey,
    };

    String newActiveSection = _activeSection;
    
    for (var entry in offsets.entries) {
      final context = entry.value.currentContext;
      if (context != null) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;
        // If the section top is above or near the middle of the screen
        if (position <= 250) {
          newActiveSection = entry.key;
        }
      }
    }

    if (newActiveSection != _activeSection) {
      _activeSection = newActiveSection;
      notifyListeners();
    }
  }

  void setActiveSection(String section) {
    if (_activeSection != section) {
      _activeSection = section;
      notifyListeners();
    }
  }

  // Smooth scroll to a specific section by title
  void scrollToSectionByTitle(String title) {
    GlobalKey? targetKey;
    switch (title) {
      case 'HOME':
        targetKey = homeKey;
        break;
      case 'SKILLS':
        targetKey = skillsKey;
        break;
      case 'WORKS':
        targetKey = worksKey;
        break;
      case 'EDUCATION':
        targetKey = educationKey;
        break;
      case 'EXPERIENCE':
        targetKey = experienceKey;
        break;
      default:
        targetKey = homeKey;
    }

    if (targetKey.currentContext != null) {
      final RenderBox box = targetKey.currentContext!.findRenderObject() as RenderBox;
      // Get the absolute offset by adding the current scroll position to the local-to-global dy.
      // Subtract about 80 pixels to account for the sticky header height.
      final targetOffset = scrollController.offset + box.localToGlobal(Offset.zero).dy - 80;

      scrollController.animateTo(
        targetOffset.clamp(0.0, scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
