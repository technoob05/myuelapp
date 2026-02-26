import 'package:flutter/material.dart';
import '../models/deadline_model.dart';

class DeadlineProvider with ChangeNotifier {
  final List<DeadlineItem> _deadlines = [
    DeadlineItem(
      id: '1',
      title: 'Thi Giữa Kỳ - Toán cao cấp A1',
      subject: 'Toán cao cấp A1 - Phòng C1.102',
      time: 'Hôm nay, 13:30',
      status: 'urgent',
    ),
    DeadlineItem(
      id: '2',
      title: 'Nộp Tiểu luận Triết học Mác - Lênin',
      subject: 'Triết học Mác - Lênin (Thầy B)',
      time: 'Ngày mai, 23:59',
      status: 'urgent',
    ),
    DeadlineItem(
      id: '3',
      title: 'Tham gia seminar Kỹ năng mềm',
      subject: 'Hoạt động Đoàn - Hội HK1',
      time: 'Thứ 6, 08:00',
      status: 'normal',
    ),
    DeadlineItem(
      id: '4',
      title: 'Nộp Đồ án - Lập trình ứng dụng Web',
      subject: 'Lập trình Web - K24417',
      time: 'Chủ nhật, 23:59',
      status: 'normal',
    ),
    DeadlineItem(
      id: '5',
      title: 'Hạn chót đóng học phí đợt đợt 1',
      subject: 'Phòng Kế hoạch - Tài chính',
      time: 'Đã quá hạn 2 ngày',
      status: 'overdue',
    ),
  ];

  List<DeadlineItem> get deadlines => _deadlines;

  void toggleComplete(String id) {
    final index = _deadlines.indexWhere((d) => d.id == id);
    if (index != -1) {
      _deadlines[index].isCompleted = !_deadlines[index].isCompleted;
      notifyListeners();
    }
  }

  void addDeadline(String title, String subject) {
    _deadlines.insert(
      0,
      DeadlineItem(
        id: DateTime.now().toString(),
        title: title,
        subject: subject,
        time: 'Đang cập nhật',
        status: 'normal',
      ),
    );
    notifyListeners();
  }
}
