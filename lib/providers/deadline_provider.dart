import 'package:flutter/material.dart';
import '../models/deadline_model.dart';

class DeadlineProvider with ChangeNotifier {
  final List<DeadlineItem> _deadlines = [
    // --- Lịch thi (Dữ liệu từ ảnh người dùng) ---
    DeadlineItem(
      id: 'exam_qtth',
      title: 'Thi cuối kỳ: Quản trị thương hiệu (E)',
      subject: 'Quản trị thương hiệu (E)',
      time: DateTime(2026, 3, 28, 12, 30),
      status: 'urgent',
      type: 'exam',
      location: 'Phòng A.604',
      note: 'Tự luận',
    ),
    DeadlineItem(
      id: 'exam_tmdt',
      title: 'Thi cuối kỳ: Thương mại điện tử (E)',
      subject: 'Thương mại điện tử (E)',
      time: DateTime(2026, 3, 29, 10, 00),
      status: 'urgent',
      type: 'exam',
      location: 'Phòng Online 19',
      note: 'Tiểu luận, Đồ án',
    ),
    DeadlineItem(
      id: 'exam_gtkd',
      title: 'Thi cuối kỳ: Giao tiếp kinh doanh (E)',
      subject: 'Giao tiếp kinh doanh (E)',
      time: DateTime(2026, 4, 2, 12, 30),
      status: 'urgent',
      type: 'exam',
      location: 'Phòng A.310 bis',
      note: 'Thi trên Laptop cá nhân',
    ),

    // --- Bài tập / Tiểu luận ---
    DeadlineItem(
      id: 'assign_dm',
      title: 'Nộp tiểu luận môn Digital Marketing',
      subject: 'Marketing kỹ thuật số (E)',
      time: DateTime(2026, 3, 15, 23, 59),
      status: 'normal',
      type: 'assignment',
      note: 'Nộp qua E-learning',
    ),
  ];

  List<DeadlineItem> get deadlines => _deadlines;

  List<DeadlineItem> getDeadlinesByDate(DateTime date) {
    // 1. Lọc các task cụ thể (thi, bài tập)
    List<DeadlineItem> dailyItems = _deadlines
        .where(
          (d) =>
              d.time.year == date.year &&
              d.time.month == date.month &&
              d.time.day == date.day,
        )
        .toList();

    // 2. Tự động thêm lịch học định kỳ (dựa trên Thứ trong tuần)
    // Dữ liệu từ ảnh Thời khóa biểu HK2/2025-2026 của người dùng
    int weekday = date.weekday; // 1 = Thứ 2, ..., 7 = Chủ nhật

    if (weekday == DateTime.monday) {
      dailyItems.add(
        DeadlineItem(
          id: 'class_mkts_${date.millisecondsSinceEpoch}',
          title: 'Học: Marketing kỹ thuật số (E)',
          subject: 'Marketing kỹ thuật số (E)',
          time: DateTime(date.year, date.month, date.day, 12, 30),
          status: 'normal',
          type: 'class',
          location: 'Phòng A.813',
          lecturer: 'Cô Vũ Thị Hồng Ngọc',
          note: 'Tiết 7-10.5',
          isRecurring: true,
        ),
      );
    } else if (weekday == DateTime.wednesday) {
      dailyItems.add(
        DeadlineItem(
          id: 'class_gtkd_${date.millisecondsSinceEpoch}',
          title: 'Học: Giao tiếp kinh doanh (E)',
          subject: 'Giao tiếp kinh doanh (E)',
          time: DateTime(date.year, date.month, date.day, 15, 15),
          status: 'normal',
          type: 'class',
          location: 'Phòng A.811',
          lecturer: 'Cô Nguyễn Thị Nhật Minh',
          note: 'Tiết 10-12',
          isRecurring: true,
        ),
      );
    } else if (weekday == DateTime.friday) {
      dailyItems.add(
        DeadlineItem(
          id: 'class_tmdt_${date.millisecondsSinceEpoch}',
          title: 'Học: Thương mại điện tử (E)',
          subject: 'Thương mại điện tử (E)',
          time: DateTime(date.year, date.month, date.day, 9, 45),
          status: 'normal',
          type: 'class',
          location: 'Phòng A.813',
          lecturer: 'Cô Nguyễn Thị Thúy Hạnh',
          note: 'Tiết 4-6',
          isRecurring: true,
        ),
      );
      dailyItems.add(
        DeadlineItem(
          id: 'class_qtth_${date.millisecondsSinceEpoch}',
          title: 'Học: Quản trị thương hiệu (E)',
          subject: 'Quản trị thương hiệu (E)',
          time: DateTime(date.year, date.month, date.day, 13, 20),
          status: 'normal',
          type: 'class',
          location: 'Phòng A.811',
          lecturer: 'Cô Hoàng Việt Linh',
          note: 'Tiết 8-11.5',
          isRecurring: true,
        ),
      );
    }

    // Sắp xếp theo thời gian
    dailyItems.sort((a, b) => a.time.compareTo(b.time));
    return dailyItems;
  }

  void toggleComplete(String id) {
    final index = _deadlines.indexWhere((d) => d.id == id);
    if (index != -1) {
      _deadlines[index].isCompleted = !_deadlines[index].isCompleted;
      notifyListeners();
    }
  }

  void addDeadline(
    String title,
    String subject,
    DateTime time, {
    String? location,
    String? note,
  }) {
    _deadlines.add(
      DeadlineItem(
        id: DateTime.now().toString(),
        title: title,
        subject: subject,
        time: time,
        status: 'normal',
        type: 'assignment',
        location: location,
        note: note,
      ),
    );
    notifyListeners();
  }
}
