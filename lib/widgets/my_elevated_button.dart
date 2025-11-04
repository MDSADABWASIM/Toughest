import 'package:flutter/material.dart';

// A small wrapper to keep the app consistent when customising button behaviour.
class MyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const MyElevatedButton(
      {super.key, required this.onPressed, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
      child: child,
    );
  }
}
