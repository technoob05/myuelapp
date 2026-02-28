import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../providers/deadline_provider.dart';
import '../models/deadline_model.dart';
import 'all_deadlines_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month);
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeadlineProvider>(context);
    final deadlines = provider.getDeadlinesByDate(_selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Lịch biểu thông minh'),
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
          IconButton(
            icon: const Icon(LucideIcons.calendarPlus),
            onPressed: _syncGoogleCalendar,
            tooltip: 'Đồng bộ Google Calendar',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMonthPicker(),
          _buildWeeklyCalendar(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(deadlines.length),
                  const SizedBox(height: 16),
                  Expanded(
                    child: deadlines.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            itemCount: deadlines.length,
                            padding: const EdgeInsets.only(bottom: 80),
                            itemBuilder: (context, index) =>
                                _buildDeadlineItem(deadlines[index]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDeadlineModal,
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(LucideIcons.plus, color: Colors.white),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return Container(
      height: 50,
      color: AppColors.primaryBlue.withValues(alpha: 0.05),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final month = DateTime(_selectedDate.year, index + 1);
          final isSelected = _focusedMonth.month == month.month;
          return GestureDetector(
            onTap: () {
              setState(() {
                _focusedMonth = month;
                _selectedDate = DateTime(month.year, month.month, 1);
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              child: Center(
                child: Text(
                  'Tháng ${index + 1}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primaryBlue,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeeklyCalendar() {
    DateTime firstDayOfWeek = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday - 1),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat(
                    'MMMM yyyy',
                    'vi_VN',
                  ).format(_selectedDate).toUpperCase(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryBlue,
                    letterSpacing: 1.1,
                  ),
                ),
                Row(
                  children: [
                    _buildNavIconButton(LucideIcons.chevronLeft, () {
                      setState(() {
                        _selectedDate = _selectedDate.subtract(
                          const Duration(days: 7),
                        );
                        _focusedMonth = DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                        );
                      });
                    }),
                    const SizedBox(width: 8),
                    _buildNavIconButton(LucideIcons.chevronRight, () {
                      setState(() {
                        _selectedDate = _selectedDate.add(
                          const Duration(days: 7),
                        );
                        _focusedMonth = DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                        );
                      });
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              DateTime day = firstDayOfWeek.add(Duration(days: index));
              bool isSelected =
                  day.year == _selectedDate.year &&
                  day.month == _selectedDate.month &&
                  day.day == _selectedDate.day;
              bool isToday =
                  day.year == DateTime.now().year &&
                  day.month == DateTime.now().month &&
                  day.day == DateTime.now().day;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = day;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryBlue.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getWeekdayShort(day.weekday),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textLight,
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isToday && !isSelected)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIconButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 18, color: AppColors.primaryBlue),
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        padding: EdgeInsets.zero,
      ),
    );
  }

  String _getWeekdayShort(int weekday) {
    switch (weekday) {
      case 1:
        return 'T2';
      case 2:
        return 'T3';
      case 3:
        return 'T4';
      case 4:
        return 'T5';
      case 5:
        return 'T6';
      case 6:
        return 'T7';
      case 7:
        return 'CN';
      default:
        return '';
    }
  }

  Widget _buildSectionHeader(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lịch trình chi tiết', style: AppTextStyles.sectionHeader),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllDeadlinesScreen(),
                  ),
                );
              },
              child: Text(
                'Xem tất cả lịch trình →',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                DateFormat('dd/MM').format(_selectedDate),
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                DateFormat('yyyy').format(_selectedDate),
                style: TextStyle(
                  color: AppColors.primaryBlue.withValues(alpha: 0.6),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.calendarX,
            size: 70,
            color: AppColors.textLight.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          Text(
            'Ngày này trống lịch!',
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textLight),
          ),
          const SizedBox(height: 8),
          Text(
            'Tận hưởng thời gian nghỉ ngơi nhé.',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildDeadlineItem(DeadlineItem deadline) {
    Color typeColor;
    IconData typeIcon;
    String typeLabel;

    switch (deadline.type) {
      case 'exam':
        typeColor = const Color(0xFFEF4444);
        typeIcon = LucideIcons.graduationCap;
        typeLabel = 'LỊCH THI';
        break;
      case 'class':
        typeColor = const Color(0xFF3B82F6);
        typeIcon = LucideIcons.bookOpen;
        typeLabel = 'LỊCH HỌC';
        break;
      default:
        typeColor = const Color(0xFFF59E0B);
        typeIcon = LucideIcons.pencil;
        typeLabel = 'BÀI TẬP';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: deadline.isCompleted
            ? Colors.grey.withValues(alpha: 0.02)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!deadline.isCompleted)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
        border: Border.all(
          color: deadline.isCompleted
              ? Colors.grey.withValues(alpha: 0.2)
              : typeColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 5,
                color: deadline.isCompleted ? Colors.grey : typeColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (deadline.isCompleted
                                          ? Colors.grey
                                          : typeColor)
                                      .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  deadline.isCompleted
                                      ? LucideIcons.checkCircle2
                                      : typeIcon,
                                  size: 12,
                                  color: deadline.isCompleted
                                      ? Colors.grey
                                      : typeColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  deadline.isCompleted
                                      ? 'HOÀN THÀNH'
                                      : typeLabel,
                                  style: TextStyle(
                                    color: deadline.isCompleted
                                        ? Colors.grey
                                        : typeColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                DateFormat('HH:mm').format(deadline.time),
                                style: TextStyle(
                                  color: deadline.isCompleted
                                      ? Colors.grey
                                      : AppColors.primaryBlue,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  decoration: deadline.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<DeadlineProvider>(
                                    context,
                                    listen: false,
                                  ).toggleComplete(deadline.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: deadline.isCompleted
                                        ? AppColors.successGreen
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: deadline.isCompleted
                                          ? AppColors.successGreen
                                          : Colors.grey.withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Icon(
                                    LucideIcons.check,
                                    size: 14,
                                    color: deadline.isCompleted
                                        ? Colors.white
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        deadline.title,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: deadline.isCompleted
                              ? Colors.grey
                              : AppColors.textDark,
                          decoration: deadline.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        deadline.subject,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                      if (deadline.location != null ||
                          deadline.lecturer != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Divider(
                            color: Colors.grey.withValues(alpha: 0.1),
                            height: 1,
                          ),
                        ),
                        Row(
                          children: [
                            if (deadline.location != null)
                              Expanded(
                                child: _buildInfoRow(
                                  LucideIcons.mapPin,
                                  deadline.location!,
                                ),
                              ),
                            if (deadline.lecturer != null)
                              Expanded(
                                child: _buildInfoRow(
                                  LucideIcons.user,
                                  deadline.lecturer!,
                                ),
                              ),
                          ],
                        ),
                      ],
                      if (deadline.note != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Ghi chú: ${deadline.note}',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.textBody,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.textLight),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Future<void> _showAddDeadlineModal() async {
    final titleController = TextEditingController();
    final subjectController = TextEditingController();
    final locationController = TextEditingController();
    final noteController = TextEditingController();
    DateTime pickedDate = _selectedDate;
    TimeOfDay pickedTime = TimeOfDay.now();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 20,
            left: 24,
            right: 24,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Thêm lịch trình', style: AppTextStyles.heading1),
              const SizedBox(height: 20),
              _buildModalTextField(
                titleController,
                'Tiêu đề (VD: Nộp báo cáo)',
                LucideIcons.type,
              ),
              const SizedBox(height: 12),
              _buildModalTextField(
                subjectController,
                'Môn học',
                LucideIcons.book,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildPickerButton(
                      DateFormat('dd/MM/yyyy').format(pickedDate),
                      LucideIcons.calendar,
                      () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: pickedDate,
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2030),
                        );
                        if (d != null) setModalState(() => pickedDate = d);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildPickerButton(
                      pickedTime.format(context),
                      LucideIcons.clock,
                      () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime: pickedTime,
                        );
                        if (t != null) setModalState(() => pickedTime = t);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildModalTextField(
                locationController,
                'Địa điểm (Phòng học/Link)',
                LucideIcons.mapPin,
              ),
              const SizedBox(height: 12),
              _buildModalTextField(
                noteController,
                'Ghi chú thêm',
                LucideIcons.stickyNote,
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      final dt = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      Provider.of<DeadlineProvider>(
                        context,
                        listen: false,
                      ).addDeadline(
                        titleController.text,
                        subjectController.text,
                        dt,
                        location: locationController.text.isEmpty
                            ? null
                            : locationController.text,
                        note: noteController.text.isEmpty
                            ? null
                            : noteController.text,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã lưu lịch trình mới!'),
                          backgroundColor: AppColors.successGreen,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'LƯU LỊCH TRÌNH',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: AppColors.primaryBlue),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPickerButton(String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primaryBlue),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
