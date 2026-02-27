import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: 'exam1',
      sender: 'Phòng Khảo thí',
      message:
          'LỊCH THI CUỐI KỲ: Quản trị thương hiệu (E) | Ngày: 28/03/2026 - Giờ: 12g30 | Phòng: A.604 | Địa điểm: Cơ sở chính, Thủ Đức | Ghi chú: Tự luận',
      time: 'Vừa xong',
      type: 'schedule',
      icon: LucideIcons.calendarClock,
      isUnread: true,
    ),
    NotificationModel(
      id: 'exam2',
      sender: 'Phòng Khảo thí',
      message:
          'LỊCH THI CUỐI KỲ: Thương mại điện tử (E) | Ngày: 29/03/2026 - Giờ: 10g00 | Phòng: Online 19 | Địa điểm: Cơ sở chính, Thủ Đức | Ghi chú: Tiểu luận, Đồ án',
      time: '2 phút trước',
      type: 'schedule',
      icon: LucideIcons.calendarClock,
      isUnread: true,
    ),
    NotificationModel(
      id: 'exam3',
      sender: 'Phòng Khảo thí',
      message:
          'LỊCH THI CUỐI KỲ: Giao tiếp kinh doanh (E) | Ngày: 02/04/2026 - Giờ: 12g30 | Phòng: A.310 bis | Địa điểm: Cơ sở chính, Thủ Đức | Ghi chú: Thi trên Laptop cá nhân',
      time: '5 phút trước',
      type: 'schedule',
      icon: LucideIcons.calendarClock,
    ),
    NotificationModel(
      id: '1',
      sender: 'Giao tiếp kinh doanh',
      message:
          'THÔNG BÁO: Đổi phòng học môn Giao tiếp kinh doanh sang phòng B1.205 bắt đầu từ tuần này.',
      time: '1 giờ trước',
      type: 'schedule',
      icon: LucideIcons.bookOpen,
    ),
    NotificationModel(
      id: '2',
      sender: 'Lớp: K234102E',
      message:
          'Nhắc nhở: Lớp chúng ta sẽ học bù môn Quản trị thương hiệu vào sáng Thứ 7 (Tiết 1-3) tại phòng A2.304 nhé.',
      time: '15 phút trước',
      type: 'schedule',
      icon: LucideIcons.users,
    ),
    NotificationModel(
      id: '3',
      sender: 'PhD Nguyễn Thị Nhật Minh - Khoa QTKD',
      message:
          'Cô đã cập nhật điểm danh và điểm cộng trên hệ thống. Các em kiểm tra lại nhé.',
      time: '2 giờ trước',
      type: 'teacher_dept',
      icon: LucideIcons.userCheck,
    ),
    NotificationModel(
      id: '4',
      sender: 'Phòng Công tác sinh viên',
      message:
          'Thông báo về việc khai báo y tế và cập nhật thông tin sổ tự quản sinh viên.',
      time: 'Hôm qua',
      type: 'teacher_dept',
      icon: LucideIcons.shieldAlert,
      isUnread: true,
    ),
    NotificationModel(
      id: '5',
      sender: 'K234102E',
      message:
          'Tin nhắn mới từ Minh Mẫn: Các bạn nhớ tối nay 22h deadline nộp file bài tập nhóm nhen!',
      time: 'Hôm qua',
      type: 'chat',
      icon: LucideIcons.messageSquare,
      isUnread: false,
    ),
    NotificationModel(
      id: '6',
      sender: '[UEL] QTTH_ 252EBM505502',
      message: 'Tin nhắn mới từ Linh: Vậy mình học bù sáng thứ 7 nha các em.',
      time: '2 ngày trước',
      type: 'chat',
      icon: LucideIcons.messageSquare,
      isUnread: false,
    ),
    NotificationModel(
      id: '7',
      sender: 'Phòng Kế hoạch - Tài chính',
      message:
          'Nhắc nhở đóng học phí học kỳ 2 năm học. Hạn chót là ngày 30/04/2026.',
      time: 'Tuần trước',
      type: 'teacher_dept',
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
