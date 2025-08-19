import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DreamDetailScreen extends ConsumerWidget {
  const DreamDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0F),
      body: Center(
        child: Text('Dream Detail', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}