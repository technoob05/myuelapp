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
  int unreadCount;
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
