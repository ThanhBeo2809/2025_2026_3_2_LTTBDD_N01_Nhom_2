import '../../models/recipe.dart';

const Recipe banhMiTrungRecipe = Recipe(
    id: 'banh-mi-trung',
    titleVi: 'Bánh mì trứng ốp la',
    titleEn: 'Fried egg bánh mì',
    descriptionVi:
        'Bữa sáng nhanh với bánh mì giòn, trứng chín thơm, rau tươi và sốt béo cay cân bằng.',
    descriptionEn:
        'A quick breakfast of crisp baguette, cooked eggs, fresh vegetables and a creamy spicy sauce.',
    category: RecipeCategory.quick,
    difficulty: RecipeDifficulty.easy,
    preparationMinutes: 8,
    cookingMinutes: 10,
    servings: 1,
    emoji: '🥖',
    colorValue: 0xFFF4A261,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Bánh mì Việt Nam',
        nameEn: 'Vietnamese baguette',
        quantity: '1 ổ',
        quantityEn: '1 loaf',
      ),
      RecipeIngredient(
        nameVi: 'Trứng gà',
        nameEn: 'Eggs',
        quantity: '2 quả',
        quantityEn: '2 eggs',
      ),
      RecipeIngredient(
        nameVi: 'Dưa leo',
        nameEn: 'Cucumber',
        quantity: '1/2 quả',
        quantityEn: '1/2 cucumber',
      ),
      RecipeIngredient(
        nameVi: 'Cà rốt ngâm chua',
        nameEn: 'Pickled carrot',
        quantity: '30 g',
      ),
      RecipeIngredient(
        nameVi: 'Rau mùi',
        nameEn: 'Cilantro',
        quantity: '3 nhánh',
        quantityEn: '3 sprigs',
      ),
      RecipeIngredient(
        nameVi: 'Bơ hoặc mayonnaise',
        nameEn: 'Butter or mayonnaise',
        quantity: '1 thìa canh',
        quantityEn: '1 tbsp',
      ),
      RecipeIngredient(
        nameVi: 'Tương ớt',
        nameEn: 'Chili sauce',
        quantity: '1 thìa cà phê',
        quantityEn: '1 tsp',
      ),
      RecipeIngredient(
        nameVi: 'Dầu ăn, muối, tiêu',
        nameEn: 'Oil, salt and pepper',
        quantity: 'Vừa đủ',
        quantityEn: 'As needed',
      ),
    ],
    steps: [
      RecipeStep(
        titleVi: 'Chuẩn bị rau',
        titleEn: 'Prepare vegetables',
        durationMinutes: 3,
        instructionVi:
            'Rửa sạch dưa leo và rau mùi, để ráo hoàn toàn. Thái dưa leo thành lát dài mỏng; vắt nhẹ cà rốt ngâm chua để bánh không bị ướt.',
        instructionEn:
            'Wash and thoroughly dry cucumber and cilantro. Slice cucumber into thin strips and gently squeeze excess liquid from the pickled carrot.',
      ),
      RecipeStep(
        titleVi: 'Làm nóng bánh mì',
        titleEn: 'Warm the baguette',
        durationMinutes: 4,
        instructionVi:
            'Rạch dọc bánh mì nhưng không cắt rời. Nướng ở 180°C trong 3–4 phút hoặc áp chảo đến khi vỏ giòn và ruột còn mềm.',
        instructionEn:
            'Split the baguette without cutting through. Heat at 180°C for 3–4 minutes or toast in a dry pan until crisp outside and soft inside.',
      ),
      RecipeStep(
        titleVi: 'Chiên trứng',
        titleEn: 'Cook the eggs',
        durationMinutes: 5,
        instructionVi:
            'Làm nóng 1 thìa cà phê dầu ở lửa vừa, đập trứng vào và nêm ít muối tiêu. Đậy nắp, chiên đến khi cả lòng trắng và lòng đỏ đông hoàn toàn.',
        instructionEn:
            'Heat 1 teaspoon oil over medium heat, add eggs and season lightly. Cover and cook until both whites and yolks are firm.',
      ),
      RecipeStep(
        titleVi: 'Pha sốt',
        titleEn: 'Mix the sauce',
        durationMinutes: 1,
        instructionVi:
            'Trộn mayonnaise hoặc bơ mềm với tương ớt. Nếm và giảm tương ớt nếu không ăn cay.',
        instructionEn:
            'Mix mayonnaise or softened butter with chili sauce. Taste and reduce chili sauce if desired.',
      ),
      RecipeStep(
        titleVi: 'Kẹp bánh',
        titleEn: 'Assemble',
        durationMinutes: 2,
        instructionVi:
            'Phết sốt vào hai mặt bánh, đặt trứng còn nóng, dưa leo, cà rốt và rau mùi vào giữa. Ép nhẹ và dùng ngay khi bánh còn giòn.',
        instructionEn:
            'Spread sauce inside the baguette, then add hot eggs, cucumber, carrot and cilantro. Press gently and serve while crisp.',
      ),
    ],
    tipsVi: [
      'Nên để trứng ở nhiệt độ phòng khoảng 10 phút để trứng chín đều hơn.',
      'Theo hướng dẫn an toàn, nấu trứng đến khi lòng trắng và lòng đỏ đều đông chắc.',
    ],
    tipsEn: [
      'Let eggs sit at room temperature for about 10 minutes for more even cooking.',
      'For food safety, cook eggs until both whites and yolks are firm.',
    ],
);

