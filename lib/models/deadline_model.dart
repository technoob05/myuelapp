class DeadlineItem {
  final String id;
  final String title;
  final String subject;
  final DateTime time;
  final String status; // 'urgent', 'normal', 'overdue'
  final String type; // 'class', 'exam', 'assignment'
  final String? location;
  final String? note;
  final String? lecturer;
  final bool isRecurring;
  bool isCompleted;

  DeadlineItem({
    required this.id,
    required this.title,
    required this.subject,
    required this.time,
    required this.status,
    required this.type,
    this.location,
    this.note,
    this.lecturer,
    this.isRecurring = false,
    this.isCompleted = false,
  });
}
