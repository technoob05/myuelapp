import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

import 'package:lucide_icons/lucide_icons.dart';

class Confession {
  final String content;
  final String time;
  final int likes;
  final int comments;

  Confession({
    required this.content,
    required this.time,
    required this.likes,
    required this.comments,
  });
}

class BlackBoxScreen extends StatefulWidget {
  const BlackBoxScreen({super.key});

  @override
  State<BlackBoxScreen> createState() => _BlackBoxScreenState();
}

class _BlackBoxScreenState extends State<BlackBoxScreen> {
  final List<Confession> _confessions = [
    Confession(
      content:
          'Chạy deadline đồ án chuyên ngành mệt quá mọi người ơi, 3 đêm rồi em ngủ chưa tới 10 tiếng, có ai chung cảnh ngộ không 😭',
      time: '1 giờ trước',
      likes: 124,
      comments: 35,
    ),
    Confession(
      content:
          'Xin review nhẹ nhàng giảng viên hướng dẫn Khóa luận tốt nghiệp khoa Hệ thống thông tin ạ. Em đang định đăng ký thầy C.',
      time: '3 giờ trước',
      likes: 42,
      comments: 18,
    ),
    Confession(
      content:
          'Năm nhất vào UEL thấy gì cũng bỡ ngỡ, các bạn năng động quá làm mình thấy hơi bị áp lực đồng trang lứa (peer pressure)... Làm sao để hòa nhập tốt hơn vậy ạ?',
      time: 'Hôm qua',
      likes: 215,
      comments: 64,
    ),
    Confession(
      content:
          'Cứu em với, mai thi Kinh tế vĩ mô rồi mà giờ trong đầu chữ cứ trôi đi đâu mất, không nhớ được hàm tiêu dùng với cả IS-LM. Xin vía qua môn 🥺',
      time: '2 ngày trước',
      likes: 389,
      comments: 85,
    ),
    Confession(
      content:
          'Cho mình hỏi nếu điểm trung bình tích lũy hiện tại là 7.9 thì có cửa nào kéo lên 8.0 để lấy bằng Giỏi trong 2 học kỳ cuối không ạ? Mình học khoa Kinh tế.',
      time: 'Tuần trước',
      likes: 56,
      comments: 21,
    ),
  ];

  void _showAddConfessionModal() {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
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
              Text(
                'Tạo tâm sự ẩn danh',
                style: AppTextStyles.heading1.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Nhập tâm sự của bạn (Hoàn toàn ẩn danh)...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0F172A),
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
                    if (controller.text.isNotEmpty) {
                      setState(() {
                        _confessions.insert(
                          0,
                          Confession(
                            content: controller.text,
                            time: 'Vừa xong',
                            likes: 0,
                            comments: 0,
                          ),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Đăng Tâm Sự',
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

  void _connectExpert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang kết nối với chuyên gia tâm lý...'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Black Box',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0B0E14),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.phoneCall, color: Colors.white),
            onPressed: _connectExpert,
            tooltip: 'Gọi chuyên gia',
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF0B0E14),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          LucideIcons.phone,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Kết nối chuyên gia',
                          style: AppTextStyles.heading1.copyWith(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chia sẻ an toàn và bảo mật 100%. Không ai biết bạn là ai.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _connectExpert,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1D4ED8),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Kết nối ẩn danh ngay',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                itemCount: _confessions.length,
                itemBuilder: (context, index) {
                  return _buildConfessionCard(_confessions[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddConfessionModal,
        backgroundColor: Colors.white,
        child: const Icon(LucideIcons.penTool, color: Color(0xFF0B0E14)),
      ),
    );
  }

  Widget _buildConfessionCard(Confession confession) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  LucideIcons.venetianMask,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ẩn danh',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    confession.time,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            confession.content,
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildInteractionButton(
                LucideIcons.heart,
                confession.likes.toString(),
                Colors.pinkAccent,
              ),
              const SizedBox(width: 24),
              _buildInteractionButton(
                LucideIcons.messageCircle,
                confession.comments.toString(),
                Colors.blueAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton(IconData icon, String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            count,
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
