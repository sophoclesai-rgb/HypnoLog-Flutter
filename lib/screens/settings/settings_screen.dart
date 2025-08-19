import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/bottom_nav.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0F),
      bottomNavigationBar: HypnoBottomNav(),
      body: Center(
        child: Text('Settings', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}