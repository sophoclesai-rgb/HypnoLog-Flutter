import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/mystical_card.dart';
import '../../providers/user_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const HypnoBottomNav(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current User Status
            MysticalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: _getUserTypeColor(userState.userType),
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userState.email ?? 'Not logged in',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _getUserTypeTitle(userState.userType),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: _getUserTypeColor(userState.userType),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (userState.email != null) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => userNotifier.logout(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Test Login Options
            Text(
              'Test Different User Types',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Login with different emails to test membership levels',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 16),

            ...testEmailUserTypes.entries.map((entry) {
              final email = entry.key;
              final userType = entry.value;
              final isCurrentUser = userState.email?.toLowerCase() == email;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MysticalCard(
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: isCurrentUser ? Colors.green : _getUserTypeColor(userType),
                    ),
                    title: Text(
                      email,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: isCurrentUser ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      _getUserTypeTitle(userType),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _getUserTypeColor(userType),
                      ),
                    ),
                    trailing: isCurrentUser
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'ACTIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white54,
                            size: 16,
                          ),
                    onTap: isCurrentUser
                        ? null
                        : () {
                            userNotifier.loginWithEmail(email);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Logged in as ${_getUserTypeTitle(userType)}'),
                                backgroundColor: _getUserTypeColor(userType),
                              ),
                            );
                          },
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Debug Information
            MysticalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Debug Information',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'User Type: ${userState.userType.name}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    'Show Upgrade Badge: ${userState.userType == UserType.free ? "YES" : "NO"}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: userState.userType == UserType.free ? Colors.orange : Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80), // Bottom navigation padding
          ],
        ),
      ),
    );
  }

  Color _getUserTypeColor(UserType userType) {
    switch (userType) {
      case UserType.free:
        return Colors.orange;
      case UserType.startTrial:
        return Colors.blue;
      case UserType.premium:
        return Colors.purple;
    }
  }

  String _getUserTypeTitle(UserType userType) {
    switch (userType) {
      case UserType.free:
        return '🆓 Free User (sees upgrade badge)';
      case UserType.startTrial:
        return '🎯 Start Trial User (3-day trial)';
      case UserType.premium:
        return '⭐ Premium User (no upgrade badge)';
    }
  }
}