import '../../models/recipe.dart';

const Recipe goiCuonRecipe = Recipe(
    id: 'goi-cuon',
    titleVi: 'Gỏi cuốn tôm thịt',
    titleEn: 'Fresh shrimp and pork rolls',
    descriptionVi:
        'Gỏi cuốn thanh mát với tôm, thịt ba chỉ, bún và rau thơm, ăn kèm nước chấm đậu phộng đậm vị.',
    descriptionEn:
        'Fresh rice-paper rolls filled with shrimp, pork, noodles and herbs, served with peanut dipping sauce.',
    category: RecipeCategory.healthy,
    difficulty: RecipeDifficulty.easy,
    preparationMinutes: 30,
    cookingMinutes: 20,
    servings: 4,
    emoji: '🥬',
    colorValue: 0xFF77BFA3,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Bánh tráng',
        nameEn: 'Rice paper',
        quantity: '16 lá',
        quantityEn: '16 sheets',
      ),
      RecipeIngredient(
        nameVi: 'Tôm tươi',
        nameEn: 'Fresh shrimp',
        quantity: '300 g',
      ),
      RecipeIngredient(
        nameVi: 'Thịt ba chỉ',
        nameEn: 'Pork belly',
        quantity: '300 g',
      ),
      RecipeIngredient(
        nameVi: 'Bún tươi',
        nameEn: 'Rice vermicelli',
        quantity: '300 g',
      ),
      RecipeIngredient(
        nameVi: 'Xà lách',
        nameEn: 'Lettuce',
        quantity: '1 cây',
        quantityEn: '1 head',
      ),
      RecipeIngredient(
        nameVi: 'Húng quế và rau mùi',
        nameEn: 'Thai basil and cilantro',
        quantity: '1 bó nhỏ',
        quantityEn: '1 small bunch',
      ),
      RecipeIngredient(
        nameVi: 'Hẹ',
        nameEn: 'Garlic chives',
        quantity: '16 cọng',
        quantityEn: '16 stalks',
      ),
      RecipeIngredient(
        nameVi: 'Tương đen',
        nameEn: 'Hoisin sauce',
        quantity: '4 thìa canh',
        quantityEn: '4 tbsp',
      ),
      RecipeIngredient(
        nameVi: 'Bơ đậu phộng',
        nameEn: 'Peanut butter',
        quantity: '2 thìa canh',
        quantityEn: '2 tbsp',
      ),
      RecipeIngredient(
        nameVi: 'Đậu phộng rang',
        nameEn: 'Roasted peanuts',
        quantity: '30 g',
      ),
    ],
    steps: [
      RecipeStep(
        titleVi: 'Luộc thịt',
        titleEn: 'Cook the pork',
        durationMinutes: 18,
        instructionVi:
            'Cho thịt vào nồi, đổ ngập nước cùng một nhúm muối. Đun sôi, hạ lửa vừa và luộc 15–18 phút đến khi chín hoàn toàn. Vớt ra để nguội rồi thái lát mỏng.',
        instructionEn:
            'Cover pork with water and add a pinch of salt. Bring to a boil, reduce to medium and cook for 15–18 minutes until fully done. Cool and slice thinly.',
      ),
      RecipeStep(
        titleVi: 'Luộc tôm',
        titleEn: 'Cook the shrimp',
        durationMinutes: 5,
        instructionVi:
            'Luộc tôm trong nước sôi 3–4 phút đến khi tôm chuyển hồng và thịt đục. Vớt vào nước nguội, bóc vỏ, bỏ chỉ lưng rồi bổ đôi theo chiều dọc.',
        instructionEn:
            'Boil shrimp for 3–4 minutes until pink and opaque. Cool in water, peel, devein and halve lengthwise.',
      ),
      RecipeStep(
        titleVi: 'Chuẩn bị phần cuốn',
        titleEn: 'Prepare the fillings',
        durationMinutes: 10,
        instructionVi:
            'Chần bún theo hướng dẫn, xả nguội và để thật ráo. Rửa rau nhiều lần, ngâm nước sạch rồi để ráo. Chia nguyên liệu thành 16 phần để các cuốn đều nhau.',
        instructionEn:
            'Prepare noodles according to the package, rinse and drain well. Wash and dry the herbs. Divide all fillings into 16 equal portions.',
      ),
      RecipeStep(
        titleVi: 'Pha nước chấm',
        titleEn: 'Make the dipping sauce',
        durationMinutes: 5,
        instructionVi:
            'Khuấy tương đen, bơ đậu phộng và 4 thìa canh nước ấm đến mịn. Đun nhỏ lửa 2 phút, điều chỉnh độ sệt rồi rắc đậu phộng rang lên trên.',
        instructionEn:
            'Whisk hoisin, peanut butter and 4 tablespoons warm water until smooth. Simmer for 2 minutes, adjust the consistency and top with peanuts.',
      ),
      RecipeStep(
        titleVi: 'Cuốn bánh tráng',
        titleEn: 'Roll the rice paper',
        durationMinutes: 15,
        instructionVi:
            'Nhúng nhanh bánh tráng vào nước, đặt lên thớt sạch. Xếp xà lách, rau thơm, bún và thịt ở 1/3 dưới; gấp hai mép, cuộn một vòng rồi xếp tôm cùng hẹ và cuộn chặt đến hết.',
        instructionEn:
            'Dip rice paper briefly in water and place on a clean board. Layer lettuce, herbs, noodles and pork on the lower third. Fold the sides, roll once, add shrimp and chive, then finish tightly.',
      ),
      RecipeStep(
        titleVi: 'Trình bày',
        titleEn: 'Serve',
        durationMinutes: 2,
        instructionVi:
            'Xếp gỏi cuốn lên đĩa, phủ khăn ẩm nếu chưa dùng ngay để bánh không khô. Dùng trong ngày cùng nước chấm đậu phộng.',
        instructionEn:
            'Arrange rolls on a plate and cover with a damp towel if not serving immediately. Enjoy the same day with peanut dipping sauce.',
      ),
    ],
    tipsVi: [
      'Chỉ nhúng bánh tráng thật nhanh; bánh sẽ tiếp tục mềm trong lúc xếp nhân.',
      'Để tất cả nguyên liệu thật ráo nhằm tránh cuốn bị rách hoặc chảy nước.',
      'Dùng thớt và dụng cụ sạch khi xử lý phần rau ăn sống.',
    ],
    tipsEn: [
      'Dip rice paper very briefly; it continues softening while you add fillings.',
      'Drain every ingredient thoroughly to prevent tearing and excess moisture.',
      'Use a clean board and utensils for vegetables that will be eaten raw.',
    ],
);

