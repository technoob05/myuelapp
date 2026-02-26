import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';

// Providers
import 'providers/notification_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/deadline_provider.dart';
import 'providers/analytics_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => DeadlineProvider()),
        ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
      ],
      child: const MyUELApp(),
    ),
  );
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
