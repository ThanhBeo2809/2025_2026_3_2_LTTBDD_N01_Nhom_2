import 'package:bep_nha/controllers/recipe_controller.dart';
import 'package:bep_nha/models/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const sample = Recipe(
    id: 'sample',
    titleVi: 'Món mẫu',
    titleEn: 'Sample dish',
    descriptionVi: 'Mô tả',
    descriptionEn: 'Description',
    category: RecipeCategory.quick,
    difficulty: RecipeDifficulty.easy,
    preparationMinutes: 5,
    cookingMinutes: 10,
    servings: 2,
    emoji: '🍳',
    colorValue: 0xFFFFFFFF,
    ingredients: [],
    steps: [],
  );

  test('Tìm kiếm và lọc công thức', () {
    final controller = RecipeController(initialRecipes: [sample]);

    controller.setQuery('mẫu');
    expect(controller.filteredRecipes(true), hasLength(1));
    controller.setCategory(RecipeCategory.dessert);
    expect(controller.filteredRecipes(true), isEmpty);
  });

  test('Thêm yêu thích và xóa công thức', () {
    final controller = RecipeController(initialRecipes: [sample]);

    controller.toggleFavorite('sample');
    expect(controller.favorites, hasLength(1));
    controller.deleteRecipe('sample');
    expect(controller.recipes, isEmpty);
  });

  test('Lọc nâng cao và sắp xếp theo thời gian', () {
    final slow = sample.copyWith(
      id: 'slow',
      preparationMinutes: 30,
      cookingMinutes: 60,
      difficulty: RecipeDifficulty.hard,
    );
    final controller = RecipeController(initialRecipes: [slow, sample]);

    controller.setDifficulty(RecipeDifficulty.easy);
    controller.setMaxMinutes(30);
    controller.setSort(RecipeSort.fastest);

    expect(controller.filteredRecipes(true), [sample]);
    expect(controller.activeFilterCount, 3);
  });

  test('Theo dõi lịch sử xem và món đã nấu trong bộ nhớ', () {
    final controller = RecipeController(initialRecipes: [sample]);

    controller.markViewed(sample.id);
    controller.markViewed(sample.id);
    controller.markCooked(sample.id);

    expect(controller.recentlyViewed, [sample]);
    expect(controller.cookedRecipes, [sample]);
    expect(controller.isCooked(sample.id), isTrue);
  });
}
