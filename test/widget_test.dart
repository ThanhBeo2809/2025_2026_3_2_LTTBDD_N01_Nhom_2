import 'package:bep_nha/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Hiển thị thanh điều hướng chính', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Trang chủ'), findsWidgets);
    expect(find.text('Khám phá'), findsWidgets);
    expect(find.text('Yêu thích'), findsWidgets);
    expect(find.text('Gian bếp'), findsWidgets);
    expect(find.text('Cài đặt'), findsWidgets);
  });
}
