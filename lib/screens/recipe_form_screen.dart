import 'package:flutter/material.dart';

import '../controllers/recipe_controller.dart';
import '../l10n/app_strings.dart';
import '../models/recipe.dart';
import '../utils/recipe_labels.dart';

class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({this.recipeId, super.key});

  final String? recipeId;

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleVi;
  late final TextEditingController _titleEn;
  late final TextEditingController _descriptionVi;
  late final TextEditingController _descriptionEn;
  late final TextEditingController _ingredients;
  late final TextEditingController _steps;
  RecipeCategory _category = RecipeCategory.vietnamese;
  RecipeDifficulty _difficulty = RecipeDifficulty.easy;
  double _preparationMinutes = 15;
  double _cookingMinutes = 20;
  double _servings = 2;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _titleVi = TextEditingController();
    _titleEn = TextEditingController();
    _descriptionVi = TextEditingController();
    _descriptionEn = TextEditingController();
    _ingredients = TextEditingController();
    _steps = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized || widget.recipeId == null) return;
    final recipe = RecipeScope.of(context).recipeById(widget.recipeId!);
    if (recipe != null) {
      _titleVi.text = recipe.titleVi;
      _titleEn.text = recipe.titleEn;
      _descriptionVi.text = recipe.descriptionVi;
      _descriptionEn.text = recipe.descriptionEn;
      _ingredients.text = recipe.ingredients
          .map(
            (item) => [
              item.nameVi,
              item.nameEn,
              item.quantity,
              item.quantityEn ?? item.quantity,
            ].join(' | '),
          )
          .join('\n');
      _steps.text = recipe.steps
          .map((item) => '${item.instructionVi} | ${item.instructionEn}')
          .join('\n');
      _category = recipe.category;
      _difficulty = recipe.difficulty;
      _preparationMinutes = recipe.preparationMinutes.toDouble();
      _cookingMinutes = recipe.cookingMinutes.toDouble();
      _servings = recipe.servings.toDouble();
    }
    _initialized = true;
  }

  @override
  void dispose() {
    _titleVi.dispose();
    _titleEn.dispose();
    _descriptionVi.dispose();
    _descriptionEn.dispose();
    _ingredients.dispose();
    _steps.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final isEditing = widget.recipeId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? strings.editRecipe : strings.addRecipe),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionCard(
                      title: strings.text(
                        'Thông tin cơ bản',
                        'Basic information',
                      ),
                      icon: Icons.edit_note,
                      child: Column(
                        children: [
                          _Field(
                            controller: _titleVi,
                            label: '${strings.recipeName} (VI)',
                            validator: _required,
                          ),
                          const SizedBox(height: 14),
                          _Field(
                            controller: _titleEn,
                            label: '${strings.recipeName} (EN)',
                            validator: _required,
                          ),
                          const SizedBox(height: 14),
                          _Field(
                            controller: _descriptionVi,
                            label: '${strings.description} (VI)',
                            maxLines: 3,
                            validator: _required,
                          ),
                          const SizedBox(height: 14),
                          _Field(
                            controller: _descriptionEn,
                            label: '${strings.description} (EN)',
                            maxLines: 3,
                            validator: _required,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionCard(
                      title: strings.text(
                        'Phân loại và thời gian',
                        'Category and time',
                      ),
                      icon: Icons.tune,
                      child: Column(
                        children: [
                          DropdownButtonFormField<RecipeCategory>(
                            initialValue: _category,
                            decoration: InputDecoration(
                              labelText: strings.categories,
                            ),
                            items: [
                              for (final category in RecipeCategory.values)
                                DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    RecipeLabels.category(strings, category),
                                  ),
                                ),
                            ],
                            onChanged: (value) =>
                                setState(() => _category = value!),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(strings.difficulty),
                          ),
                          const SizedBox(height: 8),
                          SegmentedButton<RecipeDifficulty>(
                            segments: [
                              for (final difficulty in RecipeDifficulty.values)
                                ButtonSegment(
                                  value: difficulty,
                                  label: Text(
                                    RecipeLabels.difficulty(
                                      strings,
                                      difficulty,
                                    ),
                                  ),
                                ),
                            ],
                            selected: {_difficulty},
                            onSelectionChanged: (value) =>
                                setState(() => _difficulty = value.first),
                          ),
                          const SizedBox(height: 20),
                          _ValueSlider(
                            label: strings.preparation,
                            value: _preparationMinutes,
                            min: 5,
                            max: 120,
                            suffix: strings.minutes,
                            onChanged: (value) =>
                                setState(() => _preparationMinutes = value),
                          ),
                          _ValueSlider(
                            label: strings.cooking,
                            value: _cookingMinutes,
                            min: 5,
                            max: 180,
                            suffix: strings.minutes,
                            onChanged: (value) =>
                                setState(() => _cookingMinutes = value),
                          ),
                          _ValueSlider(
                            label: strings.servings,
                            value: _servings,
                            min: 1,
                            max: 12,
                            suffix: '',
                            onChanged: (value) =>
                                setState(() => _servings = value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionCard(
                      title: strings.ingredients,
                      icon: Icons.shopping_basket_outlined,
                      child: _Field(
                        controller: _ingredients,
                        label: strings.text(
                          'Mỗi dòng: Tên VI | Tên EN | Định lượng VI | Định lượng EN',
                          'Each line: Vietnamese name | English name | Vietnamese quantity | English quantity',
                        ),
                        hint: strings.text(
                          'Ví dụ: Trứng gà | Eggs | 2 quả | 2 eggs',
                          'Example: Trứng gà | Eggs | 2 quả | 2 eggs',
                        ),
                        maxLines: 6,
                        validator: _required,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionCard(
                      title: strings.directions,
                      icon: Icons.format_list_numbered,
                      child: _Field(
                        controller: _steps,
                        label: strings.text(
                          'Mỗi dòng: Hướng dẫn VI | Hướng dẫn EN',
                          'Each line: Vietnamese instruction | English instruction',
                        ),
                        hint: strings.text(
                          'Ví dụ: Chuẩn bị nguyên liệu | Prepare the ingredients',
                          'Example: Chuẩn bị nguyên liệu | Prepare the ingredients',
                        ),
                        maxLines: 7,
                        validator: _required,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _saveRecipe,
                        icon: const Icon(Icons.save_outlined),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(strings.save),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.of(context).requiredField;
    }
    return null;
  }

  void _saveRecipe() {
    if (!_formKey.currentState!.validate()) return;
    final controller = RecipeScope.of(context);
    final existing = widget.recipeId == null
        ? null
        : controller.recipeById(widget.recipeId!);
    final recipe = Recipe(
      id: existing?.id ?? 'user-${DateTime.now().microsecondsSinceEpoch}',
      titleVi: _titleVi.text.trim(),
      titleEn: _titleEn.text.trim(),
      descriptionVi: _descriptionVi.text.trim(),
      descriptionEn: _descriptionEn.text.trim(),
      category: _category,
      difficulty: _difficulty,
      preparationMinutes: _preparationMinutes.round(),
      cookingMinutes: _cookingMinutes.round(),
      servings: _servings.round(),
      emoji: existing?.emoji ?? '🍲',
      colorValue: existing?.colorValue ?? 0xFFE85D3F,
      ingredients: _parseIngredients(),
      steps: _parseSteps(),
      tipsVi: existing?.tipsVi ?? const [],
      tipsEn: existing?.tipsEn ?? const [],
      isFavorite: existing?.isFavorite ?? false,
      isUserCreated: true,
    );
    if (existing == null) {
      controller.addRecipe(recipe);
    } else {
      controller.updateRecipe(recipe);
    }
    Navigator.of(context).pop();
  }

  List<RecipeIngredient> _parseIngredients() {
    return _ingredients.text
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) {
          final parts = line.split('|').map((part) => part.trim()).toList();
          return RecipeIngredient(
            nameVi: parts.first,
            nameEn: parts.length > 1 ? parts[1] : parts.first,
            quantity: parts.length > 2 ? parts[2] : '',
            quantityEn: parts.length > 3 && parts[3].isNotEmpty
                ? parts[3]
                : (parts.length > 2 ? parts[2] : ''),
          );
        })
        .toList();
  }

  List<RecipeStep> _parseSteps() {
    return _steps.text.split('\n').where((line) => line.trim().isNotEmpty).map((
      line,
    ) {
      final parts = line.split('|').map((part) => part.trim()).toList();
      return RecipeStep(
        instructionVi: parts.first,
        instructionEn: parts.length > 1 ? parts[1] : parts.first,
      );
    }).toList();
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.hint,
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final int maxLines;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}

class _ValueSlider extends StatelessWidget {
  const _ValueSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.suffix,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final String suffix;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) / (max > 20 ? 5 : 1)).round(),
            label: '${value.round()} $suffix',
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 72,
          child: Text(
            '${value.round()} $suffix',
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
