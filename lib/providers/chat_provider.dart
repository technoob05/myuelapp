import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatThread> _threads = [
    ChatThread(
      id: '1',
      name: 'TS. Nguyễn Văn A - Khoa CNTT',
      lastMessage:
          'Chào em, file hướng dẫn đồ án môn Hệ điều hành thầy đã upload lên khóa học trên hệ thống e-learning rồi nhé.',
      time: '14:30',
      unreadCount: 1,
      isOnline: true,
      isGroup: false,
      messages: [
        ChatMessage(text: 'Dạ em chào thầy ạ.', isMe: true, time: '14:00'),
        ChatMessage(
          text:
              'Thầy cho em hỏi tuần này nhóm em báo cáo đồ án phần phân trang bộ nhớ, vậy tụi em dùng thư viện ngoài được không ạ?',
          isMe: true,
          time: '14:05',
        ),
        ChatMessage(
          text:
              'Chào em, file hướng dẫn đồ án môn Hệ điều hành thầy đã upload lên khóa học trên hệ thống e-learning rồi nhé. Trong guideline đã quy định rất rõ những gì được dùng và không được dùng.',
          isMe: false,
          time: '14:30',
        ),
      ],
    ),
    ChatThread(
      id: '2',
      name: 'Nhóm Lớp K24417B - Thống kê ứng dụng',
      lastMessage:
          'Minh Mẫn: Các bạn nhớ tối nay 22h deadline nộp file bài tập nhóm nhen!',
      time: 'Hôm qua',
      unreadCount: 0,
      isOnline: false,
      isGroup: true,
      messages: [
        ChatMessage(
          text: 'Thứ 4 tuần sau mình thi giữa kỳ ở phòng mấy vậy mọi người?',
          isMe: false,
          time: '14:20',
        ),
        ChatMessage(
          text: 'Lịch thi của trường báo là thi ở phòng B1.205 nha bạn.',
          isMe: true,
          time: '14:25',
        ),
        ChatMessage(text: 'Oke cảm ơn bạn.', isMe: false, time: '14:35'),
        ChatMessage(
          text:
              'Minh Mẫn: Các bạn nhớ tối nay 22h deadline nộp file bài tập nhóm nhen! Ai chưa làm xong phần mình thì tranh thủ nha.',
          isMe: false,
          time: '18:00',
        ),
      ],
    ),
    ChatThread(
      id: '3',
      name: 'ThS. Trần Thị B - Cố vấn học tập',
      lastMessage:
          'Em nhớ cập nhật điểm rèn luyện cá nhân trên trang sinh viên trước thứ 6 này để cô duyệt nha.',
      time: 'T2',
      unreadCount: 0,
      isOnline: true,
      isGroup: false,
      messages: [
        ChatMessage(
          text:
              'Dạ cô ơi, điều kiện để được xét học bổng khuyến khích học tập kỳ tới là cần GPA bao nhiêu vậy ạ?',
          isMe: true,
          time: '09:00',
        ),
        ChatMessage(
          text:
              'Tùy theo số lượng sinh viên đăng ký nha em, nhưng thường để an toàn thì điểm phải từ 8.5 trở lên em ạ.',
          isMe: false,
          time: '10:30',
        ),
        ChatMessage(
          text: 'Dạ vâng, em cảm ơn cô ạ.',
          isMe: true,
          time: '10:35',
        ),
        ChatMessage(
          text:
              'Em nhớ cập nhật điểm rèn luyện cá nhân trên trang sinh viên trước thứ 6 này để cô duyệt nha.',
          isMe: false,
          time: 'T2',
        ),
      ],
    ),
    ChatThread(
      id: '4',
      name: 'Nhóm đồ án LTUD Mobile',
      lastMessage: 'Tuấn: Nay code xong push lên git nhớ báo nha.',
      time: 'T7 tuần trước',
      unreadCount: 5,
      isOnline: false,
      isGroup: true,
      messages: [
        ChatMessage(
          text: 'Tối nay 8h mình họp online chia task làm giao diện nha.',
          isMe: false,
          time: '19:00',
        ),
        ChatMessage(
          text: 'Ok nè, tui làm phần Dashboard với Black Box nha.',
          isMe: true,
          time: '19:15',
        ),
        ChatMessage(
          text: 'Tuấn: Nay code xong push lên git nhớ báo nha.',
          isMe: false,
          time: 'T7 tuần trước',
        ),
      ],
    ),
  ];

  List<ChatThread> get threads => _threads;

  int get totalUnreadCount =>
      _threads.fold(0, (sum, thread) => sum + thread.unreadCount);

  ChatThread getThread(String id) {
    return _threads.firstWhere((t) => t.id == id);
  }

  void markThreadAsRead(String id) {
    var index = _threads.indexWhere((t) => t.id == id);
    if (index != -1 && _threads[index].unreadCount > 0) {
      _threads[index].unreadCount = 0;
      notifyListeners();
    }
  }

  void sendMessage(String threadId, String text) {
    var index = _threads.indexWhere((t) => t.id == threadId);
    if (index != -1) {
      final now = DateTime.now();
      final h = now.hour.toString().padLeft(2, '0');
      final m = now.minute.toString().padLeft(2, '0');
      final timeString = '$h:$m';

      _threads[index].messages.add(
        ChatMessage(text: text, isMe: true, time: timeString),
      );
      notifyListeners();
    }
  }
}
