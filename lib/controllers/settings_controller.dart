import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  Locale _locale = const Locale('vi');
  ThemeMode _themeMode = ThemeMode.light;

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get isVietnamese => _locale.languageCode == 'vi';
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setVietnamese(bool value) {
    final nextLocale = Locale(value ? 'vi' : 'en');
    if (_locale == nextLocale) return;
    _locale = nextLocale;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    final nextMode = value ? ThemeMode.dark : ThemeMode.light;
    if (_themeMode == nextMode) return;
    _themeMode = nextMode;
    notifyListeners();
  }
}

class SettingsScope extends InheritedNotifier<SettingsController> {
  const SettingsScope({
    required SettingsController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static SettingsController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SettingsScope>();
    assert(scope != null, 'Không tìm thấy SettingsScope trong cây widget.');
    return scope!.notifier!;
  }
}
