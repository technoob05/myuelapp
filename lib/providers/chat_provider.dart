import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatThread> _threads = [
    ChatThread(
      id: '1',
      name: 'PhD Nguyễn Thị Nhật Minh - Khoa QTKD',
      lastMessage:
          'Chào em, file hướng dẫn project giữa kì cô đã upload lên khóa học trên hệ thống LMS rồi nhé.',
      time: '14:30',
      unreadCount: 1,
      isOnline: true,
      isGroup: false,
      messages: [
        ChatMessage(text: 'Dạ em chào cô ạ.', isMe: true, time: '14:00'),
        ChatMessage(
          text:
              'Cô cho em hỏi tuần này nhóm em báo cáo project, thủ tục nộp bài như thế nào ạ?',
          isMe: true,
          time: '14:05',
        ),
        ChatMessage(
          text:
              'Chào em, file hướng dẫn project giữa kì cô đã upload lên khóa học trên hệ thống LMS rồi nhé.',
          isMe: false,
          time: '14:30',
        ),
      ],
    ),
    ChatThread(
      id: '2',
      name: 'K234102E',
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
      name: '[UEL] QTTH_ 252EBM505502',
      lastMessage: 'Linh: Vậy mình học bù sáng thứ 7 nha các em.',
      time: 'T2',
      unreadCount: 0,
      isOnline: true,
      isGroup: true,
      messages: [
        ChatMessage(
          text:
              'Ngô Dung: Lớp mình bạn nào có đăng ký đi hội thảo sáng nay thì tranh thủ điểm danh ở hội trường nha các em.',
          isMe: false,
          time: '09:00',
        ),
        ChatMessage(text: 'Dạ vâng ạ.', isMe: true, time: '09:15'),
        ChatMessage(
          text: 'Linh: Vậy mình học bù sáng thứ 7 nha các em.',
          isMe: false,
          time: 'T2',
        ),
      ],
    ),
    ChatThread(
      id: '4',
      name: '[GTKD] FAMILY MART',
      lastMessage: 'Lực: Nhớ làm bài đúng deadline nhé.',
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
          text: 'Lực: Nhớ làm bài đúng deadline nhé.',
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
