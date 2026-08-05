import 'package:flutter/material.dart';

import '../controllers/recipe_controller.dart';
import '../l10n/app_strings.dart';
import '../models/recipe.dart';
import '../utils/recipe_labels.dart';
import '../widgets/category_chip.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final controller = RecipeScope.of(context);
    final recipes = controller.filteredRecipes(strings.isVietnamese);

    if (_searchController.text != controller.query) {
      _searchController.value = TextEditingValue(
        text: controller.query,
        selection: TextSelection.collapsed(offset: controller.query.length),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.explore),
        actions: [
          IconButton(
            tooltip: strings.advancedFilters,
            onPressed: () => _showAdvancedFilters(context, controller),
            icon: Badge(
              isLabelVisible: controller.activeFilterCount > 0,
              label: Text('${controller.activeFilterCount}'),
              child: const Icon(Icons.tune),
            ),
          ),
          if (controller.hasActiveFilters)
            TextButton.icon(
              onPressed: controller.clearFilters,
              icon: const Icon(Icons.filter_alt_off_outlined),
              label: Text(strings.clearFilters),
            ),
          const SizedBox(width: 12),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 14),
                child: SearchBar(
                  controller: _searchController,
                  hintText: strings.searchHint,
                  leading: const Icon(Icons.search),
                  trailing: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        tooltip: strings.clearFilters,
                        onPressed: () {
                          _searchController.clear();
                          controller.setQuery('');
                        },
                        icon: const Icon(Icons.close),
                      ),
                  ],
                  onChanged: controller.setQuery,
                ),
              ),
              SizedBox(
                height: 56,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final category in RecipeCategory.values) ...[
                      RecipeCategoryChip(
                        label: RecipeLabels.category(strings, category),
                        icon: _categoryIcon(category),
                        selected: controller.selectedCategory == category,
                        onSelected: (selected) =>
                            controller.setCategory(selected ? category : null),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${recipes.length} ${strings.recipes}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: recipes.isEmpty
                    ? _EmptyResults(strings: strings)
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
                        itemCount: recipes.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 330,
                              mainAxisExtent: 310,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                            ),
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onFavorite: () =>
                                controller.toggleFavorite(recipe.id),
                            onTap: () => _openRecipe(context, recipe.id),
                          );
                        },
                      ),
              ),
            ],
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

  Future<void> _showAdvancedFilters(
    BuildContext context,
    RecipeController controller,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final strings = AppStrings.of(context);
          void update(VoidCallback change) {
            change();
            setSheetState(() {});
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.advancedFilters,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    strings.difficulty,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(strings.allLevels),
                        selected: controller.selectedDifficulty == null,
                        onSelected: (_) =>
                            update(() => controller.setDifficulty(null)),
                      ),
                      for (final difficulty in RecipeDifficulty.values)
                        ChoiceChip(
                          label: Text(
                            RecipeLabels.difficulty(strings, difficulty),
                          ),
                          selected: controller.selectedDifficulty == difficulty,
                          onSelected: (_) => update(
                            () => controller.setDifficulty(difficulty),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    strings.maximumTime,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(strings.anyDuration),
                        selected: controller.maxMinutes == null,
                        onSelected: (_) =>
                            update(() => controller.setMaxMinutes(null)),
                      ),
                      for (final minutes in const [30, 60, 90, 120])
                        ChoiceChip(
                          label: Text('≤ $minutes ${strings.minutes}'),
                          selected: controller.maxMinutes == minutes,
                          onSelected: (_) =>
                              update(() => controller.setMaxMinutes(minutes)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    strings.sortBy,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(strings.defaultSort),
                        selected: controller.sort == RecipeSort.none,
                        onSelected: (_) =>
                            update(() => controller.setSort(RecipeSort.none)),
                      ),
                      ChoiceChip(
                        avatar: const Icon(Icons.bolt, size: 18),
                        label: Text(strings.fastest),
                        selected: controller.sort == RecipeSort.fastest,
                        onSelected: (_) => update(
                          () => controller.setSort(RecipeSort.fastest),
                        ),
                      ),
                      ChoiceChip(
                        avatar: const Icon(Icons.sort_by_alpha, size: 18),
                        label: Text(strings.alphabetical),
                        selected: controller.sort == RecipeSort.name,
                        onSelected: (_) =>
                            update(() => controller.setSort(RecipeSort.name)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => update(controller.clearFilters),
                        icon: const Icon(Icons.filter_alt_off),
                        label: Text(strings.clearFilters),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(strings.apply),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 72,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            strings.noResults,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
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
