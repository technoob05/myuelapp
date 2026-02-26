import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class NotificationModel {
  final String id;
  final String sender;
  final String message;
  final String time;
  final String type; // 'academic', 'personal', 'system'
  final IconData icon;
  bool isUnread;

  NotificationModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.time,
    required this.type,
    required this.icon,
    this.isUnread = true,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      sender: 'Phòng Đào Tạo',
      message:
          'THÔNG BÁO: Đổi phòng học môn Kinh tế vĩ mô (Lớp K24417B) sang phòng B1.205 bắt đầu từ tuần này.',
      time: 'Vừa xong',
      type: 'academic',
      icon: LucideIcons.bookOpen,
    ),
    NotificationModel(
      id: '2',
      sender: 'Lớp K24417',
      message:
          'Nhắc nhở: Lớp chúng ta sẽ học bù môn Toán cao cấp A1 vào sáng Thứ 7 (Tiết 1-3) tại phòng A2.304 nhé.',
      time: '15 phút trước',
      type: 'personal',
      icon: LucideIcons.users,
    ),
    NotificationModel(
      id: '3',
      sender: 'Giảng viên Trần Văn A',
      message:
          'Thầy đã cập nhật điểm danh và điểm cộng phát biểu giữa kỳ môn Hệ điều hành trên hệ thống. Các em kiểm tra lại nhé.',
      time: '2 giờ trước',
      type: 'academic',
      icon: LucideIcons.fileSignature,
    ),
    NotificationModel(
      id: '4',
      sender: 'Phòng Công tác sinh viên',
      message:
          'Thông báo về việc khai báo y tế và cập nhật thông tin sổ tự quản sinh viên học kỳ 1 năm học 2026-2027.',
      time: 'Hôm qua',
      type: 'system',
      icon: LucideIcons.shieldAlert,
      isUnread: true,
    ),
    NotificationModel(
      id: '5',
      sender: 'Hệ thống học vụ (UIS)',
      message:
          'Bảo trì hệ thống đăng ký học phần đợt 2 từ 22:00 hôm nay đến 04:00 ngày mai. Vui lòng không thực hiện giao dịch trong thời gian này.',
      time: 'Hôm qua',
      type: 'system',
      icon: LucideIcons.server,
      isUnread: false,
    ),
    NotificationModel(
      id: '6',
      sender: 'Câu lạc bộ IT UEL',
      message:
          'Bạn có lịch phỏng vấn vòng 2 Ban Chuyên môn vào lúc 14:00 ngày mai. Nhớ mang theo laptop nhé!',
      time: '2 ngày trước',
      type: 'personal',
      icon: LucideIcons.calendarClock,
      isUnread: false,
    ),
    NotificationModel(
      id: '7',
      sender: 'Thư viện UEL',
      message:
          'Sách "Giáo trình Kinh tế vi mô" của bạn sẽ hết hạn mượn trong 2 ngày nữa. Vui lòng gia hạn hoặc hoàn trả đúng hạn.',
      time: '3 ngày trước',
      type: 'academic',
      icon: LucideIcons.library,
      isUnread: false,
    ),
    NotificationModel(
      id: '8',
      sender: 'Phòng Kế hoạch - Tài chính',
      message:
          'Nhắc nhở đóng học phí học kỳ 1 năm học. Hạn chót là ngày 30/11/2026.',
      time: 'Tuần trước',
      type: 'system',
      icon: LucideIcons.receipt,
      isUnread: false,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notif in _notifications) {
        notif.isUnread = false;
      }
    });
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index].isUnread = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _markAllAsRead,
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: AppColors.textWhite,
            unselectedLabelColor: AppColors.textWhite.withValues(alpha: 0.7),
            indicatorColor: AppColors.textWhite,
            tabs: const [
              Tab(text: 'Tất cả'),
              Tab(text: 'Học tập'),
              Tab(text: 'Cá nhân'),
              Tab(text: 'Hệ thống'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationList(null),
            _buildNotificationList('academic'),
            _buildNotificationList('personal'),
            _buildNotificationList('system'),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(String? filterType) {
    final filtered = filterType == null
        ? _notifications
        : _notifications.where((n) => n.type == filterType).toList();

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
        return _buildNotificationItem(notif);
      },
    );
  }

  Widget _buildNotificationItem(NotificationModel notif) {
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
        setState(() {
          _notifications.removeWhere((n) => n.id == notif.id);
        });
      },
      child: InkWell(
        onTap: () => _markAsRead(notif.id),
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
