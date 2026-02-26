class DeadlineItem {
  final String id;
  final String title;
  final String subject;
  final String time;
  final String status; // 'urgent', 'normal', 'overdue'
  bool isCompleted;

  DeadlineItem({
    required this.id,
    required this.title,
    required this.subject,
    required this.time,
    required this.status,
    this.isCompleted = false,
  });
}
