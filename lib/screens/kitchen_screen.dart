import 'package:flutter/material.dart';

import '../controllers/kitchen_controller.dart';
import '../controllers/recipe_controller.dart';
import '../l10n/app_strings.dart';
import '../models/recipe.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(strings.kitchen),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.calendar_month),
                text: strings.weeklyPlan,
              ),
              Tab(
                icon: const Icon(Icons.shopping_basket),
                text: strings.shoppingList,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_WeeklyPlanTab(), _ShoppingListTab()],
        ),
      ),
    );
  }
}

class _WeeklyPlanTab extends StatelessWidget {
  const _WeeklyPlanTab();

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final kitchen = KitchenScope.of(context);
    final recipes = RecipeScope.of(context).recipes;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      children: [
        _SummaryCard(
          icon: Icons.event_available,
          title: strings.weeklyPlan,
          value: '${kitchen.plannedMealCount}/7',
          subtitle: strings.planSubtitle,
        ),
        const SizedBox(height: 18),
        for (
          var weekday = DateTime.monday;
          weekday <= DateTime.sunday;
          weekday++
        )
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _DayPlanner(
              weekday: weekday,
              recipes: recipes,
              selectedRecipeId: kitchen.weeklyPlan[weekday],
              onChanged: (recipeId) {
                if (recipeId == null) {
                  kitchen.removePlannedMeal(weekday);
                } else {
                  kitchen.planMeal(weekday, recipeId);
                }
              },
            ),
          ),
      ],
    );
  }
}

class _DayPlanner extends StatelessWidget {
  const _DayPlanner({
    required this.weekday,
    required this.recipes,
    required this.selectedRecipeId,
    required this.onChanged,
  });

  final int weekday;
  final List<Recipe> recipes;
  final String? selectedRecipeId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final selectedRecipe = recipes
        .where((recipe) => recipe.id == selectedRecipeId)
        .firstOrNull;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                strings.shortWeekday(weekday),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: selectedRecipe?.id,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: strings.weekday(weekday),
                  hintText: strings.chooseRecipe,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  for (final recipe in recipes)
                    DropdownMenuItem(
                      value: recipe.id,
                      child: Text(
                        '${recipe.emoji} ${recipe.localizedTitle(strings.isVietnamese)}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: onChanged,
              ),
            ),
            if (selectedRecipe != null) ...[
              const SizedBox(width: 8),
              IconButton(
                tooltip: strings.removeFromPlan,
                onPressed: () => onChanged(null),
                icon: const Icon(Icons.close),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShoppingListTab extends StatelessWidget {
  const _ShoppingListTab();

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final kitchen = KitchenScope.of(context);
    final recipeController = RecipeScope.of(context);
    final items = kitchen.shoppingItems;

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_basket_outlined,
                size: 70,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 18),
              Text(
                strings.emptyShoppingList,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(strings.shoppingHint, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    final progress = kitchen.purchasedCount / items.length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      children: [
        _SummaryCard(
          icon: Icons.shopping_cart_checkout,
          title: strings.shoppingList,
          value: '${kitchen.purchasedCount}/${items.length}',
          subtitle: strings.purchasedProgress,
          progress: progress,
          action: kitchen.purchasedCount == 0
              ? null
              : TextButton.icon(
                  onPressed: kitchen.clearPurchased,
                  icon: const Icon(Icons.cleaning_services_outlined),
                  label: Text(strings.clearPurchased),
                ),
        ),
        const SizedBox(height: 18),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var index = 0; index < items.length; index++) ...[
                if (index > 0) const Divider(height: 1),
                Dismissible(
                  key: ValueKey(items[index].id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Theme.of(context).colorScheme.errorContainer,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                  onDismissed: (_) =>
                      kitchen.removeShoppingItem(items[index].id),
                  child: CheckboxListTile(
                    value: items[index].isPurchased,
                    onChanged: (_) => kitchen.togglePurchased(items[index].id),
                    secondary: const CircleAvatar(
                      child: Icon(Icons.restaurant_menu, size: 19),
                    ),
                    title: Text(
                      items[index].localizedName(strings.isVietnamese),
                      style: TextStyle(
                        decoration: items[index].isPurchased
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${items[index].localizedQuantity(strings.isVietnamese)} • '
                      '${recipeController.recipeById(items[index].sourceRecipeId)?.localizedTitle(strings.isVietnamese) ?? strings.customRecipe}',
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    checkboxSemanticLabel: strings.markPurchased,
                    selected: items[index].isPurchased,
                    selectedTileColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    this.progress,
    this.action,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final double? progress;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Icon(icon)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(subtitle),
                    ],
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            if (progress != null) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(value: progress),
            ],
            if (action != null) ...[
              const SizedBox(height: 8),
              Align(alignment: Alignment.centerRight, child: action),
            ],
          ],
        ),
      ),
    );
  }
}
