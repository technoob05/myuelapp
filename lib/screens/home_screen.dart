import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../widgets/feature_icon_button.dart';
import '../widgets/section_header.dart';
import 'black_box_screen.dart';
import 'generic_feature_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToGeneric(BuildContext context, String title, IconData icon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenericFeatureScreen(title: title, icon: icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMainContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _fadeController,
                curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My UEL',
                style: AppTextStyles.headerTitle.copyWith(
                  fontSize: 32,
                  shadows: [
                    Shadow(
                      color: Colors.white.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/uel_logo.png',
                  width: 44,
                  height: 44,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserProfile(),
              const SizedBox(height: 24),
              _buildFeaturesSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _fadeController,
                curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, const Color(0xFFF1F5F9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Xin chào,',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textBody,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Nguyễn Hoàng Tấn Lực',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'K234101293',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryBlue, Color(0xFF60A5FA)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Icon(
                        LucideIcons.user,
                        color: AppColors.primaryBlue,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedSection(
            0.4,
            0.8,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.05),
              child: Column(
                children: [
                  const SectionHeader(title: 'Học tập'),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      left: 8,
                      right: 8,
                    ),
                    children: [
                      FeatureIconButton(
                        icon: LucideIcons.calendarDays,
                        label: 'Lịch học',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Lịch học',
                          LucideIcons.calendarDays,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.calendarCheck,
                        label: 'Lịch thi',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Lịch thi',
                          LucideIcons.calendarCheck,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.bookOpen,
                        label: 'Chương trình\nđào tạo',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Chương trình đào tạo',
                          LucideIcons.bookOpen,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.checkSquare,
                        label: 'Chuyên cần',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Chuyên cần',
                          LucideIcons.checkSquare,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.fileText,
                        label: 'Kết quả rèn\nluyện',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Kết quả rèn luyện',
                          LucideIcons.fileText,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.barChart2,
                        label: 'Kết quả\nhọc tập',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Kết quả học tập',
                          LucideIcons.barChart2,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.stamp,
                        label: 'Quyết định\nsinh viên',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Quyết định sinh viên',
                          LucideIcons.stamp,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.edit3,
                        label: 'Kết quả ĐK\nhọc phần',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Kết quả ĐK học phần',
                          LucideIcons.edit3,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.fileBadge2,
                        label: 'Chính sách\nhọc phí',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Chính sách học phí',
                          LucideIcons.fileBadge2,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.award,
                        label: 'Chứng chỉ',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Chứng chỉ',
                          LucideIcons.award,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.penTool,
                        label: 'Đăng ký\nhọc phần',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Đăng ký học phần',
                          LucideIcons.penTool,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.graduationCap,
                        label: 'Xem KQ xét\ntốt nghiệp',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Xem KQ xét tốt nghiệp',
                          LucideIcons.graduationCap,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildAnimatedSection(
            0.5,
            0.9,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.05),
              child: Column(
                children: [
                  const SectionHeader(title: 'Tài chính'),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      left: 8,
                      right: 8,
                    ),
                    children: [
                      FeatureIconButton(
                        icon: LucideIcons.badgeDollarSign,
                        label: 'Học phí\nsinh viên',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Học phí sinh viên',
                          LucideIcons.badgeDollarSign,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.receipt,
                        label: 'Hoá đơn',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Hoá đơn',
                          LucideIcons.receipt,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildAnimatedSection(
            0.6,
            1.0,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.05),
              child: Column(
                children: [
                  const SectionHeader(title: 'Mục Thú Vị'),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      left: 8,
                      right: 8,
                    ),
                    children: [
                      FeatureIconButton(
                        icon: LucideIcons.heartHandshake,
                        label: 'Black Box',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BlackBoxScreen(),
                          ),
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.shoppingBag,
                        label: 'Y-Shop',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Y-Shop',
                          LucideIcons.shoppingBag,
                        ),
                      ),
                      FeatureIconButton(
                        icon: LucideIcons.lineChart,
                        label: 'Data & Analytics',
                        onTap: () => _navigateToGeneric(
                          context,
                          'Data & Analytics',
                          LucideIcons.lineChart,
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

  Widget _buildAnimatedSection(
    double start,
    double end, {
    required Widget child,
  }) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: _fadeController,
                curve: Interval(start, end, curve: Curves.easeOutBack),
              ),
            ),
        child: child,
      ),
    );
  }
}
