import 'dart:math';

import 'package:flutter/material.dart';

import '../controllers/recipe_controller.dart';
import '../controllers/kitchen_controller.dart';
import '../l10n/app_strings.dart';
import '../models/recipe.dart';
import '../utils/recipe_labels.dart';
import '../widgets/category_chip.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.onExplore,
    required this.onOpenKitchen,
    super.key,
  });

  final VoidCallback onExplore;
  final VoidCallback onOpenKitchen;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final recipes = RecipeScope.of(context);
    final kitchen = KitchenScope.of(context);
    final featured = recipes.recipes.take(4).toList(growable: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(strings: strings),
                  const SizedBox(height: 28),
                  _HeroBanner(
                    strings: strings,
                    onExplore: onExplore,
                    onSurprise: () =>
                        _showSuggestion(context, recipes.recipes, strings),
                  ),
                  const SizedBox(height: 30),
                  _KitchenOverview(
                    strings: strings,
                    plannedCount: kitchen.plannedMealCount,
                    shoppingCount: kitchen.shoppingItems.length,
                    cookedCount: recipes.cookedRecipes.length,
                    onTap: onOpenKitchen,
                  ),
                  const SizedBox(height: 30),
                  _SectionTitle(title: strings.categories),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final category in RecipeCategory.values)
                        RecipeCategoryChip(
                          label: RecipeLabels.category(strings, category),
                          icon: _categoryIcon(category),
                          selected: false,
                          onSelected: (_) {
                            recipes.setCategory(category);
                            onExplore();
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  if (recipes.recentlyViewed.isNotEmpty) ...[
                    _SectionTitle(title: strings.recentlyViewed),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 310,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: recipes.recentlyViewed.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final recipe = recipes.recentlyViewed[index];
                          return SizedBox(
                            width: 280,
                            child: RecipeCard(
                              recipe: recipe,
                              onFavorite: () =>
                                  recipes.toggleFavorite(recipe.id),
                              onTap: () => _openRecipe(context, recipe.id),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                  _SectionTitle(
                    title: strings.popularRecipes,
                    actionLabel: strings.allRecipes,
                    onAction: onExplore,
                  ),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: featured.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 330,
                          mainAxisExtent: 310,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                        ),
                    itemBuilder: (context, index) {
                      final recipe = featured[index];
                      return RecipeCard(
                        recipe: recipe,
                        onFavorite: () => recipes.toggleFavorite(recipe.id),
                        onTap: () => _openRecipe(context, recipe.id),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openRecipe(BuildContext context, String recipeId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RecipeDetailScreen(recipeId: recipeId),
      ),
    );
  }

  Future<void> _showSuggestion(
    BuildContext context,
    List<Recipe> recipes,
    AppStrings strings,
  ) async {
    if (recipes.isEmpty) return;
    final recipe = recipes[Random().nextInt(recipes.length)];
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Text(recipe.emoji, style: const TextStyle(fontSize: 58)),
        title: Text(strings.suggestedForYou),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              recipe.localizedTitle(strings.isVietnamese),
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              '${recipe.totalMinutes} ${strings.minutes} • '
              '${RecipeLabels.difficulty(strings, recipe.difficulty)}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(strings.cancel),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(dialogContext);
              _openRecipe(context, recipe.id);
            },
            icon: const Icon(Icons.restaurant_menu),
            label: Text(strings.viewRecipe),
          ),
        ],
      ),
    );
  }
}

class _KitchenOverview extends StatelessWidget {
  const _KitchenOverview({
    required this.strings,
    required this.plannedCount,
    required this.shoppingCount,
    required this.cookedCount,
    required this.onTap,
  });

  final AppStrings strings;
  final int plannedCount;
  final int shoppingCount;
  final int cookedCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                child: Icon(Icons.auto_awesome, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.kitchenAssistant,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      strings.kitchenSummary(
                        plannedCount,
                        shoppingCount,
                        cookedCount,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Text('🍳', style: TextStyle(fontSize: 28)),
        ),
        const SizedBox(width: 14),
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
              Text(strings.greeting),
            ],
          ),
        ),
        const CircleAvatar(child: Icon(Icons.person_outline)),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.strings,
    required this.onExplore,
    required this.onSurprise,
  });

  final AppStrings strings;
  final VoidCallback onExplore;
  final VoidCallback onSurprise;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.tertiary],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.discoverSubtitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: onExplore,
                      icon: const Icon(Icons.explore_outlined),
                      label: Text(strings.explore),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: onSurprise,
                      icon: const Icon(Icons.casino_outlined),
                      label: Text(strings.surpriseMe),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const Text('🥘', style: TextStyle(fontSize: 92)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({this.title, this.actionLabel, this.onAction});

  final String? title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? '',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        if (actionLabel != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}

IconData _categoryIcon(RecipeCategory category) {
  return switch (category) {
    RecipeCategory.vietnamese => Icons.ramen_dining,
    RecipeCategory.healthy => Icons.eco_outlined,
    RecipeCategory.dessert => Icons.cake_outlined,
    RecipeCategory.quick => Icons.bolt_outlined,
    RecipeCategory.vegetarian => Icons.spa_outlined,
  };
}
