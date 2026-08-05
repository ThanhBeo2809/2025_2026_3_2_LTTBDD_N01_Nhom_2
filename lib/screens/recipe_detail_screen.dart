import 'package:flutter/material.dart';

import '../controllers/recipe_controller.dart';
import '../controllers/kitchen_controller.dart';
import '../l10n/app_strings.dart';
import '../models/recipe.dart';
import '../utils/recipe_labels.dart';
import 'cooking_mode_screen.dart';
import 'recipe_form_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({required this.recipeId, super.key});

  final String recipeId;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _currentStep = 0;
  bool _trackedView = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_trackedView) return;
    _trackedView = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) RecipeScope.of(context).markViewed(widget.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final controller = RecipeScope.of(context);
    final recipe = controller.recipeById(widget.recipeId);
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(strings.noResults)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 300,
            pinned: true,
            title: Text(recipe.localizedTitle(strings.isVietnamese)),
            actions: [
              if (recipe.isUserCreated)
                IconButton(
                  tooltip: strings.editRecipe,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => RecipeFormScreen(recipeId: recipe.id),
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined),
                ),
              if (recipe.isUserCreated)
                IconButton(
                  tooltip: strings.deleteRecipe,
                  onPressed: () => _confirmDelete(context, controller, recipe),
                  icon: const Icon(Icons.delete_outline),
                ),
              IconButton.filledTonal(
                tooltip: strings.favorites,
                onPressed: () => controller.toggleFavorite(recipe.id),
                icon: Icon(
                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: recipe.isFavorite ? Colors.redAccent : null,
                ),
              ),
              const SizedBox(width: 14),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(recipe.colorValue),
                      Color(recipe.colorValue).withValues(alpha: 0.55),
                    ],
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: 'recipe-${recipe.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        recipe.emoji,
                        style: const TextStyle(fontSize: 120),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 980),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              RecipeLabels.category(strings, recipe.category),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            avatar: const Icon(
                              Icons.signal_cellular_alt,
                              size: 18,
                            ),
                            label: Text(
                              RecipeLabels.difficulty(
                                strings,
                                recipe.difficulty,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        recipe.localizedDescription(strings.isVietnamese),
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(height: 1.6),
                      ),
                      const SizedBox(height: 24),
                      _RecipeFacts(recipe: recipe, strings: strings),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _addIngredients(context, recipe),
                            icon: const Icon(Icons.add_shopping_cart),
                            label: Text(strings.addToShoppingList),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => _showMealPlanner(context, recipe),
                            icon: const Icon(Icons.calendar_month_outlined),
                            label: Text(strings.addToWeeklyPlan),
                          ),
                          FilledButton.tonalIcon(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) =>
                                    CookingModeScreen(recipeId: recipe.id),
                              ),
                            ),
                            icon: const Icon(Icons.local_fire_department),
                            label: Text(strings.startCooking),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        strings.ingredients,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recipe.ingredients.length,
                          separatorBuilder: (_, _) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final ingredient = recipe.ingredients[index];
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.check, size: 18),
                              ),
                              title: Text(
                                ingredient.localizedName(strings.isVietnamese),
                              ),
                              trailing: Text(
                                ingredient.localizedQuantity(
                                  strings.isVietnamese,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        strings.directions,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Stepper(
                        currentStep: _currentStep.clamp(
                          0,
                          recipe.steps.length - 1,
                        ),
                        onStepTapped: (value) =>
                            setState(() => _currentStep = value),
                        controlsBuilder: (_, _) => const SizedBox.shrink(),
                        steps: [
                          for (
                            var index = 0;
                            index < recipe.steps.length;
                            index++
                          )
                            Step(
                              isActive: index <= _currentStep,
                              title: Text(
                                recipe.steps[index]
                                        .localizedTitle(strings.isVietnamese)
                                        .isEmpty
                                    ? '${strings.step} ${index + 1}'
                                    : '${index + 1}. ${recipe.steps[index].localizedTitle(strings.isVietnamese)}',
                              ),
                              subtitle: recipe.steps[index].durationMinutes > 0
                                  ? Text(
                                      '${recipe.steps[index].durationMinutes} ${strings.minutes}',
                                    )
                                  : null,
                              content: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  recipe.steps[index].localizedInstruction(
                                    strings.isVietnamese,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (recipe
                          .localizedTips(strings.isVietnamese)
                          .isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Card(
                          color: Theme.of(
                            context,
                          ).colorScheme.tertiaryContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.lightbulb_outline),
                                    const SizedBox(width: 10),
                                    Text(
                                      strings.tips,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                for (final tip in recipe.localizedTips(
                                  strings.isVietnamese,
                                ))
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 7),
                                          child: Icon(Icons.circle, size: 7),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(child: Text(tip)),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    RecipeController controller,
    Recipe recipe,
  ) async {
    final strings = AppStrings.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.deleteRecipe),
        content: Text(strings.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(strings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    KitchenScope.of(context).removeRecipeReferences(recipe.id);
    controller.deleteRecipe(recipe.id);
    Navigator.of(context).pop();
  }

  void _addIngredients(BuildContext context, Recipe recipe) {
    final strings = AppStrings.of(context);
    final added = KitchenScope.of(context).addRecipeIngredients(recipe);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          added == 0
              ? strings.ingredientsAlreadyAdded
              : '${strings.addedIngredients}: $added',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _showMealPlanner(BuildContext context, Recipe recipe) async {
    final strings = AppStrings.of(context);
    final weekday = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.selectDay,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var day = DateTime.monday; day <= DateTime.sunday; day++)
                    ActionChip(
                      avatar: const Icon(Icons.event, size: 18),
                      label: Text(strings.weekday(day)),
                      onPressed: () => Navigator.pop(context, day),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (weekday == null || !context.mounted) return;
    KitchenScope.of(context).planMeal(weekday, recipe.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${strings.mealPlanned}: ${strings.weekday(weekday)}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _RecipeFacts extends StatelessWidget {
  const _RecipeFacts({required this.recipe, required this.strings});

  final Recipe recipe;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _Fact(
          icon: Icons.timer_outlined,
          label: strings.preparation,
          value: '${recipe.preparationMinutes} ${strings.minutes}',
        ),
        _Fact(
          icon: Icons.soup_kitchen_outlined,
          label: strings.cooking,
          value: '${recipe.cookingMinutes} ${strings.minutes}',
        ),
        _Fact(
          icon: Icons.people_outline,
          label: strings.servings,
          value: '${recipe.servings}',
        ),
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ],
      ),
    );
  }
}
