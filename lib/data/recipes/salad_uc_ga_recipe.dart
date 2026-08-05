import '../../models/recipe.dart';

const Recipe saladUcGaRecipe = Recipe(
    id: 'salad-uc-ga',
    titleVi: 'Salad ức gà',
    titleEn: 'Chicken breast salad',
    descriptionVi:
        'Salad giàu đạm với ức gà áp chảo mọng mềm, rau xanh giòn và sốt chanh mật ong cân bằng.',
    descriptionEn:
        'A protein-rich salad with juicy seared chicken, crisp vegetables and balanced honey-lime dressing.',
    category: RecipeCategory.healthy,
    difficulty: RecipeDifficulty.easy,
    preparationMinutes: 20,
    cookingMinutes: 15,
    servings: 2,
    emoji: '🥗',
    colorValue: 0xFF52B788,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Ức gà không da',
        nameEn: 'Skinless chicken breast',
        quantity: '300 g',
      ),
      RecipeIngredient(nameVi: 'Xà lách', nameEn: 'Lettuce', quantity: '180 g'),
      RecipeIngredient(
        nameVi: 'Cà chua bi',
        nameEn: 'Cherry tomatoes',
        quantity: '120 g',
      ),
      RecipeIngredient(
        nameVi: 'Dưa leo',
        nameEn: 'Cucumber',
        quantity: '1 quả nhỏ',
        quantityEn: '1 small cucumber',
      ),
      RecipeIngredient(
        nameVi: 'Bắp ngọt chín',
        nameEn: 'Cooked sweet corn',
        quantity: '80 g',
      ),
      RecipeIngredient(
        nameVi: 'Bơ quả',
        nameEn: 'Avocado',
        quantity: '1/2 quả',
        quantityEn: '1/2 avocado',
      ),
      RecipeIngredient(
        nameVi: 'Dầu ô liu',
        nameEn: 'Olive oil',
        quantity: '2 thìa canh',
        quantityEn: '2 tbsp',
      ),
      RecipeIngredient(
        nameVi: 'Nước cốt chanh',
        nameEn: 'Lime juice',
        quantity: '1,5 thìa canh',
        quantityEn: '1.5 tbsp',
      ),
      RecipeIngredient(
        nameVi: 'Mật ong',
        nameEn: 'Honey',
        quantity: '1 thìa cà phê',
        quantityEn: '1 tsp',
      ),
      RecipeIngredient(
        nameVi: 'Tỏi băm, muối, tiêu',
        nameEn: 'Garlic, salt and pepper',
        quantity: 'Vừa đủ',
        quantityEn: 'As needed',
      ),
    ],
    steps: [
      RecipeStep(
        titleVi: 'Sơ chế an toàn',
        titleEn: 'Prepare safely',
        durationMinutes: 5,
        instructionVi:
            'Dùng thớt riêng cho thịt sống. Thấm khô ức gà bằng giấy bếp, không rửa dưới vòi nước để tránh bắn nhiễm khuẩn. Rửa tay và dụng cụ ngay sau khi xử lý.',
        instructionEn:
            'Use a separate board for raw chicken. Pat it dry with paper towel; do not rinse under running water to avoid splashing bacteria. Wash hands and tools immediately afterward.',
      ),
      RecipeStep(
        titleVi: 'Ướp gà',
        titleEn: 'Season the chicken',
        durationMinutes: 10,
        instructionVi:
            'Dần ức gà về độ dày khoảng 1,5–2 cm để chín đều. Ướp với 1 thìa cà phê dầu ô liu, tỏi, 1/4 thìa cà phê muối và tiêu trong 10 phút.',
        instructionEn:
            'Pound chicken to an even 1.5–2 cm thickness. Season with 1 teaspoon olive oil, garlic, 1/4 teaspoon salt and pepper for 10 minutes.',
      ),
      RecipeStep(
        titleVi: 'Áp chảo gà',
        titleEn: 'Sear the chicken',
        durationMinutes: 12,
        instructionVi:
            'Làm nóng chảo ở lửa vừa cao. Áp chảo mỗi mặt 5–6 phút tùy độ dày, giảm lửa nếu mặt ngoài sẫm quá nhanh. Dùng nhiệt kế kiểm tra phần dày nhất đạt tối thiểu 74°C.',
        instructionEn:
            'Heat a pan over medium-high heat. Sear for 5–6 minutes per side depending on thickness, lowering heat if browning too quickly. Check that the thickest part reaches at least 74°C (165°F).',
      ),
      RecipeStep(
        titleVi: 'Để thịt nghỉ',
        titleEn: 'Rest the chicken',
        durationMinutes: 5,
        instructionVi:
            'Chuyển gà sang đĩa sạch và để nghỉ 5 phút trước khi thái chéo thớ thành lát vừa ăn. Không đặt thịt chín lại lên đĩa từng đựng thịt sống.',
        instructionEn:
            'Move chicken to a clean plate and rest for 5 minutes before slicing across the grain. Never return cooked chicken to the plate that held it raw.',
      ),
      RecipeStep(
        titleVi: 'Chuẩn bị rau và sốt',
        titleEn: 'Prepare vegetables and dressing',
        durationMinutes: 8,
        instructionVi:
            'Rửa rau dưới nước sạch và để thật ráo. Xé xà lách, bổ đôi cà chua, thái dưa leo và bơ. Đánh đều dầu ô liu còn lại, nước chanh, mật ong, muối và tiêu.',
        instructionEn:
            'Rinse vegetables under clean water and dry thoroughly. Tear lettuce, halve tomatoes, and slice cucumber and avocado. Whisk remaining olive oil with lime, honey, salt and pepper.',
      ),
      RecipeStep(
        titleVi: 'Trộn và dùng ngay',
        titleEn: 'Toss and serve',
        durationMinutes: 3,
        instructionVi:
            'Trộn xà lách, cà chua, dưa leo và bắp với 2/3 lượng sốt. Xếp bơ và gà lên trên, rưới phần sốt còn lại rồi dùng ngay để rau giữ độ giòn.',
        instructionEn:
            'Toss lettuce, tomato, cucumber and corn with two-thirds of the dressing. Top with avocado and chicken, drizzle the remaining dressing and serve immediately.',
      ),
    ],
    tipsVi: [
      'Gia cầm cần đạt nhiệt độ bên trong tối thiểu 74°C, đo tại phần dày nhất bằng nhiệt kế thực phẩm.',
      'Luôn tách thịt gà sống khỏi rau ăn liền và dùng đĩa sạch cho thịt đã chín.',
      'Chỉ trộn sốt ngay trước khi ăn để rau không bị mềm và chảy nước.',
    ],
    tipsEn: [
      'Poultry must reach at least 74°C (165°F) internally, measured in the thickest part with a food thermometer.',
      'Keep raw chicken separate from ready-to-eat vegetables and use a clean plate for cooked chicken.',
      'Dress the salad just before serving so the vegetables stay crisp.',
    ],
);

