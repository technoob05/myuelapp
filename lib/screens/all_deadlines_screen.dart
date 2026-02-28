import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../providers/deadline_provider.dart';
import '../models/deadline_model.dart';

class AllDeadlinesScreen extends StatelessWidget {
  const AllDeadlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeadlineProvider>(context);
    final allDeadlines = List<DeadlineItem>.from(provider.deadlines);

    // Sort: Non-completed first, then by date
    allDeadlines.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return a.time.compareTo(b.time);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Tất cả lịch trình'),
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
      body: allDeadlines.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: allDeadlines.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, allDeadlines[index]),
            ),
    );
  }

  Widget _buildListItem(BuildContext context, DeadlineItem item) {
    Color typeColor;
    switch (item.type) {
      case 'exam':
        typeColor = const Color(0xFFEF4444);
        break;
      case 'class':
        typeColor = const Color(0xFF3B82F6);
        break;
      default:
        typeColor = const Color(0xFFF59E0B);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: item.isCompleted
            ? Colors.grey.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isCompleted
              ? Colors.grey.withValues(alpha: 0.2)
              : typeColor.withValues(alpha: 0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (item.isCompleted ? Colors.grey : typeColor).withValues(
              alpha: 0.1,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item.isCompleted ? LucideIcons.check : _getIcon(item.type),
            color: item.isCompleted ? Colors.grey : typeColor,
            size: 20,
          ),
        ),
        title: Text(
          item.title,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
            color: item.isCompleted ? Colors.grey : AppColors.textDark,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${DateFormat('dd/MM/yyyy - HH:mm').format(item.time)}${item.isRecurring ? ' (Định kỳ)' : ''}',
              style: AppTextStyles.bodySmall,
            ),
            Text(
              item.subject,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            item.isCompleted ? LucideIcons.checkCircle2 : LucideIcons.circle,
            color: item.isCompleted
                ? AppColors.successGreen
                : Colors.grey.withValues(alpha: 0.3),
          ),
          onPressed: () {
            Provider.of<DeadlineProvider>(
              context,
              listen: false,
            ).toggleComplete(item.id);
          },
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'exam':
        return LucideIcons.graduationCap;
      case 'class':
        return LucideIcons.bookOpen;
      default:
        return LucideIcons.pencil;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.listTodo, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text('Chưa có dữ liệu nào', style: AppTextStyles.bodyLarge),
        ],
      ),
    );
  }
}
