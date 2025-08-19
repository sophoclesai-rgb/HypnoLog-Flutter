import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HypnoBottomNav extends StatelessWidget {
  const HypnoBottomNav({super.key});

  int _indexForLocation(String location) {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/journal')) return 1;
    if (location.startsWith('/report')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexForLocation(loc);
    return NavigationBar(
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Journal'),
        NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'Report'),
        NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
      ],
      onDestinationSelected: (i) {
        switch (i) {
          case 0:
            context.go('/dashboard');
            break;
          case 1:
            context.go('/journal');
            break;
          case 2:
            context.go('/report/subconscious');
            break;
          case 3:
            context.go('/settings');
            break;
        }
      },
    );
  }
}