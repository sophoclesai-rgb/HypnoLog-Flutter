import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/bottom_nav.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.red, // DISTINCTIVE RED BACKGROUND
      appBar: AppBar(
        title: const Text('🔥 NEW SETTINGS TEST 🔥'),
        backgroundColor: Colors.orange,
      ),
      bottomNavigationBar: const HypnoBottomNav(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🚀 SETTINGS CHANGED SUCCESSFULLY! 🚀',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'If you see this text, the file changes are working!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}