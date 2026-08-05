import 'package:flutter/material.dart';

import '../data/mock_recipes.dart';
import '../models/recipe.dart';

enum RecipeSort { none, fastest, name }

class RecipeController extends ChangeNotifier {
  RecipeController({List<Recipe>? initialRecipes})
    : _recipes = List<Recipe>.of(initialRecipes ?? mockRecipes);

  final List<Recipe> _recipes;
  String _query = '';
  RecipeCategory? _selectedCategory;
  RecipeDifficulty? _selectedDifficulty;
  int? _maxMinutes;
  RecipeSort _sort = RecipeSort.none;
  final List<String> _recentRecipeIds = [];
  final Set<String> _cookedRecipeIds = {};

  List<Recipe> get recipes => List.unmodifiable(_recipes);
  String get query => _query;
  RecipeCategory? get selectedCategory => _selectedCategory;
  RecipeDifficulty? get selectedDifficulty => _selectedDifficulty;
  int? get maxMinutes => _maxMinutes;
  RecipeSort get sort => _sort;
  bool get hasActiveFilters =>
      _query.isNotEmpty ||
      _selectedCategory != null ||
      _selectedDifficulty != null ||
      _maxMinutes != null ||
      _sort != RecipeSort.none;
  int get activeFilterCount => [
    _selectedCategory,
    _selectedDifficulty,
    _maxMinutes,
    _sort == RecipeSort.none ? null : _sort,
  ].where((value) => value != null).length;
  List<Recipe> get favorites =>
      _recipes.where((recipe) => recipe.isFavorite).toList(growable: false);
  List<Recipe> get recentlyViewed => _recentRecipeIds
      .map(recipeById)
      .whereType<Recipe>()
      .toList(growable: false);
  List<Recipe> get cookedRecipes => _recipes
      .where((recipe) => _cookedRecipeIds.contains(recipe.id))
      .toList(growable: false);

  List<Recipe> filteredRecipes(bool isVietnamese) {
    final result = _recipes.where((recipe) {
      final matchesCategory =
          _selectedCategory == null || recipe.category == _selectedCategory;
      final matchesDifficulty =
          _selectedDifficulty == null ||
          recipe.difficulty == _selectedDifficulty;
      final matchesDuration =
          _maxMinutes == null || recipe.totalMinutes <= _maxMinutes!;
      return matchesCategory &&
          matchesDifficulty &&
          matchesDuration &&
          recipe.matches(_query, isVietnamese);
    }).toList();
    switch (_sort) {
      case RecipeSort.none:
        break;
      case RecipeSort.fastest:
        result.sort((a, b) => a.totalMinutes.compareTo(b.totalMinutes));
      case RecipeSort.name:
        result.sort(
          (a, b) => a
              .localizedTitle(isVietnamese)
              .compareTo(b.localizedTitle(isVietnamese)),
        );
    }
    return List.unmodifiable(result);
  }

  Recipe? recipeById(String id) {
    for (final recipe in _recipes) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  void setQuery(String value) {
    if (_query == value) return;
    _query = value;
    notifyListeners();
  }

  void setCategory(RecipeCategory? value) {
    if (_selectedCategory == value) return;
    _selectedCategory = value;
    notifyListeners();
  }

  void setDifficulty(RecipeDifficulty? value) {
    if (_selectedDifficulty == value) return;
    _selectedDifficulty = value;
    notifyListeners();
  }

  void setMaxMinutes(int? value) {
    if (_maxMinutes == value) return;
    _maxMinutes = value;
    notifyListeners();
  }

  void setSort(RecipeSort value) {
    if (_sort == value) return;
    _sort = value;
    notifyListeners();
  }

  void clearFilters() {
    if (!hasActiveFilters) return;
    _query = '';
    _selectedCategory = null;
    _selectedDifficulty = null;
    _maxMinutes = null;
    _sort = RecipeSort.none;
    notifyListeners();
  }

  void markViewed(String id) {
    if (recipeById(id) == null) return;
    _recentRecipeIds.remove(id);
    _recentRecipeIds.insert(0, id);
    if (_recentRecipeIds.length > 5) _recentRecipeIds.removeLast();
    notifyListeners();
  }

  void markCooked(String id) {
    if (recipeById(id) == null || !_cookedRecipeIds.add(id)) return;
    notifyListeners();
  }

  bool isCooked(String id) => _cookedRecipeIds.contains(id);

  void toggleFavorite(String id) {
    final index = _recipes.indexWhere((recipe) => recipe.id == id);
    if (index == -1) return;
    _recipes[index] = _recipes[index].copyWith(
      isFavorite: !_recipes[index].isFavorite,
    );
    notifyListeners();
  }

  void addRecipe(Recipe recipe) {
    _recipes.insert(0, recipe.copyWith(isUserCreated: true));
    notifyListeners();
  }

  void updateRecipe(Recipe recipe) {
    final index = _recipes.indexWhere((item) => item.id == recipe.id);
    if (index == -1) return;
    _recipes[index] = recipe;
    notifyListeners();
  }

  void deleteRecipe(String id) {
    _recipes.removeWhere((recipe) => recipe.id == id);
    _recentRecipeIds.remove(id);
    _cookedRecipeIds.remove(id);
    notifyListeners();
  }
}

class RecipeScope extends InheritedNotifier<RecipeController> {
  const RecipeScope({
    required RecipeController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static RecipeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RecipeScope>();
    assert(scope != null, 'Không tìm thấy RecipeScope trong cây widget.');
    return scope!.notifier!;
  }
}
