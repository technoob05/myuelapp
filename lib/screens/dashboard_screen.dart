import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data & Analytics'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tổng quan học tập', style: AppTextStyles.sectionHeader),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildPremiumStatCard(
                    title: 'Điểm TB',
                    value: '8.45',
                    subtitle: 'Giỏi',
                    progress: 8.45 / 10,
                    icon: LucideIcons.graduationCap,
                    colors: [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPremiumStatCard(
                    title: 'Tín chỉ',
                    value: '110',
                    subtitle: '/ 120 (91%)',
                    progress: 110 / 120,
                    icon: LucideIcons.bookOpen,
                    colors: [const Color(0xFF10B981), const Color(0xFF059669)],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Tần suất truy cập & Học tập (7 ngày)',
              style: AppTextStyles.sectionHeader,
            ),
            const SizedBox(height: 16),
            _buildBarChart(),
            const SizedBox(height: 24),
            Text(
              'Phân tích hành vi & Báo cáo',
              style: AppTextStyles.sectionHeader,
            ),
            const SizedBox(height: 16),
            _buildBehaviorList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumStatCard({
    required String title,
    required String value,
    required String subtitle,
    required double progress,
    required IconData icon,
    required List<Color> colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors[0].withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              // Small Circular Progress Indicator
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 3,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            value,
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$title - $subtitle',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final List<Map<String, dynamic>> chartData = [
      {'day': 'T2', 'value': 40.0, 'active': false},
      {'day': 'T3', 'value': 60.0, 'active': false},
      {'day': 'T4', 'value': 30.0, 'active': false},
      {'day': 'T5', 'value': 80.0, 'active': true}, // Active day
      {'day': 'T6', 'value': 50.0, 'active': false},
      {'day': 'T7', 'value': 90.0, 'active': false},
      {'day': 'CN', 'value': 20.0, 'active': false},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 180,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: chartData.map((data) {
            final double heightParam = data['value'] as double;
            final bool isActive = data['active'] as bool;
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isActive)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '80%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Container(
                  width: 32,
                  height: heightParam,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isActive
                          ? [AppColors.primaryBlue, const Color(0xFF1E40AF)]
                          : [
                              AppColors.iconUnselected.withValues(alpha: 0.2),
                              AppColors.iconUnselected.withValues(alpha: 0.1),
                            ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data['day'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive
                        ? AppColors.primaryBlue
                        : AppColors.textLight,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBehaviorList() {
    return Column(
      children: [
        _buildDetailCard(
          'Chuyên cần',
          'Hiện diện 100% các môn học, thường xuyên truy cập thư viện số',
          'RẤT TỐT',
          LucideIcons.checkCircle2,
          AppColors.successGreen,
        ),
        _buildDetailCard(
          'Bài tập (E-learning)',
          'Tỷ lệ nộp đúng hạn 98%. Điểm QT TB: 8.7',
          'TỐT',
          LucideIcons.barChart2,
          AppColors.primaryBlue,
        ),
        _buildDetailCard(
          'Cảnh báo học tập',
          'Môn Giáo dục thể chất vắng 1 buổi không phép',
          'CHÚ Ý',
          LucideIcons.alertTriangle,
          AppColors.warningYellow,
        ),
        _buildDetailCard(
          'Hoạt động ngoại khóa',
          'Điểm rèn luyện: 95. Đủ ĐK xét học bổng',
          'XUẤT SẮC',
          LucideIcons.award,
          AppColors.successGreen,
        ),
      ],
    );
  }

  Widget _buildDetailCard(
    String title,
    String subtitle,
    String status,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
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
                        title,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textBody,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
