import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

enum FeatureCategory { schedule, stats, documents, general }

class GenericFeatureScreen extends StatefulWidget {
  final String title;
  final IconData icon;

  const GenericFeatureScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  State<GenericFeatureScreen> createState() => _GenericFeatureScreenState();
}

class _GenericFeatureScreenState extends State<GenericFeatureScreen> {
  bool isTableView = false;
  String searchQuery = '';
  String selectedFilter = 'Tất cả';

  FeatureCategory _getCategory() {
    final t = widget.title.toLowerCase();
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
        t.contains('quết định') ||
        t.contains('kết quả đk') ||
        t.contains('chứng chỉ') ||
        t.contains('xét tốt nghiệp')) {
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
            sliver: SliverToBoxAdapter(child: _buildBody(context, category)),
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
                      child: Icon(widget.icon, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.title,
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

  Widget _buildBody(BuildContext context, FeatureCategory category) {
    switch (category) {
      case FeatureCategory.schedule:
        return _buildScheduleView(context);
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
  Widget _buildScheduleView(BuildContext context) {
    List<Map<String, dynamic>> scheduleData = [];
    String headerText = 'Lịch Trình Hôm Nay';

    if (widget.title.toLowerCase().contains('thi')) {
      headerText = 'Lịch Thi Sắp Tới';
      scheduleData = [
        {
          'code': 'EBM5055',
          'class': '252EBM505502',
          'credits': '3.00',
          'day': '28/03/2026',
          'time': '12g30',
          'subject': 'Quản trị thương hiệu (E)',
          'room': 'Phòng A.604',
          'location': 'Cơ sở Cơ sở chính, KP3 P. Linh Xuân, Thành phố Thủ Đức',
          'status': 'Tự luận',
          'score_deadline': '06/04/2026',
          'color': AppColors.warningYellow,
        },
        {
          'code': 'EIE5042',
          'class': '252EIE504202',
          'credits': '2.00',
          'day': '29/03/2026',
          'time': '10g00',
          'subject': 'Thương mại điện tử (E)',
          'room': 'Online 19',
          'location': 'Cơ sở Cơ sở chính, KP3 P. Linh Xuân, Thành phố Thủ Đức',
          'status': 'Tiểu luận, Đồ án',
          'score_deadline': '06/04/2026',
          'color': AppColors.primaryBlue,
        },
        {
          'code': 'EBB5004',
          'class': '252EBB500402',
          'credits': '2.00',
          'day': '02/04/2026',
          'time': '12g30',
          'subject': 'Giao tiếp kinh doanh (E)',
          'room': 'Phòng A.310 bis',
          'location': 'Cơ sở Cơ sở chính, KP3 P. Linh Xuân, Thành phố Thủ Đức',
          'status': 'Laptop cá nhân',
          'score_deadline': '10/04/2026',
          'color': AppColors.successGreen,
        },
      ];
    } else if (widget.title.toLowerCase().contains('chuyên cần')) {
      headerText = 'Báo Cáo Chuyên Cần';
      scheduleData = [
        {
          'code': 'HIS1001',
          'day': 'T7',
          'time': 'Tuần 1-15',
          'subject': 'Lịch sử Đảng',
          'room': 'Hiện diện: 100%',
          'status': 'TỐT',
          'color': AppColors.successGreen,
          'tag': 'Lý thuyết',
        },
        {
          'code': 'MAT1002',
          'day': 'T4',
          'time': 'Tuần 1-15',
          'subject': 'Toán Cao Cấp',
          'room': 'Vắng: 1 phép',
          'status': 'ĐẠT',
          'color': AppColors.successGreen,
          'tag': 'Lý thuyết',
        },
        {
          'code': 'PHE1003',
          'day': 'T6',
          'time': 'Tuần 1-15',
          'subject': 'GD Thể Chất',
          'room': 'Vắng: 2 KP',
          'status': 'CẢNH BÁO',
          'color': AppColors.errorRed,
          'tag': 'Luyện tập',
        },
      ];
    } else {
      scheduleData = [
        {
          'code': 'MKT3012',
          'day': 'Thứ 2',
          'time': '12:30 - 16:30',
          'subject': 'Marketing kỹ thuật số (E)',
          'room': 'Phòng A.813',
          'location': 'Cơ sở chính, KP3 P. Linh Xuân, Thành phố Thủ Đức',
          'status': 'Cô Vũ Thị Hồng Ngọc',
          'color': AppColors.primaryBlue,
          'tag': 'Lý thuyết',
        },
        {
          'code': 'BUS2004',
          'day': 'Thứ 4',
          'time': '15:15 - 17:45',
          'subject': 'Giao tiếp kinh doanh (E)',
          'room': 'Phòng A.811',
          'location': 'Cơ sở chính, KP3 P. Linh Xuân, Thành phố Thủ Đức',
          'status': 'Cô Nguyễn Thị Nhật Minh',
          'color': AppColors.warningYellow,
          'tag': 'Bổ sung',
        },
        {
          'code': 'EBM1042',
          'day': 'Thứ 6',
          'time': '09:45 - 12:15',
          'subject': 'Thương mại điện tử (E)',
          'room': 'Phòng A.813',
          'location': 'Cơ sở chính, KP3 P. Linh Xuân, Thành phố Thủ Đức',
          'status': 'Cô Nguyễn Thị Thúy Hạnh',
          'color': AppColors.primaryBlue,
          'tag': 'Lý thuyết',
        },
        {
          'code': 'BRM4055',
          'day': 'Thứ 6',
          'time': '13:20 - 17:25',
          'subject': 'Quản trị thương hiệu (E)',
          'room': 'Phòng A.811',
          'location': 'Cơ sở chính, KP3 P. Linh Xuân, Thành phố Thủ Đức',
          'status': 'Cô Hoàng Việt Linh',
          'color': AppColors.successGreen,
          'tag': 'Luyện tập',
        },
      ];
    }

    final filteredData = scheduleData.where((d) {
      final matchesSearch = d['subject'].toString().toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesFilter =
          selectedFilter == 'Tất cả' || d['tag'] == selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(headerText, style: AppTextStyles.sectionHeader),
            Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => isTableView = !isTableView),
                  icon: Icon(
                    isTableView ? LucideIcons.list : LucideIcons.layoutGrid,
                    size: 20,
                    color: AppColors.primaryBlue,
                  ),
                  tooltip: 'Đổi chế độ xem',
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.calendar, size: 16),
                  label: const Text('Tháng này'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('Tất cả', selectedFilter == 'Tất cả'),
              const SizedBox(width: 8),
              _buildFilterChip('Luyện tập', selectedFilter == 'Luyện tập'),
              const SizedBox(width: 8),
              _buildFilterChip('Lý thuyết', selectedFilter == 'Lý thuyết'),
              const SizedBox(width: 8),
              _buildFilterChip('Bổ sung', selectedFilter == 'Bổ sung'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            onChanged: (v) => setState(() => searchQuery = v),
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm môn học...',
              prefixIcon: Icon(LucideIcons.search, size: 18),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        isTableView
            ? _buildScheduleGridView(filteredData)
            : Column(
                children: filteredData
                    .map((data) => _buildTimelineCard(context, data))
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildScheduleGridView(List<Map<String, dynamic>> data) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              AppColors.primaryBlue.withValues(alpha: 0.05),
            ),
            columnSpacing: 24,
            columns: const [
              DataColumn(
                label: Text(
                  'Phòng',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Thứ 2',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Thứ 4',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Thứ 6',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: [
              _buildDataRow('A.811', '-', 'Giao tiếp KD', 'Quản trị TH'),
              _buildDataRow('A.813', 'Marketing KTS', '-', 'Thương mại ĐT'),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(String room, String t2, String t4, String t6) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            room,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        DataCell(_buildCellContent(t2)),
        DataCell(_buildCellContent(t4)),
        DataCell(_buildCellContent(t6)),
      ],
    );
  }

  Widget _buildCellContent(String text) {
    if (text == '-') {
      return const Text('-', style: TextStyle(color: Colors.grey));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTimelineCard(BuildContext context, Map<String, dynamic> data) {
    Color statusColor = data['color'];
    return GestureDetector(
      onTap: () => _showItemDetails(context, data, statusColor),
      child: Padding(
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
                      '${data['code'] ?? 'Mã HP'} | ${data['subject'] ?? 'Môn học'}',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          child: Text(
                            data['room'],
                            style: AppTextStyles.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Container(
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
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
      ),
    );
  }

  void _showItemDetails(
    BuildContext context,
    Map<String, dynamic> data,
    Color color,
  ) {
    bool isExam = widget.title.toLowerCase().contains('thi');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isExam ? LucideIcons.calendarClock : LucideIcons.bookOpen,
                      color: color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isExam ? 'Thông tin lịch thi' : 'Thông tin môn học',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                        Text(
                          data['subject'],
                          style: AppTextStyles.heading1.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildDetailRow(
                LucideIcons.hash,
                'Mã học phần',
                data['code'] ?? 'N/A',
              ),
              if (isExam && data.containsKey('class')) ...[
                const SizedBox(height: 20),
                _buildDetailRow(
                  LucideIcons.users,
                  'Lớp học phần',
                  data['class'],
                ),
                const SizedBox(height: 20),
                _buildDetailRow(
                  LucideIcons.graduationCap,
                  'Số tín chỉ',
                  '${data['credits']} TC',
                ),
              ],
              const SizedBox(height: 20),
              _buildDetailRow(
                LucideIcons.calendar,
                'Thời gian',
                '${data['day']}, ${data['time']}',
              ),
              const SizedBox(height: 20),
              _buildDetailRow(LucideIcons.mapPin, 'Phòng thi', data['room']),
              const SizedBox(height: 20),
              _buildDetailRow(
                LucideIcons.map,
                'Địa điểm',
                data['location'] ?? 'Cơ sở chính UEL',
              ),
              const SizedBox(height: 20),
              _buildDetailRow(
                isExam ? LucideIcons.fileText : LucideIcons.user,
                isExam ? 'Hình thức thi' : 'Giảng viên',
                data['status'],
              ),
              if (isExam && data.containsKey('score_deadline')) ...[
                const SizedBox(height: 20),
                _buildDetailRow(
                  LucideIcons.alertCircle,
                  'Hạn thu hồi túi bài & điểm',
                  data['score_deadline'],
                ),
              ],
              const SizedBox(height: 32),
              const Text(
                'Hành động nhanh',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      LucideIcons.calendarPlus,
                      'Nhắc lịch',
                      () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Đã thêm nhắc lịch cho ${data['subject']}',
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.primaryBlue,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      LucideIcons.share2,
                      'Chia sẻ',
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã sao chép liên kết chia sẻ'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Đóng',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppColors.primaryBlue),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.textLight),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(value, style: AppTextStyles.bodyLarge),
            ],
          ),
        ),
      ],
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

    final t = widget.title.toLowerCase();
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
        const SizedBox(height: 24),
        Text('Tiến Độ Học Phần', style: AppTextStyles.sectionHeader),
        const SizedBox(height: 16),
        _buildProgressCard(
          'Marketing kỹ thuật số',
          0.85,
          AppColors.primaryBlue,
        ),
        const SizedBox(height: 12),
        _buildProgressCard(
          'Quản trị thương hiệu',
          0.60,
          AppColors.successGreen,
        ),
        const SizedBox(height: 12),
        _buildProgressCard('Thương mại điện tử', 0.40, AppColors.warningYellow),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey[200]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textBody,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, double progress, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
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
    final t = widget.title.toLowerCase();

    if (t.contains('chứng chỉ')) {
      docData = [
        {
          'title': 'IELTS Academic - IDP Việt Nam',
          'desc':
              'Overall: 8.0 (L: 8.5, R: 9.0, W: 7.0, S: 7.5). Ngày thi: 12/02/2026',
          'status': 'Đã xác thực',
          'type': 'success',
        },
        {
          'title': 'MOS Excel 2019 - Microsoft',
          'desc': 'Score: 980/1000 (Excel Expert). Cấp ngày: 05/01/2026',
          'status': 'Đã xác thực',
          'type': 'success',
        },
        {
          'title': 'JLPT N3 - Japan Foundation',
          'desc': 'Pass (155/180). Ngày cấp: 20/12/2025',
          'status': 'Đã duyệt',
          'type': 'success',
        },
      ];
    } else if (t.contains('kết quả đk') || t.contains('kết quả đăng ký')) {
      docData = [
        {
          'title': 'Marketing kỹ thuật số (E) - Nhóm 01',
          'desc': 'Mã lớp: 234MKT01. Số TC: 3. Trạng thái: Đăng ký thành công',
          'status': 'Thành công',
          'type': 'success',
        },
        {
          'title': 'Thương mại điện tử (E) - Nhóm 03',
          'desc': 'Mã lớp: 234EBM03. Số TC: 3. Trạng thái: Đăng ký thành công',
          'status': 'Thành công',
          'type': 'success',
        },
      ];
    } else if (t.contains('đăng ký học phần')) {
      docData = [
        {
          'title': 'Quản trị dự án - Nhóm 02',
          'desc': 'Giảng viên: ThS. Nguyễn Văn A. Còn: 15/60 chỗ',
          'status': 'Đang mở',
          'type': 'info',
          'action': 'Đăng ký',
        },
        {
          'title': 'Lập trình ứng dụng di động - Nhóm 01',
          'desc': 'Giảng viên: TS. Trần Thị B. Còn: 5/45 chỗ',
          'status': 'Đang mở',
          'type': 'info',
          'action': 'Đăng ký',
        },
      ];
    } else if (t.contains('hoá đơn')) {
      docData = [
        {
          'title': 'Hóa đơn HP HK1 2026-2027',
          'desc': 'Số HĐ: UEL26001. Ngày lập: 15/01/2026. Số tiền: 14.500.000đ',
          'status': 'Đã phát hành',
          'type': 'success',
          'action': 'Xem HĐ',
        },
        {
          'title': 'Hóa đơn lệ phí BHYT 2026',
          'desc': 'Số HĐ: UEL26002. Ngày lập: 20/01/2026. Số tiền: 702.000đ',
          'status': 'Đã phát hành',
          'type': 'success',
          'action': 'Xem HĐ',
        },
      ];
    } else if (t.contains('phí')) {
      docData = [
        {
          'title': 'Học phí HK1 2026-2027',
          'desc': 'Hạn nộp: 30/11/2026 - Tổng: 14.500.000đ',
          'status': 'Chưa nộp',
          'type': 'alert',
        },
        {
          'title': 'Học phí HK2 2025-2026',
          'desc': 'Thanh toán qua MoMo ngày 15/05/2026',
          'status': 'Đã đóng',
          'type': 'success',
        },
      ];
    } else if (t.contains('xét tốt nghiệp')) {
      docData = [
        {
          'title': 'Chuẩn đầu ra Ngoại ngữ',
          'desc': 'Chứng chỉ: IELTS 8.0. Trạng thái: Đạt điều kiện',
          'status': 'Đạt',
          'type': 'success',
        },
        {
          'title': 'Chuẩn đầu ra Tin học',
          'desc': 'Chứng chỉ: MOS Excel Expert. Trạng thái: Đạt điều kiện',
          'status': 'Đạt',
          'type': 'success',
        },
        {
          'title': 'Tích lũy tín chỉ',
          'desc': 'Tổng số TC tích lũy: 120/120. GPA: 8.45',
          'status': 'Đạt',
          'type': 'success',
        },
        {
          'title': 'Điểm Rèn luyện toàn khóa',
          'desc': 'Điểm trung bình: 92.5. Xếp loại: Xuất sắc',
          'status': 'Đạt',
          'type': 'success',
        },
        {
          'title': 'Trạng thái xét tốt nghiệp',
          'desc': 'Hết nợ môn: Có. Đủ điều kiện: CÓ',
          'status': 'ĐỦ ĐIỀU KIỆN',
          'type': 'success',
          'action': 'In GCN tạm thời',
        },
      ];
    } else if (t.contains('quyết định') || t.contains('chương trình')) {
      docData = [
        {
          'title': 'QĐ 2024/QĐ-UEL-KT',
          'desc': 'V/v Khen thưởng Sinh viên 5 tốt cấp Trường năm 2025',
          'status': 'Hiệu lực',
          'type': 'success',
          'action': 'Xem QĐ',
        },
        {
          'title': 'QĐ 1056/QĐ-UEL-HB',
          'desc': 'V/v Cấp học bổng KKHT Học kỳ 1 năm học 2025-2026',
          'status': 'Hiệu lực',
          'type': 'success',
          'action': 'Xem QĐ',
        },
        {
          'title': 'QĐ 889/QĐ-UEL-TN',
          'desc': 'V/v Công nhận tốt nghiệp đợt 1 năm 2026',
          'status': 'Hiệu lực',
          'type': 'success',
          'action': 'Xem QĐ',
        },
      ];
    } else {
      docData = [
        {
          'title': 'Chính sách bảo mật',
          'desc': 'Cập nhật ngày 01/01/2026',
          'status': 'Đã duyệt',
          'type': 'success',
        },
        {
          'title': 'Điều khoản sử dụng',
          'desc': 'Cập nhật ngày 01/01/2026',
          'status': 'Đã duyệt',
          'type': 'success',
        },
      ];
    }

    return Column(
      children: [
        _buildTopAlert(
          'Ứng dụng đã cập nhật dữ liệu mới nhất cho học kỳ này',
          AppColors.primaryBlue,
        ),
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
      case 'info':
        statusColor = AppColors.primaryBlue;
        statusIcon = LucideIcons.info;
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
            if (data['type'] == 'alert' || data['action'] != null) ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String msg = '⚡ Đang xử lý yêu cầu...';
                    if (data['action'] == 'Đăng ký') {
                      msg =
                          '✅ Đã gửi yêu cầu đăng ký học phần ${data['title']}';
                    } else if (data['action'] == 'Xem HĐ' ||
                        data['action'] == 'Xem QĐ') {
                      msg = '📄 Đang tải tài liệu điện tử...';
                    } else if (data['action'] == 'In GCN tạm thời') {
                      msg =
                          '🖨️ Đang tạo bản sao Giấy chứng nhận tốt nghiệp...';
                    } else if (data['type'] == 'alert') {
                      msg = '⚡ Đang kết nối tới cổng thanh toán MoMo...';
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(msg),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: data['action'] == 'Đăng ký'
                            ? AppColors.successGreen
                            : AppColors.primaryBlue,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: data['action'] == 'Đăng ký'
                        ? AppColors.successGreen
                        : AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    data['action'] ?? 'Thanh toán ngay',
                    style: const TextStyle(
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
            widget.icon,
            size: 80,
            color: AppColors.iconUnselected.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text('Tính năng đang được phát triển', style: AppTextStyles.heading1),
          const SizedBox(height: 8),
          Text(
            'Phiên bản đầy đủ của ${widget.title} sẽ sớm được ra mắt trong bản cập nhật tới.',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
