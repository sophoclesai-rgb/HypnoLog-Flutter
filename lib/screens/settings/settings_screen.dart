import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/bottom_nav.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const HypnoBottomNav(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Google Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Add Firebase/Google logout
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logout functionality will be implemented'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Logout from Google'),
              ),
            ),

            const SizedBox(height: 24),

            // Test Instructions
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Test Gmail Accounts:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildEmailInfo('oguzbahadir@gmail.com', 'FREE - Shows upgrade badge'),
                  _buildEmailInfo('scifivetech@gmail.com', 'TRIAL - 3 day premium'),
                  _buildEmailInfo('bahadirafist@gmail.com', 'PREMIUM Monthly'),
                  _buildEmailInfo('scifivedev@gmail.com', 'PREMIUM Yearly'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInfo(String email, String type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '• $email - $type',
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}