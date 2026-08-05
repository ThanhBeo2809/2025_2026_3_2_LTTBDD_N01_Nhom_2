import 'package:bep_nha/models/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const recipe = Recipe(
    id: 'pho',
    titleVi: 'Phở bò',
    titleEn: 'Beef pho',
    descriptionVi: 'Món ăn Việt Nam',
    descriptionEn: 'Vietnamese dish',
    category: RecipeCategory.vietnamese,
    difficulty: RecipeDifficulty.medium,
    preparationMinutes: 20,
    cookingMinutes: 60,
    servings: 4,
    emoji: '🍜',
    colorValue: 0xFFE85D3F,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Thịt bò',
        nameEn: 'Beef',
        quantity: '2 miếng',
        quantityEn: '2 pieces',
      ),
    ],
    steps: [
      RecipeStep(instructionVi: 'Nấu nước dùng', instructionEn: 'Cook broth'),
    ],
  );

  test('Tính tổng thời gian chế biến', () {
    expect(recipe.totalMinutes, 80);
  });

  test('Tìm kiếm theo tên và nguyên liệu ở hai ngôn ngữ', () {
    expect(recipe.matches('phở', true), isTrue);
    expect(recipe.matches('beef', false), isTrue);
    expect(recipe.matches('cake', false), isFalse);
  });

  test('Sao chép công thức và thay đổi trạng thái yêu thích', () {
    final favorite = recipe.copyWith(isFavorite: true);

    expect(favorite.isFavorite, isTrue);
    expect(favorite.titleVi, recipe.titleVi);
  });

  test('Hiển thị định lượng nguyên liệu theo ngôn ngữ', () {
    final ingredient = recipe.ingredients.first;

    expect(ingredient.localizedQuantity(true), '2 miếng');
    expect(ingredient.localizedQuantity(false), '2 pieces');
  });

  test('Dùng chung định lượng khi hai ngôn ngữ giống nhau', () {
    const ingredient = RecipeIngredient(
      nameVi: 'Thịt bò',
      nameEn: 'Beef',
      quantity: '300 g',
    );

    expect(ingredient.localizedQuantity(true), '300 g');
    expect(ingredient.localizedQuantity(false), '300 g');
  });
}
