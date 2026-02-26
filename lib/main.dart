import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const MyUELApp());
}

class MyUELApp extends StatelessWidget {
  const MyUELApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My UEL',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}
