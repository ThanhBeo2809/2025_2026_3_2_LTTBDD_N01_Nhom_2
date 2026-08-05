import 'package:bep_nha/controllers/kitchen_controller.dart';
import 'package:bep_nha/models/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const recipe = Recipe(
    id: 'pho',
    titleVi: 'Phở',
    titleEn: 'Pho',
    descriptionVi: 'Mô tả',
    descriptionEn: 'Description',
    category: RecipeCategory.vietnamese,
    difficulty: RecipeDifficulty.medium,
    preparationMinutes: 10,
    cookingMinutes: 20,
    servings: 2,
    emoji: '🍜',
    colorValue: 0xFFFFFFFF,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Bánh phở',
        nameEn: 'Rice noodles',
        quantity: '200 g',
      ),
      RecipeIngredient(nameVi: 'Thịt bò', nameEn: 'Beef', quantity: '150 g'),
    ],
    steps: [],
  );

  test('Thêm nguyên liệu và cập nhật tiến độ mua sắm', () {
    final controller = KitchenController();

    expect(controller.addRecipeIngredients(recipe), 2);
    expect(controller.addRecipeIngredients(recipe), 0);
    expect(controller.shoppingItems, hasLength(2));

    controller.togglePurchased('pho-0');
    expect(controller.purchasedCount, 1);

    controller.clearPurchased();
    expect(controller.shoppingItems, hasLength(1));
  });

  test('Lên và thay đổi thực đơn theo ngày', () {
    final controller = KitchenController();

    controller.planMeal(DateTime.monday, recipe.id);
    expect(controller.weeklyPlan[DateTime.monday], recipe.id);
    expect(controller.plannedMealCount, 1);

    controller.removePlannedMeal(DateTime.monday);
    expect(controller.weeklyPlan, isEmpty);
  });

  test('Dọn dữ liệu liên quan khi xóa công thức cá nhân', () {
    final controller = KitchenController();
    controller.addRecipeIngredients(recipe);
    controller.planMeal(DateTime.friday, recipe.id);

    controller.removeRecipeReferences(recipe.id);

    expect(controller.shoppingItems, isEmpty);
    expect(controller.weeklyPlan, isEmpty);
  });
}
