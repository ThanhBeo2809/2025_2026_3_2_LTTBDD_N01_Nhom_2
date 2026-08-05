import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import 'explore_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'kitchen_screen.dart';
import 'recipe_form_screen.dart';
import 'settings_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final destinations = [
      _Destination(strings.home, Icons.home_outlined, Icons.home_rounded),
      _Destination(strings.explore, Icons.explore_outlined, Icons.explore),
      _Destination(strings.favorites, Icons.favorite_border, Icons.favorite),
      _Destination(
        strings.kitchen,
        Icons.soup_kitchen_outlined,
        Icons.soup_kitchen,
      ),
      _Destination(strings.settings, Icons.settings_outlined, Icons.settings),
    ];
    final pages = [
      HomeScreen(
        onExplore: () => _selectDestination(1),
        onOpenKitchen: () => _selectDestination(3),
      ),
      const ExploreScreen(),
      const FavoritesScreen(),
      const KitchenScreen(),
      const SettingsScreen(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 900;
        final content = IndexedStack(index: _selectedIndex, children: pages);

        if (useRail) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: _openCreateRecipe,
              icon: const Icon(Icons.add),
              label: Text(strings.addRecipe),
            ),
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 1180,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _selectDestination,
                    leading: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: _BrandMark(),
                    ),
                    destinations: [
                      for (final destination in destinations)
                        NavigationRailDestination(
                          icon: Icon(destination.icon),
                          selectedIcon: Icon(destination.selectedIcon),
                          label: Text(destination.label),
                        ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: content),
              ],
            ),
          );
        }

        return Scaffold(
          body: content,
          floatingActionButton: FloatingActionButton(
            tooltip: strings.addRecipe,
            onPressed: _openCreateRecipe,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _selectDestination,
            destinations: [
              for (final destination in destinations)
                NavigationDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: destination.label,
                ),
            ],
          ),
        );
      },
    );
  }

  void _selectDestination(int value) => setState(() => _selectedIndex = value);

  void _openCreateRecipe() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const RecipeFormScreen()));
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Bếp Nhà',
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text('🍳', style: TextStyle(fontSize: 25)),
      ),
    );
  }
}

class _Destination {
  const _Destination(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
