import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/mystical_card.dart';
import '../../providers/user_provider.dart';

class UpgradePaywallScreen extends ConsumerStatefulWidget {
  const UpgradePaywallScreen({super.key});

  @override
  ConsumerState<UpgradePaywallScreen> createState() => _UpgradePaywallScreenState();
}

class _UpgradePaywallScreenState extends ConsumerState<UpgradePaywallScreen> {
  String selectedPlan = 'yearly';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              const Text('✨', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              
              GradientText(
                'Upgrade to Premium',
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFF06B6D4)],
                ),
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),
              Text(
                'Everything you need for deeper dream insights.',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Features List
              ...premiumFeatures.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: MysticalCard(
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          feature,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              const SizedBox(height: 32),

              // Pricing Options
              Column(
                children: pricingPlans.map((plan) {
                  final isSelected = selectedPlan == plan['id'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedPlan = plan['id']!),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected 
                              ? const Color(0xFF6366F1) 
                              : const Color(0xFF1A1A2E),
                            width: 2,
                          ),
                          gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0x206366F1), Color(0x208B5CF6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                          color: isSelected ? null : const Color(0xFF0F0F1A),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected 
                                      ? const Color(0xFF6366F1) 
                                      : const Color(0xFF4A4A5A),
                                  ),
                                  color: isSelected 
                                    ? const Color(0xFF6366F1) 
                                    : Colors.transparent,
                                ),
                                child: isSelected
                                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                                  : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          plan['title']!,
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (plan['badge'] != null)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              gradient: const LinearGradient(
                                                colors: [Color(0xFF10B981), Color(0xFF059669)],
                                              ),
                                            ),
                                            child: Text(
                                              plan['badge']!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          plan['price']!,
                                          style: theme.textTheme.headlineSmall?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          plan['period']!,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (plan['subtitle'] != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          plan['subtitle']!,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: Colors.white50,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // Subscribe Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    // TODO: RevenueCat subscription integration
                    // For now, simulate successful upgrade
                    ref.read(userProvider.notifier).upgradeToPremium();
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('🎉 Welcome to Premium! Upgrade badge will disappear.'),
                        backgroundColor: Colors.green[600],
                      ),
                    );
                    
                    // Navigate back to dashboard
                    context.go('/dashboard');
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Start Your Premium Journey',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Terms & Privacy
              Text(
                'By subscribing, you agree to our Terms of Service and Privacy Policy.\nCancel anytime from your device settings.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white40,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> premiumFeatures = [
  'Unlimited dream interpretations with deep psychological insights',
  'Unlimited dream visualizations (images)',
  'Dream videos & animations',
  'Advanced pattern analysis & symbolic mapping',
  'Personalized subconscious reports, updated as you log dreams',
];

const List<Map<String, String>> pricingPlans = [
  {
    'id': 'weekly',
    'title': 'Weekly',
    'price': '\$4.99',
    'period': '/ week',
    'subtitle': 'Perfect for trying premium features',
  },
  {
    'id': 'monthly',
    'title': 'Monthly',
    'price': '\$9.99',
    'period': '/ month',
    'subtitle': 'Most flexible option',
  },
  {
    'id': 'yearly',
    'title': 'Yearly',
    'price': '\$49.99',
    'period': '/ year',
    'subtitle': 'Save 58% compared to monthly',
    'badge': 'BEST VALUE',
  },
];