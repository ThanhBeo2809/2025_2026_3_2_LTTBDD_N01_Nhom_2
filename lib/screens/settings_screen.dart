import 'package:flutter/material.dart';

import '../controllers/settings_controller.dart';
import '../l10n/app_strings.dart';
import 'team_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final settings = SettingsScope.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings)),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileHeader(strings: strings),
                const SizedBox(height: 24),
                _SettingsSection(
                  title: strings.language,
                  icon: Icons.translate,
                  child: SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(
                        value: true,
                        icon: const Text('🇻🇳'),
                        label: Text(strings.vietnameseLanguage),
                      ),
                      ButtonSegment(
                        value: false,
                        icon: const Text('🇬🇧'),
                        label: Text(strings.englishLanguage),
                      ),
                    ],
                    selected: {settings.isVietnamese},
                    onSelectionChanged: (value) =>
                        settings.setVietnamese(value.first),
                  ),
                ),
                const SizedBox(height: 18),
                _SettingsSection(
                  title: strings.appearance,
                  icon: Icons.palette_outlined,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: settings.isDarkMode,
                    onChanged: settings.setDarkMode,
                    title: Text(strings.darkMode),
                    subtitle: Text(
                      strings.text(
                        'Giảm độ sáng khi sử dụng vào buổi tối',
                        'Reduce brightness when cooking at night',
                      ),
                    ),
                    secondary: Icon(
                      settings.isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(18),
                    leading: const CircleAvatar(
                      child: Icon(Icons.info_outline),
                    ),
                    title: Text(strings.aboutApp),
                    subtitle: Text(
                      strings.text(
                        'Ứng dụng học tập Flutter • Phiên bản 1.0.0',
                        'Flutter learning project • Version 1.0.0',
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const TeamScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.tertiaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 34,
            child: Text('👨‍🍳', style: TextStyle(fontSize: 34)),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.appName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  strings.text(
                    'Chia sẻ hương vị, kết nối căn bếp',
                    'Share flavors, connect kitchens',
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

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}
