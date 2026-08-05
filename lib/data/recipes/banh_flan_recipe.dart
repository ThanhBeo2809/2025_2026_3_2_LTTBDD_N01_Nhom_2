import '../../models/recipe.dart';

const Recipe banhFlanRecipe = Recipe(
    id: 'banh-flan',
    titleVi: 'Bánh flan caramel',
    titleEn: 'Caramel flan',
    descriptionVi:
        'Bánh flan mềm mịn, béo nhẹ, không rỗ mặt và phủ lớp caramel hổ phách cân bằng vị ngọt.',
    descriptionEn:
        'Silky, gently sweet custard with a smooth surface and amber caramel sauce.',
    category: RecipeCategory.dessert,
    difficulty: RecipeDifficulty.medium,
    preparationMinutes: 25,
    cookingMinutes: 40,
    servings: 6,
    emoji: '🍮',
    colorValue: 0xFFE76F51,
    ingredients: [
      RecipeIngredient(
        nameVi: 'Trứng gà',
        nameEn: 'Eggs',
        quantity: '5 quả',
        quantityEn: '5 eggs',
      ),
      RecipeIngredient(
        nameVi: 'Lòng đỏ trứng',
        nameEn: 'Egg yolks',
        quantity: '2 lòng',
        quantityEn: '2 yolks',
      ),
      RecipeIngredient(
        nameVi: 'Sữa tươi không đường',
        nameEn: 'Unsweetened milk',
        quantity: '500 ml',
      ),
      RecipeIngredient(
        nameVi: 'Sữa đặc',
        nameEn: 'Condensed milk',
        quantity: '120 ml',
      ),
      RecipeIngredient(
        nameVi: 'Đường làm caramel',
        nameEn: 'Sugar for caramel',
        quantity: '100 g',
      ),
      RecipeIngredient(nameVi: 'Nước lọc', nameEn: 'Water', quantity: '40 ml'),
      RecipeIngredient(
        nameVi: 'Nước cốt chanh',
        nameEn: 'Lemon juice',
        quantity: '1 thìa cà phê',
        quantityEn: '1 tsp',
      ),
      RecipeIngredient(
        nameVi: 'Vani',
        nameEn: 'Vanilla extract',
        quantity: '1 thìa cà phê',
        quantityEn: '1 tsp',
      ),
    ],
    steps: [
      RecipeStep(
        titleVi: 'Chuẩn bị khuôn',
        titleEn: 'Prepare the molds',
        durationMinutes: 3,
        instructionVi:
            'Rửa sạch và lau khô 6 khuôn chịu nhiệt dung tích khoảng 120 ml. Chuẩn bị nồi hấp, bọc nắp nồi bằng khăn sạch để nước không nhỏ xuống mặt bánh.',
        instructionEn:
            'Clean and dry six 120 ml heatproof molds. Prepare a steamer and wrap its lid with a clean towel to prevent condensation dripping onto the custard.',
      ),
      RecipeStep(
        titleVi: 'Nấu caramel',
        titleEn: 'Make caramel',
        durationMinutes: 8,
        instructionVi:
            'Cho đường và 20 ml nước vào nồi nhỏ, đun lửa vừa và không khuấy. Khi chuyển màu hổ phách, tắt bếp, thêm nước còn lại cùng chanh thật cẩn thận rồi rót mỏng vào từng khuôn.',
        instructionEn:
            'Heat sugar with 20 ml water over medium heat without stirring. At amber color, turn off heat and carefully add the remaining water and lemon juice. Pour a thin layer into each mold.',
      ),
      RecipeStep(
        titleVi: 'Làm ấm sữa',
        titleEn: 'Warm the milk',
        durationMinutes: 5,
        instructionVi:
            'Đun sữa tươi và sữa đặc ở lửa nhỏ đến khoảng 60°C, chỉ cần nóng và có hơi nhẹ, không để sôi. Thêm vani rồi khuấy tan.',
        instructionEn:
            'Warm milk and condensed milk over low heat to about 60°C, steaming but not boiling. Stir in vanilla.',
      ),
      RecipeStep(
        titleVi: 'Trộn hỗn hợp trứng',
        titleEn: 'Mix the custard',
        durationMinutes: 7,
        instructionVi:
            'Khuấy nhẹ trứng nguyên quả và lòng đỏ theo một chiều, tránh tạo bọt. Rót sữa ấm từ từ vào trứng trong khi khuấy liên tục để trứng không bị chín vón.',
        instructionEn:
            'Gently stir whole eggs and yolks in one direction without creating foam. Slowly stream in warm milk while stirring continuously to prevent curdling.',
      ),
      RecipeStep(
        titleVi: 'Lọc và rót khuôn',
        titleEn: 'Strain and fill',
        durationMinutes: 5,
        instructionVi:
            'Lọc hỗn hợp qua rây mịn hai lần. Hớt bọt trên mặt, rót vào khuôn và đậy từng khuôn bằng giấy bạc hoặc nắp chịu nhiệt.',
        instructionEn:
            'Strain the custard twice through a fine sieve. Remove surface bubbles, fill the molds and cover each with foil or a heatproof lid.',
      ),
      RecipeStep(
        titleVi: 'Hấp bánh',
        titleEn: 'Steam the flan',
        durationMinutes: 35,
        instructionVi:
            'Đặt khuôn vào nồi khi nước đã sôi nhẹ. Hấp lửa nhỏ 30–35 phút; mỗi 10 phút hé nắp vài giây. Bánh đạt khi tâm còn rung rất nhẹ nhưng không còn chất lỏng.',
        instructionEn:
            'Place molds in the steamer over a gentle simmer. Steam on low for 30–35 minutes, briefly venting every 10 minutes. The center should barely wobble with no liquid remaining.',
      ),
      RecipeStep(
        titleVi: 'Làm lạnh và lấy bánh',
        titleEn: 'Chill and unmold',
        durationMinutes: 180,
        instructionVi:
            'Để bánh nguội hoàn toàn rồi bảo quản lạnh ít nhất 3 giờ. Khi dùng, lách dao mỏng quanh thành khuôn, úp đĩa lên trên và lật nhanh.',
        instructionEn:
            'Cool completely, then refrigerate for at least 3 hours. To serve, run a thin knife around the edge, cover with a plate and invert quickly.',
      ),
    ],
    tipsVi: [
      'Không đánh bông trứng và không để sữa sôi; bọt khí làm bánh bị rỗ.',
      'Hấp ở lửa thật nhỏ, nước chỉ sôi lăn tăn để mặt bánh mịn.',
      'Rửa tay, dụng cụ và bề mặt kỹ sau khi tiếp xúc với trứng sống; nấu hỗn hợp trứng chín hoàn toàn.',
    ],
    tipsEn: [
      'Do not whip the eggs or boil the milk; trapped air creates holes in the custard.',
      'Keep the steamer at a very gentle simmer for a smooth surface.',
      'Wash hands, utensils and surfaces after raw egg contact, and cook the egg mixture thoroughly.',
    ],
);

