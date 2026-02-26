import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';
import '../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thông báo'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.primaryBlueVariant],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.checkCheck),
              tooltip: 'Đánh dấu đã đọc tất cả',
              onPressed: () {
                provider.markAllAsRead();
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: AppColors.textWhite,
            unselectedLabelColor: AppColors.textWhite.withValues(alpha: 0.7),
            indicatorColor: AppColors.textWhite,
            tabs: const [
              Tab(text: 'Tất cả'),
              Tab(text: 'Giảng viên/Phòng ban'),
              Tab(text: 'Phòng/Giờ học'),
              Tab(text: 'Nhóm chat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationList(null),
            _buildNotificationList('teacher_dept'),
            _buildNotificationList('schedule'),
            _buildNotificationList('chat'),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(String? filterType) {
    final provider = Provider.of<NotificationProvider>(context);
    final filtered = provider.getNotificationsByType(filterType);

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.bellOff,
              size: 60,
              color: AppColors.iconUnselected,
            ),
            const SizedBox(height: 16),
            Text('Không có thông báo nào', style: AppTextStyles.bodyMedium),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final notif = filtered[index];
        return _buildNotificationItem(notif, provider);
      },
    );
  }

  Widget _buildNotificationItem(
    NotificationModel notif,
    NotificationProvider provider,
  ) {
    return Dismissible(
      key: Key(notif.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppColors.errorRed,
        child: const Icon(LucideIcons.trash2, color: Colors.white),
      ),
      onDismissed: (direction) {
        provider.removeNotification(notif.id);
      },
      child: InkWell(
        onTap: () => provider.markAsRead(notif.id),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: notif.isUnread
                ? AppColors.primaryBlue.withValues(alpha: 0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: notif.isUnread
                  ? AppColors.primaryBlue.withValues(alpha: 0.3)
                  : Colors.grey.withValues(alpha: 0.2),
            ),
            boxShadow: [
              if (!notif.isUnread)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (notif.isUnread)
                  Container(
                    width: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: notif.isUnread
                                ? AppColors.primaryBlue.withValues(alpha: 0.1)
                                : AppColors.scaffoldBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            notif.icon,
                            color: notif.isUnread
                                ? AppColors.primaryBlue
                                : AppColors.iconUnselected,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notif.sender,
                                      style: AppTextStyles.bodyLarge.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: notif.isUnread
                                            ? AppColors.primaryBlue
                                            : AppColors.textDark,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    notif.time,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: notif.isUnread
                                          ? AppColors.primaryBlue
                                          : AppColors.textLight,
                                      fontWeight: notif.isUnread
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notif.message,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textBody,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
