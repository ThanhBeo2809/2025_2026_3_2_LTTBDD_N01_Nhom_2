import 'package:flutter/material.dart';

import '../models/kitchen_item.dart';
import '../models/recipe.dart';

class KitchenController extends ChangeNotifier {
  final List<ShoppingItem> _shoppingItems = [];
  final Map<int, String> _weeklyPlan = {};

  List<ShoppingItem> get shoppingItems => List.unmodifiable(_shoppingItems);
  Map<int, String> get weeklyPlan => Map.unmodifiable(_weeklyPlan);
  int get purchasedCount =>
      _shoppingItems.where((item) => item.isPurchased).length;
  int get plannedMealCount => _weeklyPlan.length;

  int addRecipeIngredients(Recipe recipe) {
    var addedCount = 0;
    for (var index = 0; index < recipe.ingredients.length; index++) {
      final ingredient = recipe.ingredients[index];
      final id = '${recipe.id}-$index';
      if (_shoppingItems.any((item) => item.id == id)) continue;
      _shoppingItems.add(
        ShoppingItem(
          id: id,
          nameVi: ingredient.nameVi,
          nameEn: ingredient.nameEn,
          quantityVi: ingredient.quantity,
          quantityEn: ingredient.quantityEn ?? ingredient.quantity,
          sourceRecipeId: recipe.id,
        ),
      );
      addedCount++;
    }
    if (addedCount > 0) notifyListeners();
    return addedCount;
  }

  void togglePurchased(String id) {
    final index = _shoppingItems.indexWhere((item) => item.id == id);
    if (index == -1) return;
    _shoppingItems[index] = _shoppingItems[index].copyWith(
      isPurchased: !_shoppingItems[index].isPurchased,
    );
    notifyListeners();
  }

  void removeShoppingItem(String id) {
    final previousLength = _shoppingItems.length;
    _shoppingItems.removeWhere((item) => item.id == id);
    if (_shoppingItems.length != previousLength) notifyListeners();
  }

  void clearPurchased() {
    final previousLength = _shoppingItems.length;
    _shoppingItems.removeWhere((item) => item.isPurchased);
    if (_shoppingItems.length != previousLength) notifyListeners();
  }

  void planMeal(int weekday, String recipeId) {
    if (weekday < DateTime.monday || weekday > DateTime.sunday) return;
    if (_weeklyPlan[weekday] == recipeId) return;
    _weeklyPlan[weekday] = recipeId;
    notifyListeners();
  }

  void removePlannedMeal(int weekday) {
    if (_weeklyPlan.remove(weekday) != null) notifyListeners();
  }

  void removeRecipeReferences(String recipeId) {
    final previousItemCount = _shoppingItems.length;
    _shoppingItems.removeWhere((item) => item.sourceRecipeId == recipeId);
    final plannedDays = _weeklyPlan.entries
        .where((entry) => entry.value == recipeId)
        .map((entry) => entry.key)
        .toList(growable: false);
    for (final day in plannedDays) {
      _weeklyPlan.remove(day);
    }
    if (_shoppingItems.length != previousItemCount || plannedDays.isNotEmpty) {
      notifyListeners();
    }
  }
}

class KitchenScope extends InheritedNotifier<KitchenController> {
  const KitchenScope({
    required KitchenController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static KitchenController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<KitchenScope>();
    assert(scope != null, 'Không tìm thấy KitchenScope trong cây widget.');
    return scope!.notifier!;
  }
}
