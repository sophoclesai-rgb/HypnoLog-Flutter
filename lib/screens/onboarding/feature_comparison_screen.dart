import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureComparisonScreen extends ConsumerWidget {
  const FeatureComparisonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
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
                        colors: [
                          Color(0xFF0B1220),
                          Color(0x6E6B21DE),
                          Color(0xFF0B1220),
                        ],
                      ),
                      border: Border.all(color: const Color(0x334C1D95)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          // Decorative blurred circles
                          Positioned(
                            top: 40,
                            left: 40,
                            child: _BlurDot(color: const Color(0xFF8B5CF6), size: 80),
                          ),
                          Positioned(
                            bottom: 40,
                            right: 40,
                            child: _BlurDot(color: const Color(0xFF3B82F6), size: 64),
                          ),
                          Positioned(
                            top: 140,
                            left: 140,
                            child: _BlurDot(color: const Color(0xFFF472B6), size: 48),
                          ),

                          // Content
                          _ScrollableContent(theme: theme),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFF0A0A0F),
    );
  }
}

class _ScrollableContent extends StatelessWidget {
  const _ScrollableContent({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 700),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24 + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Column(
              children: [
                Text('🌙 Welcome to HypnoLog',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Text(
                  'Discover what you can do with HypnoLog',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                Text(
                  'Compare Free vs Premium features below',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table card
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('🆓 Free vs 💎 Premium Features',
                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),

                    // Header row
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Features', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 16),
                          Row(
                            children: const [
                              SizedBox(
                                width: 64,
                                child: Center(child: Text('FREE', style: TextStyle(color: Color(0xFFFCA5A5), fontWeight: FontWeight.w600))),
                              ),
                              SizedBox(width: 16),
                              SizedBox(
                                width: 64,
                                child: Center(child: Text('PREMIUM', style: TextStyle(color: Color(0xFFA7F3D0), fontWeight: FontWeight.w600))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const _RowItem(name: 'Dream Writing & Saving', free: '✓', premium: '✓'),
                    const _RowItem(name: 'Voice Dream Recording', free: '1x', premium: '∞'),
                    const _RowItem(name: 'Basic Dream Interpretation', free: '1x', premium: '∞'),
                    const _RowItem(name: 'Dream Image Generation', free: '1x', premium: '∞'),
                    const _RowItem(name: 'Dream Video Generation', free: '✕', premium: '∞'),
                    const _RowItem(name: 'Deep Dream Interpretation', free: '✕', premium: '✓'),
                    const _RowItem(name: 'Subconscious Trend Report', free: '✕', premium: '✓'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action button
            Align(
              alignment: Alignment.center,
              child: FilledButton.icon(
                onPressed: () {
                  GoRouter.of(context).go('/onboarding/welcome');
                },
                icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                label: const Text('Next: Welcome to HypnoLog'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Text(
              'Choose your subscription plan after exploring the welcome guide',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.name, required this.free, required this.premium});
  final String name;
  final String free;
  final String premium;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70))),
          const SizedBox(width: 16),
          SizedBox(width: 64, child: Center(child: Text(free, style: const TextStyle(color: Color(0xFFA7F3D0))))),
          const SizedBox(width: 16),
          SizedBox(width: 64, child: Center(child: Text(premium == '✓' ? '✓' : premium, style: const TextStyle(color: Color(0xFFA7F3D0)))))
        ],
      ),
    );
  }
}

class _BlurDot extends StatelessWidget {
  const _BlurDot({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.8), blurRadius: size / 2, spreadRadius: size / 5),
        ],
      ),
    );
  }
}