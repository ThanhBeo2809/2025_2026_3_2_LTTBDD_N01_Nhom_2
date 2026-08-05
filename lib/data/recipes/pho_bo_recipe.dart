import '../../models/recipe.dart';

const Recipe phoBoRecipe = Recipe(
    id: 'pho-bo',
    titleVi: 'Phở bò Hà Nội',
    titleEn: 'Hanoi beef pho',
    descriptionVi:
        'Phở bò truyền thống với nước dùng trong, vị ngọt tự nhiên từ xương, thơm quế hồi và thịt bò mềm.',
    descriptionEn:
        'Traditional beef pho with a clear bone broth, warm spices, tender beef and fresh herbs.',
    category: RecipeCategory.vietnamese,
    difficulty: RecipeDifficulty.medium,
    preparationMinutes: 35,
    cookingMinutes: 150,
    servings: 6,
    emoji: '🍜',
    colorValue: 0xFFF3B562,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Xương ống bò',
        nameEn: 'Beef marrow bones',
        quantity: '1,5 kg',
        quantityEn: '1.5 kg',
      ),
      RecipeIngredient(
        nameVi: 'Nạm bò',
        nameEn: 'Beef brisket',
        quantity: '500 g',
      ),
      RecipeIngredient(
        nameVi: 'Thịt bò tái',
        nameEn: 'Thinly sliced beef',
        quantity: '350 g',
      ),
      RecipeIngredient(
        nameVi: 'Bánh phở tươi',
        nameEn: 'Fresh rice noodles',
        quantity: '1 kg',
      ),
      RecipeIngredient(
        nameVi: 'Hành tây',
        nameEn: 'Onions',
        quantity: '2 củ',
        quantityEn: '2 onions',
      ),
      RecipeIngredient(nameVi: 'Gừng', nameEn: 'Ginger', quantity: '80 g'),
      RecipeIngredient(
        nameVi: 'Hoa hồi',
        nameEn: 'Star anise',
        quantity: '4 cánh',
        quantityEn: '4 pods',
      ),
      RecipeIngredient(
        nameVi: 'Quế thanh',
        nameEn: 'Cinnamon sticks',
        quantity: '2 thanh',
        quantityEn: '2 sticks',
      ),
      RecipeIngredient(
        nameVi: 'Thảo quả',
        nameEn: 'Black cardamom',
        quantity: '2 quả',
        quantityEn: '2 pods',
      ),
      RecipeIngredient(
        nameVi: 'Nước mắm',
        nameEn: 'Fish sauce',
        quantity: '3 thìa canh',
        quantityEn: '3 tbsp',
      ),
      RecipeIngredient(
        nameVi: 'Đường phèn',
        nameEn: 'Rock sugar',
        quantity: '25 g',
      ),
      RecipeIngredient(
        nameVi: 'Hành lá, rau mùi',
        nameEn: 'Scallions and cilantro',
        quantity: '1 phần',
        quantityEn: '1 portion',
      ),
      RecipeIngredient(
        nameVi: 'Chanh, ớt, tiêu',
        nameEn: 'Lime, chili and pepper',
        quantity: 'Tùy khẩu vị',
        quantityEn: 'To taste',
      ),
    ],
    steps: [
      RecipeStep(
        titleVi: 'Làm sạch xương',
        titleEn: 'Clean the bones',
        durationMinutes: 15,
        instructionVi:
            'Ngâm xương trong nước lạnh 10 phút, rửa sạch. Cho xương vào nồi nước sôi chần 5 phút, đổ bỏ nước và rửa lại từng khúc xương để nước dùng không bị đục.',
        instructionEn:
            'Soak the bones in cold water for 10 minutes. Blanch for 5 minutes, discard the water and rinse each bone thoroughly for a clear broth.',
      ),
      RecipeStep(
        titleVi: 'Nướng gia vị',
        titleEn: 'Toast the aromatics',
        durationMinutes: 10,
        instructionVi:
            'Bổ đôi hành tây và đập dập gừng. Nướng hành, gừng đến khi xém thơm. Rang khô hồi, quế và thảo quả 2–3 phút rồi cho vào túi lọc.',
        instructionEn:
            'Halve the onions and crush the ginger. Char both until fragrant. Dry-toast star anise, cinnamon and cardamom for 2–3 minutes, then place in a spice bag.',
      ),
      RecipeStep(
        titleVi: 'Hầm nước dùng',
        titleEn: 'Simmer the broth',
        durationMinutes: 120,
        instructionVi:
            'Cho xương vào 4 lít nước sạch, đun sôi rồi hạ lửa nhỏ. Thường xuyên hớt bọt trong 30 phút đầu. Thêm hành, gừng, túi gia vị và nạm bò; hầm liu riu, không đậy kín nắp.',
        instructionEn:
            'Cover the bones with 4 liters of water. Bring to a boil, then reduce to a gentle simmer. Skim often during the first 30 minutes. Add aromatics, spice bag and brisket; simmer with the lid slightly open.',
      ),
      RecipeStep(
        titleVi: 'Vớt thịt và nêm',
        titleEn: 'Remove beef and season',
        durationMinutes: 15,
        instructionVi:
            'Sau khoảng 60–75 phút, dùng đũa xiên thử nạm; khi mềm thì vớt ra ngâm nước nguội 5 phút rồi thái mỏng. Nêm nước dùng bằng nước mắm, đường phèn và muối, điều chỉnh sao cho vị hơi đậm.',
        instructionEn:
            'After 60–75 minutes, check the brisket. When tender, cool it in water for 5 minutes and slice thinly. Season the broth with fish sauce, rock sugar and salt; keep it slightly strong to balance the noodles.',
      ),
      RecipeStep(
        titleVi: 'Chuẩn bị bánh và rau',
        titleEn: 'Prepare noodles and herbs',
        durationMinutes: 8,
        instructionVi:
            'Rửa và thái nhỏ hành lá, rau mùi. Chần bánh phở từng phần trong nước sôi 10–15 giây, lắc thật ráo rồi cho vào bát đã làm ấm.',
        instructionEn:
            'Wash and chop the herbs. Blanch each portion of noodles for 10–15 seconds, drain thoroughly and place in warmed bowls.',
      ),
      RecipeStep(
        titleVi: 'Hoàn thiện bát phở',
        titleEn: 'Assemble and serve',
        durationMinutes: 5,
        instructionVi:
            'Xếp nạm chín và thịt bò thái thật mỏng lên bánh phở. Đun nước dùng sôi mạnh, chan trực tiếp lên thịt để làm chín. Thêm hành, rau mùi, tiêu; dùng ngay với chanh và ớt.',
        instructionEn:
            'Arrange cooked brisket and paper-thin raw beef over the noodles. Bring broth to a vigorous boil and ladle it directly over the beef. Add herbs and pepper; serve immediately with lime and chili.',
      ),
    ],
    tipsVi: [
      'Không khuấy mạnh khi hầm vì tủy và cặn xương sẽ làm nước dùng bị đục.',
      'Nếu nước cạn, chỉ thêm nước sôi để không làm gián đoạn quá trình hầm.',
      'Thịt bò tái phải được thái thật mỏng và nước dùng phải sôi mạnh khi chan.',
    ],
    tipsEn: [
      'Avoid vigorous stirring while simmering because bone residue can cloud the broth.',
      'If the broth reduces too much, top up with boiling water only.',
      'Slice raw beef paper-thin and make sure the broth is vigorously boiling before serving.',
    ],
);

