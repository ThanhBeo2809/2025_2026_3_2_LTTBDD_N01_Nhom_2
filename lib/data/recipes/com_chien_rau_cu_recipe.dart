import '../../models/recipe.dart';

const Recipe comChienRauCuRecipe = Recipe(
    id: 'com-chien-rau-cu',
    titleVi: 'Cơm chiên rau củ',
    titleEn: 'Vegetable fried rice',
    descriptionVi:
        'Cơm chiên tơi hạt với rau củ nhiều màu sắc, phù hợp cho bữa ăn nhanh và tận dụng cơm nguội đúng cách.',
    descriptionEn:
        'Fluffy fried rice with colorful vegetables, ideal for a quick meal and safely using chilled leftover rice.',
    category: RecipeCategory.vegetarian,
    difficulty: RecipeDifficulty.easy,
    preparationMinutes: 15,
    cookingMinutes: 15,
    servings: 3,
    emoji: '🍚',
    colorValue: 0xFFE9C46A,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Cơm nguội để lạnh',
        nameEn: 'Chilled cooked rice',
        quantity: '3 bát',
        quantityEn: '3 bowls',
      ),
      RecipeIngredient(
        nameVi: 'Cà rốt',
        nameEn: 'Carrot',
        quantity: '1/2 củ',
        quantityEn: '1/2 carrot',
      ),
      RecipeIngredient(
        nameVi: 'Đậu Hà Lan',
        nameEn: 'Green peas',
        quantity: '80 g',
      ),
      RecipeIngredient(
        nameVi: 'Bắp ngọt',
        nameEn: 'Sweet corn',
        quantity: '80 g',
      ),
      RecipeIngredient(
        nameVi: 'Nấm đùi gà',
        nameEn: 'King oyster mushroom',
        quantity: '120 g',
      ),
      RecipeIngredient(
        nameVi: 'Hành lá',
        nameEn: 'Scallions',
        quantity: '2 nhánh',
        quantityEn: '2 stalks',
      ),
      RecipeIngredient(
        nameVi: 'Tỏi băm',
        nameEn: 'Minced garlic',
        quantity: '2 tép',
        quantityEn: '2 cloves',
      ),
      RecipeIngredient(
        nameVi: 'Nước tương',
        nameEn: 'Soy sauce',
        quantity: '1,5 thìa canh',
        quantityEn: '1.5 tbsp',
      ),
      RecipeIngredient(
        nameVi: 'Dầu mè',
        nameEn: 'Sesame oil',
        quantity: '1 thìa cà phê',
        quantityEn: '1 tsp',
      ),
      RecipeIngredient(
        nameVi: 'Dầu ăn và tiêu',
        nameEn: 'Cooking oil and pepper',
        quantity: 'Vừa đủ',
        quantityEn: 'As needed',
      ),
    ],
    steps: [
      RecipeStep(
        titleVi: 'Làm tơi cơm',
        titleEn: 'Separate the rice',
        durationMinutes: 3,
        instructionVi:
            'Dùng tay sạch hoặc nĩa bóp nhẹ cơm nguội để tách hạt. Nếu cơm vón cứng, rưới 1 thìa cà phê nước rồi trộn đều, không làm cơm quá ướt.',
        instructionEn:
            'Use clean hands or a fork to separate chilled rice. If very dry, sprinkle with 1 teaspoon water, but do not make it wet.',
      ),
      RecipeStep(
        titleVi: 'Sơ chế rau củ',
        titleEn: 'Prepare vegetables',
        durationMinutes: 7,
        instructionVi:
            'Cắt cà rốt và nấm thành hạt lựu khoảng 0,5 cm để chín đều. Rửa đậu, bắp và để ráo. Tách riêng đầu hành trắng với phần lá xanh.',
        instructionEn:
            'Dice carrot and mushroom into 0.5 cm pieces for even cooking. Rinse peas and corn, then drain. Separate white and green scallion parts.',
      ),
      RecipeStep(
        titleVi: 'Xào rau củ',
        titleEn: 'Stir-fry vegetables',
        durationMinutes: 5,
        instructionVi:
            'Làm nóng chảo lớn ở lửa vừa cao, thêm 1 thìa canh dầu. Phi tỏi và đầu hành 20 giây, thêm cà rốt, nấm, đậu và bắp; đảo 3–4 phút đến khi vừa chín.',
        instructionEn:
            'Heat a large wok over medium-high heat with 1 tablespoon oil. Fry garlic and scallion whites for 20 seconds, then cook vegetables for 3–4 minutes until just tender.',
      ),
      RecipeStep(
        titleVi: 'Chiên cơm',
        titleEn: 'Fry the rice',
        durationMinutes: 5,
        instructionVi:
            'Tăng lửa, cho cơm vào và dùng xẻng dàn mỏng. Để yên 30 giây rồi đảo; lặp lại 3–4 lần đến khi hạt cơm nóng đều, khô và tơi.',
        instructionEn:
            'Increase heat, add rice and spread it thinly. Leave for 30 seconds, then toss; repeat 3–4 times until the grains are hot, dry and separate.',
      ),
      RecipeStep(
        titleVi: 'Nêm gia vị',
        titleEn: 'Season',
        durationMinutes: 2,
        instructionVi:
            'Rưới nước tương quanh thành chảo thay vì đổ trực tiếp lên cơm. Thêm tiêu, dầu mè và đảo nhanh để gia vị phủ đều.',
        instructionEn:
            'Pour soy sauce around the hot sides of the wok rather than directly onto the rice. Add pepper and sesame oil, then toss quickly.',
      ),
      RecipeStep(
        titleVi: 'Hoàn thiện',
        titleEn: 'Finish',
        durationMinutes: 1,
        instructionVi:
            'Thêm hành lá, đảo thêm 30 giây rồi tắt bếp. Nếm lại và dùng ngay khi cơm còn nóng.',
        instructionEn:
            'Add scallion greens, toss for 30 seconds and turn off the heat. Taste and serve immediately while hot.',
      ),
    ],
    tipsVi: [
      'Dùng cơm đã làm nguội nhanh và bảo quản lạnh; không dùng cơm để ở nhiệt độ phòng quá lâu.',
      'Chảo rộng và nóng giúp hơi nước thoát nhanh, cơm không bị nhão.',
      'Không cho quá nhiều nước tương vì cơm sẽ ướt và mặn.',
    ],
    tipsEn: [
      'Use rice that was cooled promptly and refrigerated; avoid rice left at room temperature for extended periods.',
      'A wide, hot wok lets steam escape and keeps the rice from turning soggy.',
      'Avoid excess soy sauce because it makes the rice wet and salty.',
    ],
);

