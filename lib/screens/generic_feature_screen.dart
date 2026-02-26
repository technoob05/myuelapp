import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

enum FeatureCategory { schedule, stats, documents, general }

class GenericFeatureScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const GenericFeatureScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  FeatureCategory _getCategory() {
    final t = title.toLowerCase();
    if (t.contains('lịch') || t.contains('chuyên cần')) {
      return FeatureCategory.schedule;
    }
    if (t.contains('kết quả học tập') ||
        t.contains('rèn luyện') ||
        t.contains('chương trình')) {
      return FeatureCategory.stats;
    }
    if (t.contains('phí') ||
        t.contains('hoá đơn') ||
        t.contains('đăng ký') ||
        t.contains('quyết định') ||
        t.contains('chứng chỉ') ||
        t.contains('tốt nghiệp') ||
        t.contains('y-shop')) {
      return FeatureCategory.documents;
    }
    return FeatureCategory.general;
  }

  @override
  Widget build(BuildContext context) {
    final category = _getCategory();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          _buildPremiumHeader(),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(child: _buildDynamicBody(category)),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }

  Widget _buildPremiumHeader() {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: AppColors.primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryBlue, Color(0xFF1E40AF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -20,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(icon, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dữ liệu đồng bộ trực tiếp từ hệ thống UIS UEL',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicBody(FeatureCategory category) {
    switch (category) {
      case FeatureCategory.schedule:
        return _buildScheduleView();
      case FeatureCategory.stats:
        return _buildStatsView();
      case FeatureCategory.documents:
        return _buildDocumentsView();
      default:
        return _buildGeneralView();
    }
  }

  // ==========================================
  // VIEW 1: TIMELINE / CALENDAR / SCHEDULE
  // ==========================================
  Widget _buildScheduleView() {
    List<Map<String, dynamic>> scheduleData = [];
    String headerText = 'Lịch Trình Hôm Nay';

    if (title.toLowerCase().contains('thi')) {
      headerText = 'Lịch Thi Sắp Tới';
      scheduleData = [
        {
          'day': '15/12',
          'time': '07:30 - 09:00',
          'subject': 'Kinh Tế Vi Mô',
          'room': 'Phòng B1.205',
          'status': 'Sắp diễn ra',
          'color': AppColors.warningYellow,
        },
        {
          'day': '18/12',
          'time': '09:30 - 11:30',
          'subject': 'Toán Cao Cấp A1',
          'room': 'Phòng C1.102',
          'status': 'Tuần sau',
          'color': AppColors.primaryBlue,
        },
      ];
    } else if (title.toLowerCase().contains('chuyên cần')) {
      headerText = 'Báo Cáo Chuyên Cần';
      scheduleData = [
        {
          'day': 'T7',
          'time': 'Tuần 1-15',
          'subject': 'Lịch sử Đảng',
          'room': 'Hiện diện: 100%',
          'status': 'TỐT',
          'color': AppColors.successGreen,
        },
        {
          'day': 'T4',
          'time': 'Tuần 1-15',
          'subject': 'Toán Cao Cấp',
          'room': 'Vắng: 1 phép',
          'status': 'ĐẠT',
          'color': AppColors.successGreen,
        },
        {
          'day': 'T6',
          'time': 'Tuần 1-15',
          'subject': 'GD Thể Chất',
          'room': 'Vắng: 2 KP',
          'status': 'CẢNH BÁO',
          'color': AppColors.errorRed,
        },
      ];
    } else {
      scheduleData = [
        {
          'day': 'Hôm nay',
          'time': '07:30 - 09:30',
          'subject': 'Toán Cao Cấp A1',
          'room': 'Phòng B1.205',
          'status': 'Sắp diễn ra',
          'color': AppColors.warningYellow,
        },
        {
          'day': 'Hôm nay',
          'time': '10:00 - 12:00',
          'subject': 'Kinh Tế Vi Mô',
          'room': 'Phòng C1.102',
          'status': 'Đang học',
          'color': AppColors.primaryBlue,
        },
        {
          'day': 'Ngày mai',
          'time': '13:00 - 15:30',
          'subject': 'Triết Học Mác - Lênin',
          'room': 'Phòng A2.301',
          'status': 'Chưa HĐ',
          'color': AppColors.textLight,
        },
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(headerText, style: AppTextStyles.sectionHeader),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.calendar, size: 16),
              label: const Text('Tháng này'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...scheduleData.map((data) => _buildTimelineCard(data)),
      ],
    );
  }

  Widget _buildTimelineCard(Map<String, dynamic> data) {
    Color statusColor = data['color'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['day'],
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  data['time'].split(' - ')[0],
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4, right: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
              border: Border.all(
                color: statusColor.withValues(alpha: 0.3),
                width: 4,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: statusColor.withValues(alpha: 0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['subject'],
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        size: 14,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(data['room'], style: AppTextStyles.bodySmall),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data['status'],
                          style: TextStyle(
                            color: statusColor,
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
          ),
        ],
      ),
    );
  }

  // ==========================================
  // VIEW 2: STATS / DASHBOARD
  // ==========================================
  Widget _buildStatsView() {
    String card1Title = 'GPA Hiện Tại';
    String card1Val = '8.45';
    String card1Sub = 'Loại Giỏi';
    String card2Title = 'Tín Chỉ';
    String card2Val = '110';
    String card2Sub = '/ 120 (91%)';
    List<Widget> listItems = [];

    final t = title.toLowerCase();
    if (t.contains('rèn luyện')) {
      card1Title = 'Điểm RL HK1';
      card1Val = '95';
      card1Sub = 'Loại Xuất Sắc';
      card2Title = 'Điểm RL HK2';
      card2Val = '88';
      card2Sub = 'Loại Tốt';
      listItems = [
        _buildStatListItem('Tham gia NCKH', 'Cấp khoa (HK1)', '+10đ'),
        _buildStatListItem('Ban điều hành CLB', 'CLB IT UEL', '+15đ'),
        _buildStatListItem(
          'Khai báo y tế/Sổ tự quản',
          'Đầy đủ, đúng hạn',
          '+5đ',
        ),
      ];
    } else if (t.contains('chương trình')) {
      card1Title = 'Chuyên Ngành';
      card1Val = 'IS';
      card1Sub = 'Hệ Thống TT';
      card2Title = 'Tiến Độ';
      card2Val = '91%';
      card2Sub = 'Đúng tiến độ';
      listItems = [
        _buildStatListItem('Khối MT căn bản', 'Hoàn tất 100%', '30 TC'),
        _buildStatListItem('Khối MT chuyên ngành', 'Đang học 90%', '45 TC'),
        _buildStatListItem('Thực tập tốt nghiệp', 'Chưa bắt đầu', '0 TC'),
      ];
    } else {
      listItems = [
        _buildStatListItem('HK1 2026-2027', 'GPA: 8.5 - Tín chỉ: 18', 'Giỏi'),
        _buildStatListItem('HK2 2025-2026', 'GPA: 8.2 - Tín chỉ: 20', 'Giỏi'),
        _buildStatListItem('HK1 2025-2026', 'GPA: 7.9 - Tín chỉ: 17', 'Khá'),
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildGradientStatCard(card1Title, card1Val, card1Sub, [
                const Color(0xFF3B82F6),
                const Color(0xFF2563EB),
              ]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildGradientStatCard(card2Title, card2Val, card2Sub, [
                const Color(0xFF10B981),
                const Color(0xFF059669),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('Chi Tiết Báo Cáo', style: AppTextStyles.sectionHeader),
        const SizedBox(height: 16),
        ...listItems,
      ],
    );
  }

  Widget _buildGradientStatCard(
    String title,
    String mainValue,
    String subValue,
    List<Color> colors,
  ) {
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
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            mainValue,
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subValue,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatListItem(String title, String subtitle, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.barChart, color: AppColors.primaryBlue),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: AppTextStyles.bodyMedium),
        trailing: Text(
          value,
          style: AppTextStyles.heading1.copyWith(
            color: AppColors.primaryBlue,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // VIEW 3: DOCUMENTS / FORMS / PAYMENTS
  // ==========================================
  Widget _buildDocumentsView() {
    List<Map<String, dynamic>> docData = [];
    List<Widget> topAlert = [];
    final t = title.toLowerCase();

    if (t.contains('phí') || t.contains('hoá đơn')) {
      topAlert = [
        _buildTopAlert(
          'Bạn có 1 mục học phí cần thanh toán gấp!',
          AppColors.errorRed,
        ),
      ];
      docData = [
        {
          'title': 'Học phí Học kỳ 1 (2026-2027)',
          'desc': 'Hạn nộp: 30/11/2026 - Tổng: 14.500.000đ',
          'status': 'Chưa nộp',
          'type': 'alert',
        },
        {
          'title': 'Lệ phí BHYT, BHTN 2026',
          'desc': 'Thanh toán qua MoMo ngày 05/09/2026',
          'status': 'Hoàn tất',
          'type': 'success',
        },
      ];
    } else if (t.contains('chứng chỉ')) {
      docData = [
        {
          'title': 'Chứng chỉ TOEIC',
          'desc': 'Điểm: 850 - Hết hạn: 12/2027',
          'status': 'Hợp lệ',
          'type': 'success',
        },
        {
          'title': 'Chứng chỉ Tin Học IC3',
          'desc': 'Đã nộp bản photo có công chứng',
          'status': 'Đã duyệt',
          'type': 'success',
        },
        {
          'title': 'Kỹ năng mềm (3 chuyên đề)',
          'desc': 'Còn thiếu 1 chuyên đề',
          'status': 'Chưa đạt',
          'type': 'pending',
        },
      ];
    } else if (t.contains('đăng ký')) {
      topAlert = [
        _buildTopAlert(
          'Đợt đăng ký học phần bổ sung đang mở!',
          AppColors.primaryBlue,
        ),
      ];
      docData = [
        {
          'title': 'Kế toán quản trị (K24417A)',
          'desc': 'Số TC: 3 - Giảng viên: Trần Văn A',
          'status': 'Lưu thành công',
          'type': 'success',
        },
        {
          'title': 'Pháp luật đại cương (K24417B)',
          'desc': 'Số TC: 2 - Giảng viên: Nguyễn Thị B',
          'status': 'Đã huỷ',
          'type': 'alert',
        },
        {
          'title': 'Kinh tế lượng (K24417C)',
          'desc': 'Đang vào danh sách lớp chờ',
          'status': 'Pending',
          'type': 'pending',
        },
      ];
    } else if (t.contains('quyết định')) {
      docData = [
        {
          'title': 'Quyết định khen thưởng HK2 (2025-2026)',
          'desc': 'Sinh viên đạt danh hiệu Sinh viên Giỏi',
          'status': 'Đã phát hành',
          'type': 'success',
        },
        {
          'title': 'Quyết định cấp học bổng',
          'desc': 'Học bổng KKHT loại Khá',
          'status': 'Đã chuyển khoản',
          'type': 'success',
        },
      ];
    } else if (t.contains('tốt nghiệp')) {
      docData = [
        {
          'title': 'Trạng thái xét tốt nghiệp',
          'desc':
              'Đủ điều kiện xét (Đã nộp đủ chứng chỉ, hoàn thành 100% CTĐT)',
          'status': 'Chờ Hội Đồng',
          'type': 'pending',
        },
        {
          'title': 'Lệ phí xét tốt nghiệp',
          'desc': '250.000đ',
          'status': 'Chưa nộp',
          'type': 'alert',
        },
      ];
    } else {
      docData = [
        {
          'title': 'Mục hiện tại trống',
          'desc': 'Chưa có thông tin mới',
          'status': 'OK',
          'type': 'success',
        },
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...topAlert,
        if (topAlert.isNotEmpty) const SizedBox(height: 24),
        Text('Danh sách Hồ sơ / Giao dịch', style: AppTextStyles.sectionHeader),
        const SizedBox(height: 16),
        ...docData.map((d) => _buildDocCard(d)),
      ],
    );
  }

  Widget _buildTopAlert(String msg, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.info, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              msg,
              style: AppTextStyles.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocCard(Map<String, dynamic> data) {
    Color statusColor;
    IconData statusIcon;

    switch (data['type']) {
      case 'alert':
        statusColor = AppColors.errorRed;
        statusIcon = LucideIcons.alertCircle;
        break;
      case 'success':
        statusColor = AppColors.successGreen;
        statusIcon = LucideIcons.checkCircle2;
        break;
      default:
        statusColor = AppColors.warningYellow;
        statusIcon = LucideIcons.clock;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(data['desc'], style: AppTextStyles.bodyMedium),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 14, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        data['status'],
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (data['type'] == 'alert') ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Thanh toán ngay',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ==========================================
  // GENERAL FALLBACK VIEW
  // ==========================================
  Widget _buildGeneralView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Icon(
            icon,
            size: 80,
            color: AppColors.iconUnselected.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text('Tính năng đang được phát triển', style: AppTextStyles.heading1),
          const SizedBox(height: 8),
          Text(
            'Phiên bản đầy đủ của $title sẽ sớm được ra mắt trong bản cập nhật tới.',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
