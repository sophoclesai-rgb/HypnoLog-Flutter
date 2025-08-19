import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/gradient_text.dart';

class OpeningScreen extends ConsumerWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🌙', style: TextStyle(fontSize: 56)),
                  const SizedBox(height: 16),

                  GradientText(
                    'HypnoLog',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFF06B6D4)],
                    ),
                    style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),
                  Text(
                    'Mystical Dream Journal',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () {
                      context.go('/onboarding/feature-comparison');
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}