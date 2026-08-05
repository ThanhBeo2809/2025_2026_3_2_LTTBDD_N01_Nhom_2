class ShoppingItem {
  const ShoppingItem({
    required this.id,
    required this.nameVi,
    required this.nameEn,
    required this.quantityVi,
    required this.quantityEn,
    required this.sourceRecipeId,
    this.isPurchased = false,
  });

  final String id;
  final String nameVi;
  final String nameEn;
  final String quantityVi;
  final String quantityEn;
  final String sourceRecipeId;
  final bool isPurchased;

  String localizedName(bool isVietnamese) => isVietnamese ? nameVi : nameEn;

  String localizedQuantity(bool isVietnamese) =>
      isVietnamese ? quantityVi : quantityEn;

  ShoppingItem copyWith({bool? isPurchased}) {
    return ShoppingItem(
      id: id,
      nameVi: nameVi,
      nameEn: nameEn,
      quantityVi: quantityVi,
      quantityEn: quantityEn,
      sourceRecipeId: sourceRecipeId,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }
}
