import 'package:flutter/material.dart';

class AppStrings {
  const AppStrings(this.isVietnamese);

  final bool isVietnamese;

  static AppStrings of(BuildContext context) => AppStrings(
    Localizations.localeOf(context).languageCode.toLowerCase() == 'vi',
  );

  String text(String vietnamese, String english) =>
      isVietnamese ? vietnamese : english;

  String get appName => 'Bếp Nhà';
  String get home => text('Trang chủ', 'Home');
  String get explore => text('Khám phá', 'Explore');
  String get favorites => text('Yêu thích', 'Favorites');
  String get settings => text('Cài đặt', 'Settings');
  String get kitchen => text('Gian bếp', 'Kitchen');
  String get kitchenAssistant => text('Trợ lý gian bếp', 'Kitchen assistant');
  String get weeklyPlan => text('Thực đơn tuần', 'Weekly plan');
  String get shoppingList => text('Đi chợ', 'Shopping list');
  String get planSubtitle => text(
    'Chọn một món ngon cho từng ngày',
    'Choose a delicious dish for each day',
  );
  String get chooseRecipe => text('Chọn món ăn', 'Choose a recipe');
  String get removeFromPlan => text('Bỏ khỏi thực đơn', 'Remove from plan');
  String get emptyShoppingList =>
      text('Danh sách đi chợ đang trống', 'Your shopping list is empty');
  String get shoppingHint => text(
    'Mở một công thức và thêm toàn bộ nguyên liệu chỉ với một chạm.',
    'Open a recipe and add all ingredients with one tap.',
  );
  String get purchasedProgress => text('Tiến độ mua sắm', 'Shopping progress');
  String get clearPurchased => text('Xóa món đã mua', 'Clear purchased');
  String get markPurchased => text('Đánh dấu đã mua', 'Mark as purchased');
  String get customRecipe => text('Công thức cá nhân', 'Custom recipe');
  String get addToShoppingList =>
      text('Thêm vào danh sách đi chợ', 'Add to shopping list');
  String get addedIngredients =>
      text('Đã thêm nguyên liệu cần mua', 'Ingredients added to shopping list');
  String get ingredientsAlreadyAdded => text(
    'Nguyên liệu của món này đã có trong danh sách',
    'This recipe is already on your shopping list',
  );
  String get addToWeeklyPlan => text('Lên thực đơn tuần', 'Add to weekly plan');
  String get selectDay => text('Chọn ngày', 'Select a day');
  String get mealPlanned =>
      text('Đã thêm món vào thực đơn', 'Meal added to plan');
  String get cookingMode => text('Chế độ nấu ăn', 'Cooking mode');
  String get startCooking => text('Bắt đầu nấu', 'Start cooking');
  String get previousStep => text('Bước trước', 'Previous');
  String get nextStep => text('Bước tiếp', 'Next');
  String get finishCooking => text('Hoàn thành', 'Finish');
  String get startTimer => text('Bắt đầu', 'Start timer');
  String get pause => text('Tạm dừng', 'Pause');
  String get resetTimer => text('Đặt lại đồng hồ', 'Reset timer');
  String get timerFinished => text('Đã hết thời gian!', 'Time is up!');
  String get cookingCompleted => text('Bạn đã nấu xong!', 'Cooking completed!');
  String get enjoyMeal => text(
    'Chúc bạn và gia đình có một bữa ăn ngon miệng.',
    'Enjoy a delicious meal with your family.',
  );
  String get done => text('Xong', 'Done');
  String get surpriseMe => text('Hôm nay ăn gì?', 'Surprise me');
  String get suggestedForYou => text('Gợi ý cho bạn', 'Suggested for you');
  String get viewRecipe => text('Xem công thức', 'View recipe');
  String get recentlyViewed => text('Vừa xem gần đây', 'Recently viewed');
  String get cooked => text('Đã nấu', 'Cooked');
  String get advancedFilters => text('Bộ lọc nâng cao', 'Advanced filters');
  String get maximumTime => text('Thời gian tối đa', 'Maximum time');
  String get anyDuration => text('Không giới hạn', 'Any duration');
  String get sortBy => text('Sắp xếp', 'Sort by');
  String get defaultSort => text('Mặc định', 'Default');
  String get fastest => text('Nhanh nhất', 'Fastest');
  String get alphabetical => text('Theo tên', 'Name');
  String get apply => text('Áp dụng', 'Apply');
  String get greeting =>
      text('Hôm nay bạn muốn nấu gì?', 'What will you cook today?');
  String get discoverSubtitle => text(
    'Khám phá hương vị mới cho căn bếp của bạn',
    'Discover new flavors for your kitchen',
  );
  String get searchHint =>
      text('Tìm món ăn hoặc nguyên liệu', 'Search dishes or ingredients');
  String get popularRecipes => text('Công thức nổi bật', 'Popular recipes');
  String get allRecipes => text('Tất cả công thức', 'All recipes');
  String get categories => text('Danh mục', 'Categories');
  String get minutes => text('phút', 'min');
  String get servings => text('khẩu phần', 'servings');
  String get ingredients => text('Nguyên liệu', 'Ingredients');
  String get directions => text('Cách thực hiện', 'Directions');
  String get step => text('Bước', 'Step');
  String get tips => text('Mẹo nhỏ', 'Helpful tips');
  String get preparation => text('Chuẩn bị', 'Preparation');
  String get cooking => text('Nấu', 'Cooking');
  String get difficulty => text('Độ khó', 'Difficulty');
  String get allLevels => text('Mọi độ khó', 'All levels');
  String get easy => text('Dễ', 'Easy');
  String get medium => text('Vừa', 'Medium');
  String get hard => text('Khó', 'Hard');
  String get vietnamese => text('Món Việt', 'Vietnamese');
  String get healthy => text('Lành mạnh', 'Healthy');
  String get dessert => text('Tráng miệng', 'Dessert');
  String get quick => text('Nấu nhanh', 'Quick');
  String get vegetarian => text('Món chay', 'Vegetarian');
  String get noResults => text('Không tìm thấy công thức', 'No recipes found');
  String get noFavorites =>
      text('Chưa có món yêu thích', 'No favorite recipes yet');
  String get addRecipe => text('Tạo công thức', 'Create recipe');
  String get editRecipe => text('Sửa công thức', 'Edit recipe');
  String get deleteRecipe => text('Xóa công thức', 'Delete recipe');
  String get save => text('Lưu', 'Save');
  String get cancel => text('Hủy', 'Cancel');
  String get delete => text('Xóa', 'Delete');
  String get confirmDelete => text(
    'Bạn có chắc muốn xóa công thức này?',
    'Are you sure you want to delete this recipe?',
  );
  String get recipeName => text('Tên món ăn', 'Recipe name');
  String get description => text('Mô tả', 'Description');
  String get requiredField =>
      text('Vui lòng nhập thông tin', 'Please enter this field');
  String get createdSuccessfully =>
      text('Đã tạo công thức mới', 'Recipe created');
  String get updatedSuccessfully =>
      text('Đã cập nhật công thức', 'Recipe updated');
  String get language => text('Ngôn ngữ', 'Language');
  String get appearance => text('Giao diện', 'Appearance');
  String get darkMode => text('Chế độ tối', 'Dark mode');
  String get teamInformation => text('Thông tin nhóm', 'Team information');
  String get aboutApp => text('Về Bếp Nhà', 'About Bếp Nhà');
  String get vietnameseLanguage => text('Tiếng Việt', 'Vietnamese');
  String get englishLanguage => text('Tiếng Anh', 'English');
  String get clearFilters => text('Xóa bộ lọc', 'Clear filters');
  String get recipes => text('công thức', 'recipes');

  String kitchenSummary(
    int plannedCount,
    int shoppingCount,
    int cookedCount,
  ) => text(
    '$plannedCount ngày đã lên món • $shoppingCount nguyên liệu cần mua • $cookedCount món đã nấu',
    '$plannedCount days planned • $shoppingCount ingredients to buy • $cookedCount cooked',
  );

  String weekday(int weekday) {
    const vi = [
      'Thứ Hai',
      'Thứ Ba',
      'Thứ Tư',
      'Thứ Năm',
      'Thứ Sáu',
      'Thứ Bảy',
      'Chủ Nhật',
    ];
    const en = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return (isVietnamese ? vi : en)[weekday - DateTime.monday];
  }

  String shortWeekday(int weekday) {
    const vi = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    const en = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return (isVietnamese ? vi : en)[weekday - DateTime.monday];
  }
}
