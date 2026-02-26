import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import 'home_screen.dart';
import 'notifications_screen.dart';
import 'chat_screen.dart';
import 'dashboard_screen.dart';
import 'calendar_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDemoNotification();
    });
  }

  void _showDemoNotification() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final overlayState = Overlay.of(context);
      late OverlayEntry entry;

      entry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 16.0,
          left: 16.0,
          right: 16.0,
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: -100.0, end: 0.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: () {
                  entry.remove();
                  setState(() {
                    _currentIndex = 4; // Switch to Notifications screen
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.bellRing,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Giao tiếp kinh doanh',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Đổi phòng học môn Giao tiếp kinh doanh sang phòng B1.205 (Mới)',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textBody,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          LucideIcons.x,
                          size: 20,
                          color: AppColors.textLight,
                        ),
                        onPressed: () => entry.remove(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      overlayState.insert(entry);

      // Auto dismiss after 6 seconds
      Future.delayed(const Duration(seconds: 6), () {
        if (entry.mounted) {
          entry.remove();
        }
      });
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const DashboardScreen(),
    const ChatScreen(),
    const CalendarScreen(),
    const NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.pieChart),
                label: 'Thống kê',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.messageSquare),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.calendar),
                label: 'Lịch',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.bell),
                label: 'Thông báo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
