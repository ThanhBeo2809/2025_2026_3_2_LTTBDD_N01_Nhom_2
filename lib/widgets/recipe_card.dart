import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../models/recipe.dart';
import '../utils/recipe_labels.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    required this.recipe,
    required this.onFavorite,
    this.onTap,
    super.key,
  });

  final Recipe recipe;
  final VoidCallback onFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(recipe.colorValue),
                          Color(recipe.colorValue).withValues(alpha: 0.62),
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
                            style: const TextStyle(fontSize: 70),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: IconButton.filledTonal(
                      tooltip: strings.favorites,
                      onPressed: onFavorite,
                      icon: Icon(
                        recipe.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: recipe.isFavorite ? Colors.redAccent : null,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(
                        RecipeLabels.category(strings, recipe.category),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.localizedTitle(strings.isVietnamese),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 17),
                      const SizedBox(width: 5),
                      Text('${recipe.totalMinutes} ${strings.minutes}'),
                      const Spacer(),
                      const Icon(Icons.signal_cellular_alt, size: 17),
                      const SizedBox(width: 5),
                      Text(RecipeLabels.difficulty(strings, recipe.difficulty)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
