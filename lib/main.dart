import 'package:flutter/material.dart';
import 'package:toughest/theme/apptheme.dart';
import 'package:toughest/ui/home.dart';

void main() {
  runApp(const ToughestApp());
}

class ToughestApp extends StatelessWidget {
  const ToughestApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Central place for theming. Using Material 3 for a modern look.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toughest',
      theme: AppTheme.light(),
      home: const HomeScreen(),
    );
  }
}
