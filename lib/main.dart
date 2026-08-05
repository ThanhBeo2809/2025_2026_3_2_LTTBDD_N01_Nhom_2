import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/app_theme.dart';
import 'controllers/kitchen_controller.dart';
import 'controllers/recipe_controller.dart';
import 'controllers/settings_controller.dart';
import 'screens/app_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SettingsController _settings = SettingsController();
  final RecipeController _recipes = RecipeController();
  final KitchenController _kitchen = KitchenController();

  @override
  void dispose() {
    _settings.dispose();
    _recipes.dispose();
    _kitchen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settings,
      builder: (context, _) => KitchenScope(
        controller: _kitchen,
        child: RecipeScope(
          controller: _recipes,
          child: SettingsScope(
            controller: _settings,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Bếp Nhà',
              locale: _settings.locale,
              supportedLocales: const [Locale('vi'), Locale('en')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: _settings.themeMode,
              home: const AppShell(),
            ),
          ),
        ),
      ),
    );
  }
}
