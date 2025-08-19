import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/mystical_card.dart';

class DreamListScreen extends ConsumerWidget {
  const DreamListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Dream Journal'), backgroundColor: Colors.transparent),
      bottomNavigationBar: const HypnoBottomNav(),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) => MysticalCard(
          child: ListTile(
            title: Text('Dream ${i + 1}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
            subtitle:
                Text('A short description of the dream...', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
            onTap: () {},
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}