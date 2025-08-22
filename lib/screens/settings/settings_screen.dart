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
                        onPressed: () {
                          userNotifier.logout();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('🚪 Logged out - Now in Free mode for testing'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text(
                          'Reset to Free User (Test Logout)',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Quick Test Buttons  
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      userNotifier.loginWithGmail('oguzbahadir@gmail.com');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('🆓 Now Free User - Check Dashboard!')),
                      );
                    },
                    icon: const Text('🆓'),
                    label: const Text('Free'),
                    style: FilledButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      userNotifier.loginWithGmail('scifivetech@gmail.com'); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('🎯 Now Trial User - Check Dashboard!')),
                      );
                    },
                    icon: const Text('🎯'),
                    label: const Text('Trial'),
                    style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      userNotifier.loginWithGmail('bahadirafist@gmail.com');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('⭐ Now Premium User - Check Dashboard!')),
                      );
                    },
                    icon: const Text('⭐'),
                    label: const Text('Premium'),
                    style: FilledButton.styleFrom(backgroundColor: Colors.purple),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Test Login Options
            Text(
              'Simulate Different User Types',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Click on Gmail addresses to simulate different membership levels.\nThis overrides your current Google login session for testing.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 12),
            
            // Warning
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Test Mode: Click Gmail addresses below to switch user types',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ...realGmailUserTypes.entries.map((entry) {
              final gmailEmail = entry.key;
              final userType = entry.value;
              final isCurrentUser = userState.email?.toLowerCase() == gmailEmail;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MysticalCard(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: isCurrentUser ? Colors.green : _getUserTypeColor(userType),
                      size: 32,
                    ),
                    title: Text(
                      gmailEmail,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: isCurrentUser ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getUserTypeTitle(userType),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _getUserTypeColor(userType),
                          ),
                        ),
                        if (isCurrentUser && userType == UserType.free) ...[
                          const SizedBox(height: 4),
                          Text(
                            _getFreeUserLimits(userState),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.orange.withOpacity(0.7),
                              fontSize: 10,
                            ),
                          ),
                        ],
                        if (isCurrentUser && userType == UserType.startTrial) ...[
                          const SizedBox(height: 4),
                          Text(
                            userState.isTrialActive ? 'Trial Active ✅' : 'Trial Expired ❌',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: userState.isTrialActive ? Colors.green : Colors.red,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
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
                            userNotifier.loginWithGmail(gmailEmail);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('🔄 Switched to ${gmailEmail}\n${_getUserTypeTitle(userType)}'),
                                backgroundColor: _getUserTypeColor(userType),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'Go to Dashboard',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    // Navigate to dashboard to see changes
                                    Navigator.pop(context); // Close settings if needed
                                  },
                                ),
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
                  Text(
                    'Premium Access: ${ref.read(userProvider.notifier).hasPremiumAccess ? "YES" : "NO"}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: ref.read(userProvider.notifier).hasPremiumAccess ? Colors.purple : Colors.orange,
                    ),
                  ),
                  if (userState.userType == UserType.free) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Usage Limits:',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ref.read(userProvider.notifier).usageInfo,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
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
      case UserType.weeklyPremiumTrial:
        return Colors.lightBlue;
      case UserType.monthlyPremium:
        return Colors.purple;
      case UserType.yearlyPremium:
        return Colors.deepPurple;
    }
  }

  String _getUserTypeTitle(UserType userType) {
    switch (userType) {
      case UserType.free:
        return '🆓 Free - Limited Features';
      case UserType.startTrial:
        return '🎯 Start Trial - 3 Day Free Premium';
      case UserType.weeklyPremiumTrial:
        return '📅 Weekly Premium - $4.99/week';
      case UserType.monthlyPremium:
        return '🗓️ Monthly Premium - $9.99/month';
      case UserType.yearlyPremium:
        return '🏆 Yearly Premium - $49.99/year';
    }
  }

  String _getFreeUserLimits(UserState userState) {
    return 'Limits: ${userState.remainingInterpretations} interpretations, ${userState.remainingVisualizations} images, ${userState.remainingVideos} videos left';
  }
}