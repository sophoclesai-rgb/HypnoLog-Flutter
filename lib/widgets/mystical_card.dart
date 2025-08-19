import 'package:flutter/material.dart';

class MysticalCard extends StatelessWidget {
  const MysticalCard({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.06),
        border: Border.all(color: const Color(0x334C1D95)),
      ),
      child: Padding(padding: padding ?? const EdgeInsets.all(16), child: child),
    );
  }
}