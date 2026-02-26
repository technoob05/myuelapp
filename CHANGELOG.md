# MyUEL - App Documentation & Changelog

## Phân Tích Giao Diện & Trải Nghiệm Người Dùng (UX/UI Analysis)
Là một hệ thống hướng đến môi trường Học thuật, MyUEL được thiết kế linh hoạt, ưu tiên các nghiệp vụ và thông báo trực tiếp. App giải quyết ba vấn đề lớn: Thông báo rác (spammed notifications), tra cứu lịch trình rời rạc, và theo dõi tiến độ một cách tĩnh lặp.

### Cập Nhật Giao Diện & Tính Năng Mới Nhất (Version 1.0.1 - Release Notes)
Chúng tôi đã đẩy hàng loạt cải tiến quan trọng dựa trên Use cases thực tế từ Sinh viên UEL.

#### 1. Module Lịch Học & Lịch Thi (Calendar & Tracker)
- **Thiết kế lại luồng Deadline:** Đã cập nhật chính xác dữ liệu lịch thi HK02/2025-2026.
  - *Quản trị thương hiệu (E)* - 28/03/2026, 12g30, A.604, Tự luận.
  - *Thương mại điện tử (E)* - 29/03/2026, 10g00, Online 19, Tiểu luận/Đồ án.
  - *Giao tiếp kinh doanh (E)* - 02/04/2026, 12g30, A.310 bis, Laptop cá nhân.
- Suy giảm overlap UI: **Tối ưu hóa Floating Action Button (Dấu + Add Deadline)** tại góc phải màn hình bên dưới. Thiết kế theo dạng "Bubble Icon" (CircleBorder Radius 28px) cách điệu tương tự nút Support Messengers trên các dạng hệ thống web, không bị chồng lấp bởi thanh Bottom Navigation hay gây lỗi Touch Event với các item của List.

#### 2. Phân Hệ Group Chats & Threads
- Tạo nhóm trò chuyện dựa theo mã lớp và tên người hướng dẫn (Ví dụ: `PhD Nguyễn Thị Nhật Minh - Khoa QTKD`, `K234102E`, `[UEL] QTTH...`), mang đến các threads sát thực tế nhất, thay thế mock cũ.

#### 3. Phân Hệ Thông Báo Tổ Chức (Categorized Notifications)
- Cơ chế Categorization cho hệ thống Notifications: 
  - **Giảng viên/Phòng ban** (Mô phỏng Email thu nhỏ).
  - **Phòng/Giờ học** (Thông báo biến động phòng và thời gian).
  - **Nhóm chat** (Lọc riêng thông báo cuộc hội thoại).

#### 4. Data & Analytics Module (Thống Kê Sinh Viên)
- Gỡ bỏ Layout "Đang phát triển" và tích hợp thành công biểu đồ Tracking học tập 7 ngày (T2 - CN). Điểm chạm UI đã được hoàn thiện trực quan và đồng bộ mock data cho tỷ lệ duy trì cao trào vào Thứ 5.

### Tech Stack & Code Quality
- **State Management:** Provider pattern for robust separation of UI and business logic.
- **Code standards:** Clean architecture with dedicated model, screen, theme, and provider layers (`feat`, `lib`, codebase completely formatted via `dart format`).
- Component Overlaps & Edge Cases resolved gracefully.

**Tác giả:** Hệ thống phát triển MyUEL
**Phiên bản nội bộ:** v1.0.0-rc2
