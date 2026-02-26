import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

import 'package:provider/provider.dart';
import '../providers/deadline_provider.dart';
import '../models/deadline_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  void _toggleComplete(String id) {
    Provider.of<DeadlineProvider>(context, listen: false).toggleComplete(id);
  }

  void _syncGoogleCalendar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã đồng bộ thành công với Google Calendar!'),
        backgroundColor: AppColors.successGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAddDeadlineModal() {
    final titleController = TextEditingController();
    final subjectController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thêm Deadline mới', style: AppTextStyles.heading1),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Tiêu đề bài tập/thi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.cardWhite,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: 'Môn học',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.cardWhite,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        subjectController.text.isNotEmpty) {
                      Provider.of<DeadlineProvider>(
                        context,
                        listen: false,
                      ).addDeadline(
                        titleController.text,
                        subjectController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Lưu Deadline',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeadlineProvider>(context);
    final deadlines = provider.deadlines;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Deadline'),
        backgroundColor: AppColors.primaryBlue,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.calendarPlus),
            onPressed: _syncGoogleCalendar,
            tooltip: 'Đồng bộ Google Calendar',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeeklyCalendar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Công việc sắp tới',
              style: AppTextStyles.sectionHeader,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: deadlines.length,
              itemBuilder: (context, index) {
                final deadline = deadlines[index];
                return _buildDeadlineItem(deadline);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
        child: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            onPressed: _showAddDeadlineModal,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                28,
              ), // Perfect round shape like chat bubble
            ),
            backgroundColor: AppColors.primaryBlue,
            child: const Icon(LucideIcons.plus, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyCalendar() {
    final List<String> days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    final List<String> dates = ['12', '13', '14', '15', '16', '17', '18'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (index) {
          final isToday = index == 3; // Mock Thursday as today
          return Column(
            children: [
              Text(
                days[index],
                style: TextStyle(
                  color: isToday ? Colors.white : Colors.white70,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isToday ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  dates[index],
                  style: TextStyle(
                    color: isToday ? AppColors.primaryBlue : Colors.white,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              if (index == 2 || index == 3 || index == 5)
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.warningYellow,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 6),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDeadlineItem(DeadlineItem deadline) {
    Color statusColor;
    if (deadline.isCompleted) {
      statusColor = AppColors.successGreen;
    } else {
      switch (deadline.status) {
        case 'urgent':
          statusColor = AppColors.warningYellow;
          break;
        case 'overdue':
          statusColor = AppColors.errorRed;
          break;
        default:
          statusColor = AppColors.primaryBlue;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(
              alpha: deadline.isCompleted ? 0.05 : 0.15,
            ),
            blurRadius: deadline.isCompleted ? 4 : 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: deadline.isCompleted
              ? Colors.grey.withValues(alpha: 0.2)
              : statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: statusColor,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.5),
                      blurRadius: 8,
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _toggleComplete(deadline.id),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: deadline.isCompleted
                                  ? AppColors.successGreen
                                  : Colors.grey,
                              width: 2,
                            ),
                            color: deadline.isCompleted
                                ? AppColors.successGreen
                                : Colors.transparent,
                          ),
                          child: deadline.isCompleted
                              ? const Icon(
                                  LucideIcons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deadline.title,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: deadline.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: deadline.isCompleted
                                    ? AppColors.textLight
                                    : AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              deadline.subject,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: deadline.isCompleted
                                    ? AppColors.textLight
                                    : AppColors.textBody,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    LucideIcons.clock,
                                    size: 14,
                                    color: statusColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    deadline.time,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
