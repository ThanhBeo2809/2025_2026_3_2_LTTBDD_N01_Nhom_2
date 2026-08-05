# Bếp Nhà

Ứng dụng Flutter hỗ trợ khám phá, chia sẻ và quản lý công thức nấu ăn.

## Thông tin đề tài

- Tên đề tài: Xây dựng ứng dụng di động chia sẻ công thức nấu ăn
- Tên ứng dụng: Bếp Nhà
- Lớp học phần: N01
- Nhóm: 2
- Giảng viên hướng dẫn: Nguyễn Xuân Quế

## Thành viên nhóm

| STT | Họ và tên | Mã sinh viên | Vai trò |
|---:|---|---|---|
| 1 | Phạm Trung Thành | 24100326 | Trưởng nhóm |
| 2 | Nguyễn Việt Cường | 24100397 | Thành viên |
| 3 | Đỗ Duyên Cường | 24100332 | Thành viên |

## Chức năng

- Trang chủ responsive với công thức nổi bật và danh mục món ăn
- Tìm kiếm theo tên món hoặc nguyên liệu
- Lọc theo danh mục món ăn
- Xem nguyên liệu, thời gian, khẩu phần và từng bước chế biến
- Thêm hoặc bỏ công thức yêu thích
- Tạo, chỉnh sửa và xóa công thức cá nhân
- Lên thực đơn món ăn cho từng ngày trong tuần
- Thêm nguyên liệu từ công thức vào danh sách đi chợ
- Theo dõi và xóa nhanh các nguyên liệu đã mua
- Chế độ nấu từng bước với đồng hồ đếm ngược
- Gợi ý ngẫu nhiên món ăn cho hôm nay
- Lọc theo độ khó, thời gian và sắp xếp công thức
- Ghi nhớ tạm lịch sử món vừa xem và đã nấu
- Chuyển đổi tiếng Việt và tiếng Anh
- Chuyển đổi giao diện sáng và tối
- Hiển thị thông tin đề tài và thành viên nhóm

## Công nghệ sử dụng

- Flutter và Dart
- Material Design 3
- ChangeNotifier và InheritedNotifier
- Flutter Localization
- Dữ liệu mẫu lưu tạm trong bộ nhớ
- Git và GitHub

## Nền tảng

Ứng dụng được phát triển, kiểm thử và đóng gói trên Windows Desktop.

## Cách chạy dự án

1. Cài đặt Flutter SDK và Visual Studio với `Desktop development with C++`.
2. Tải mã nguồn và mở terminal tại thư mục dự án.
3. Cài đặt dependency:

    ```powershell
    flutter pub get
    ```

4. Chạy ứng dụng:

    ```powershell
    flutter run -d windows
    ```

## Kiểm tra chất lượng

```powershell
flutter analyze
flutter test
flutter build windows
```

> Dữ liệu được lưu trong bộ nhớ để phục vụ kiểm thử và sẽ trở về trạng thái ban đầu khi khởi động lại ứng dụng.
