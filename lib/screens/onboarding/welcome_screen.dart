import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0B1220), Color(0x6E6B21DE), Color(0xFF0B1220)],
                  ),
                  border: Border.all(color: const Color(0x334C1D95)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('🌙 Welcome to HypnoLog',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('Your mystical dream companion',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70)),
                        const SizedBox(height: 16),

                        // Simple feature bullets
                        ...[
                          'Write and save your dreams',
                          'Record voice dreams',
                          'AI dream interpretation',
                          'Generate dream images and videos',
                          'Track subconscious trends',
                        ].map((t) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Color(0xFFA7F3D0), size: 20),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(t, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 24),

                        Align(
                          alignment: Alignment.center,
                          child: FilledButton(
                            onPressed: () => context.go('/dashboard'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            ),
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}