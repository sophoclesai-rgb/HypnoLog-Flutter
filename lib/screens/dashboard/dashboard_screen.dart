import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/mystical_card.dart';
import '../../providers/user_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final shouldShowUpgradeBadge = ref.watch(shouldShowUpgradeBadgeProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('HypnoLog - Test'),
        actions: [
          IconButton(onPressed: () => context.go('/settings'), icon: const Icon(Icons.settings)),
        ],
      ),
      bottomNavigationBar: const HypnoBottomNav(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Upgrade Badge - Only for Free users
            if (shouldShowUpgradeBadge) ...[
              GestureDetector(
                onTap: () => context.go('/upgrade-paywall'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFF06B6D4)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text('✨', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upgrade to Premium',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Unlock unlimited dreams & deeper insights',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Upgrade',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            MysticalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('✨ Daily Inspiration', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Text('Keep your dream journal close and your mind open.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            MysticalCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Free Plan', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                        const SizedBox(height: 6),
                        Text('Upgrade to unlock all features',
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Upgrade'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Recent Dreams', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70)),
            const SizedBox(height: 8),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: 4,
              itemBuilder: (context, i) => MysticalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Dream ${i + 1}', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
                    Text('Tap to view details', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.go('/journal/write'),
              icon: const Icon(Icons.add),
              label: const Text('Write a Dream'),
            )
          ],
        ),
      ),
    );
  }
}