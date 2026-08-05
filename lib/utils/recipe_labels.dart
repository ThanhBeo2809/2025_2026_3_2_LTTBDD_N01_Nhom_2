import '../l10n/app_strings.dart';
import '../models/recipe.dart';

abstract final class RecipeLabels {
  static String category(AppStrings strings, RecipeCategory category) {
    return switch (category) {
      RecipeCategory.vietnamese => strings.vietnamese,
      RecipeCategory.healthy => strings.healthy,
      RecipeCategory.dessert => strings.dessert,
      RecipeCategory.quick => strings.quick,
      RecipeCategory.vegetarian => strings.vegetarian,
    };
  }

  static String difficulty(AppStrings strings, RecipeDifficulty difficulty) {
    return switch (difficulty) {
      RecipeDifficulty.easy => strings.easy,
      RecipeDifficulty.medium => strings.medium,
      RecipeDifficulty.hard => strings.hard,
    };
  }
}
