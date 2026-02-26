import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

class ChatThread {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isGroup;
  final List<ChatMessage> messages;

  ChatThread({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.isGroup,
    required this.messages,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  void _openChat(ChatThread thread) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatDetailScreen(thread: thread)),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Chat'),
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Tin nhắn gần đây', style: AppTextStyles.sectionHeader),
          const SizedBox(height: 16),
          ..._threads.map((thread) => _buildChatItem(thread)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(LucideIcons.messageSquare, color: Colors.white),
      ),
    );
  }

  Widget _buildChatItem(ChatThread thread) {
    return InkWell(
      onTap: () => _openChat(thread),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: thread.unreadCount > 0
              ? AppColors.primaryBlue.withValues(alpha: 0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: thread.isGroup
                          ? [AppColors.primaryBlue, const Color(0xFF1E40AF)]
                          : [Colors.grey.shade300, Colors.grey.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(
                    thread.isGroup ? LucideIcons.users : LucideIcons.user,
                    color: thread.isGroup ? Colors.white : Colors.white70,
                    size: 24,
                  ),
                ),
                if (thread.isOnline)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.successGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          thread.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: thread.unreadCount > 0
                                ? FontWeight.bold
                                : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        thread.time,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: thread.unreadCount > 0
                              ? AppColors.primaryBlue
                              : AppColors.textLight,
                          fontWeight: thread.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: thread.unreadCount > 0
                                ? AppColors.textDark
                                : AppColors.textBody,
                            fontWeight: thread.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (thread.unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            thread.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final ChatThread thread;

  const ChatDetailScreen({super.key, required this.thread});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.thread.messages);
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _controller.text.trim(),
          isMe: true,
          time: 'Vừa xong',
        ),
      );
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thread.name),
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
          IconButton(icon: const Icon(LucideIcons.phone), onPressed: () {}),
          IconButton(icon: const Icon(LucideIcons.video), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: message.isMe
                ? const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(20).copyWith(
              bottomRight: message.isMe
                  ? const Radius.circular(4)
                  : const Radius.circular(20),
              bottomLeft: !message.isMe
                  ? const Radius.circular(4)
                  : const Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: message.isMe
                      ? AppColors.textWhite
                      : AppColors.textDark,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.time,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: message.isMe
                          ? AppColors.textWhite.withValues(alpha: 0.7)
                          : AppColors.textLight,
                      fontSize: 10,
                    ),
                  ),
                  if (message.isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      LucideIcons.checkCheck,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                LucideIcons.paperclip,
                color: AppColors.iconUnselected,
              ),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Nhập tin nhắn...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textLight,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.scaffoldBackground,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.primaryBlue,
              child: IconButton(
                icon: const Icon(
                  LucideIcons.send,
                  color: AppColors.textWhite,
                  size: 18,
                ),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
