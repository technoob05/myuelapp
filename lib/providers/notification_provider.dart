import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
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
