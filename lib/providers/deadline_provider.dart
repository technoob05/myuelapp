import 'package:flutter/material.dart';
import '../models/deadline_model.dart';

class DeadlineProvider with ChangeNotifier {
  final List<DeadlineItem> _deadlines = [
    DeadlineItem(
      id: '1',
      title: 'Thi Giữa Kỳ - Thương mại điện tử',
      subject: 'Thương mại điện tử - Online 19',
      time: 'Hôm nay, 10:00',
      status: 'urgent',
    ),
    DeadlineItem(
      id: '2',
      title: 'Nộp tiểu luận môn Digital Marketing',
      subject: 'Digital Marketing (Cô Trần)',
      time: 'Ngày mai, 23:59',
      status: 'urgent',
    ),
    DeadlineItem(
      id: '3',
      title: 'Thi Cuối Kỳ - Quản trị thương hiệu (E)',
      subject: 'Phòng A.604 - Ghi chú: Thi tự luận',
      time: '28/03/2026, 12:30',
      status: 'normal',
    ),
    DeadlineItem(
      id: '4',
      title: 'Thi Cuối Kỳ - Giao tiếp kinh doanh (E)',
      subject: 'Phòng A.310 bis - Ghi chú: Thi trên Laptop cá nhân',
      time: '02/04/2026, 12:30',
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
