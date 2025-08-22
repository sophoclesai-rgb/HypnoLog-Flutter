import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/onboarding/feature_comparison_screen.dart';
import '../screens/onboarding/opening_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/onboarding/upgrade_paywall_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/journal/dream_list_screen.dart';
import '../screens/journal/write_dream_screen.dart';
import '../screens/journal/dream_detail_screen.dart';
import '../screens/reports/subconscious_report_screen.dart';
import '../screens/settings/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/opening',
    routes: [
      GoRoute(
        path: '/opening',
        name: 'opening',
        pageBuilder: (context, state) => const NoTransitionPage(child: OpeningScreen()),
      ),
      GoRoute(
        path: '/onboarding/feature-comparison',
        name: 'feature-comparison',
        pageBuilder: (context, state) => const NoTransitionPage(child: FeatureComparisonScreen()),
      ),
      GoRoute(
        path: '/onboarding/welcome',
        name: 'welcome',
        pageBuilder: (context, state) => const NoTransitionPage(child: WelcomeScreen()),
      ),
      GoRoute(
        path: '/upgrade-paywall',
        name: 'upgrade-paywall',
        pageBuilder: (context, state) => const NoTransitionPage(child: UpgradePaywallScreen()),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        pageBuilder: (context, state) => const NoTransitionPage(child: DashboardScreen()),
      ),
      GoRoute(
        path: '/journal',
        name: 'journal',
        pageBuilder: (context, state) => const NoTransitionPage(child: DreamListScreen()),
      ),
      GoRoute(
        path: '/journal/write',
        name: 'write-dream',
        pageBuilder: (context, state) => const NoTransitionPage(child: WriteDreamScreen()),
      ),
      GoRoute(
        path: '/journal/detail',
        name: 'dream-detail',
        pageBuilder: (context, state) => const NoTransitionPage(child: DreamDetailScreen()),
      ),
      GoRoute(
        path: '/report/subconscious',
        name: 'subconscious-report',
        pageBuilder: (context, state) => const NoTransitionPage(child: SubconsciousReportScreen()),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => const NoTransitionPage(child: SettingsScreen()),
      ),
    ],
    errorPageBuilder: (context, state) => NoTransitionPage(
      child: Center(child: Text('Route error: \'${state.error}\'')),
    ),
    redirect: (context, state) {
      // place for auth gating later
      return null;
    },
    debugLogDiagnostics: false,
  );
});