import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: 'teacher1',
      sender: 'ThS. Vũ Thị Hồng Ngọc - Marketing kỹ thuật số',
      message:
          'Cô đã tải tài liệu ôn tập chương 4 lên E-learning. Các em tải về chuẩn bị cho bài thảo luận tuần tới nhé.',
      time: '10:30 - 28/02/2026',
      type: 'teacher',
      icon: LucideIcons.userCheck,
      isUnread: true,
    ),
    NotificationModel(
      id: 'teacher2',
      sender: 'TS. Nguyễn Thị Nhật Minh - Giao tiếp KD',
      message:
          'Thông báo: Lớp Giao tiếp kinh doanh hôm nay sẽ chuyển sang hình thức học Online qua Google Meet. Link đã gửi qua email.',
      time: '08:15 - 28/02/2026',
      type: 'teacher',
      icon: LucideIcons.video,
      isUnread: true,
    ),
    NotificationModel(
      id: 'dept1',
      sender: 'Phòng Công tác sinh viên',
      message:
          'Thông báo về việc đăng ký học bổng khuyến khích học tập học kỳ 2 (2025-2026). Hạn chót: 15/03/2026.',
      time: 'Hôm qua',
      type: 'department',
      icon: LucideIcons.award,
      isUnread: true,
    ),
    NotificationModel(
      id: 'dept2',
      sender: 'Phòng Kế hoạch - Tài chính',
      message:
          'Nhắc nhở: Hạn chót quyết toán học phí học kỳ 2 là ngày 30/03/2026. Sinh viên vui lòng hoàn tất đúng hạn.',
      time: '2 ngày trước',
      type: 'department',
      icon: LucideIcons.receipt,
      isUnread: false,
    ),
    NotificationModel(
      id: 'schedule1',
      sender: 'Phòng Khảo thí',
      message:
          'LỊCH THI DỰ KIẾN: Quản trị thương hiệu (E) | Ngày 28/03/2026 | Phòng A.604. Vui lòng kiểm tra lại trên cổng thông tin.',
      time: 'Vừa xong',
      type: 'schedule',
      icon: LucideIcons.calendarClock,
      isUnread: true,
    ),
    NotificationModel(
      id: 'schedule2',
      sender: 'Phòng Đào tạo',
      message:
          'THÔNG BÁO: Đã có lịch học chính thức tháng 03/2026. Sinh viên xem chi tiết tại mục Thời khóa biểu.',
      time: '1 giờ trước',
      type: 'schedule',
      icon: LucideIcons.calendarDays,
      isUnread: false,
    ),
    NotificationModel(
      id: 'event1',
      sender: 'Liên Chi hội Khoa Quản trị Kinh doanh',
      message:
          'Đăng ký ngay: Cuộc thi "Marketing Challenge 2026" - Cơ hội rinh giải thưởng khủng và chứng nhận xịn.',
      time: '3 giờ trước',
      type: 'event',
      icon: LucideIcons.megaphone,
      isUnread: true,
    ),
    NotificationModel(
      id: 'event2',
      sender: 'Marketing UEL Club',
      message:
          'Workshop: "Thấu hiểu người dùng qua dữ liệu số" sẽ diễn ra vào sáng Thứ 4 tới tại Hội trường A.',
      time: '5 giờ trước',
      type: 'event',
      icon: LucideIcons.sparkles,
      isUnread: true,
    ),
  ];

  List<NotificationModel> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => n.isUnread).length;

  List<NotificationModel> getNotificationsByType(String? type) {
    if (type == null) return _notifications;
    return _notifications.where((n) => n.type == type).toList();
  }

  void markAllAsRead() {
    for (var notif in _notifications) {
      notif.isUnread = false;
    }
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1 && _notifications[index].isUnread) {
      _notifications[index].isUnread = false;
      notifyListeners();
    }
  }

  void removeNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void simulatePushNotification(NotificationModel newNotif) {
    _notifications.insert(0, newNotif);
    notifyListeners();
  }
}
