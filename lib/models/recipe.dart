enum RecipeCategory { vietnamese, healthy, dessert, quick, vegetarian }

enum RecipeDifficulty { easy, medium, hard }

class RecipeIngredient {
  const RecipeIngredient({
    required this.nameVi,
    required this.nameEn,
    required this.quantity,
    this.quantityEn,
  });

  final String nameVi;
  final String nameEn;
  final String quantity;
  final String? quantityEn;

  String localizedName(bool isVietnamese) => isVietnamese ? nameVi : nameEn;

  String localizedQuantity(bool isVietnamese) =>
      isVietnamese ? quantity : (quantityEn ?? quantity);
}

class RecipeStep {
  const RecipeStep({
    required this.instructionVi,
    required this.instructionEn,
    this.titleVi = '',
    this.titleEn = '',
    this.durationMinutes = 0,
  });

  final String instructionVi;
  final String instructionEn;
  final String titleVi;
  final String titleEn;
  final int durationMinutes;

  String localizedTitle(bool isVietnamese) => isVietnamese ? titleVi : titleEn;

  String localizedInstruction(bool isVietnamese) =>
      isVietnamese ? instructionVi : instructionEn;
}

class Recipe {
  const Recipe({
    required this.id,
    required this.titleVi,
    required this.titleEn,
    required this.descriptionVi,
    required this.descriptionEn,
    required this.category,
    required this.difficulty,
    required this.preparationMinutes,
    required this.cookingMinutes,
    required this.servings,
    required this.emoji,
    required this.colorValue,
    required this.ingredients,
    required this.steps,
    this.tipsVi = const [],
    this.tipsEn = const [],
    this.isFavorite = false,
    this.isUserCreated = false,
  });

  final String id;
  final String titleVi;
  final String titleEn;
  final String descriptionVi;
  final String descriptionEn;
  final RecipeCategory category;
  final RecipeDifficulty difficulty;
  final int preparationMinutes;
  final int cookingMinutes;
  final int servings;
  final String emoji;
  final int colorValue;
  final List<RecipeIngredient> ingredients;
  final List<RecipeStep> steps;
  final List<String> tipsVi;
  final List<String> tipsEn;
  final bool isFavorite;
  final bool isUserCreated;

  int get totalMinutes => preparationMinutes + cookingMinutes;

  String localizedTitle(bool isVietnamese) => isVietnamese ? titleVi : titleEn;

  String localizedDescription(bool isVietnamese) =>
      isVietnamese ? descriptionVi : descriptionEn;

  List<String> localizedTips(bool isVietnamese) =>
      isVietnamese ? tipsVi : tipsEn;

  bool matches(String query, bool isVietnamese) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return true;

    return localizedTitle(
          isVietnamese,
        ).toLowerCase().contains(normalizedQuery) ||
        ingredients.any(
          (ingredient) => ingredient
              .localizedName(isVietnamese)
              .toLowerCase()
              .contains(normalizedQuery),
        );
  }

  Recipe copyWith({
    String? id,
    String? titleVi,
    String? titleEn,
    String? descriptionVi,
    String? descriptionEn,
    RecipeCategory? category,
    RecipeDifficulty? difficulty,
    int? preparationMinutes,
    int? cookingMinutes,
    int? servings,
    String? emoji,
    int? colorValue,
    List<RecipeIngredient>? ingredients,
    List<RecipeStep>? steps,
    List<String>? tipsVi,
    List<String>? tipsEn,
    bool? isFavorite,
    bool? isUserCreated,
  }) {
    return Recipe(
      id: id ?? this.id,
      titleVi: titleVi ?? this.titleVi,
      titleEn: titleEn ?? this.titleEn,
      descriptionVi: descriptionVi ?? this.descriptionVi,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      preparationMinutes: preparationMinutes ?? this.preparationMinutes,
      cookingMinutes: cookingMinutes ?? this.cookingMinutes,
      servings: servings ?? this.servings,
      emoji: emoji ?? this.emoji,
      colorValue: colorValue ?? this.colorValue,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      tipsVi: tipsVi ?? this.tipsVi,
      tipsEn: tipsEn ?? this.tipsEn,
      isFavorite: isFavorite ?? this.isFavorite,
      isUserCreated: isUserCreated ?? this.isUserCreated,
    );
  }
}
