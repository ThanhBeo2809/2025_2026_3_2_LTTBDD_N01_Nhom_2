import 'dart:async';

import 'package:flutter/material.dart';

import '../controllers/recipe_controller.dart';
import '../l10n/app_strings.dart';
import '../models/recipe.dart';

class CookingModeScreen extends StatefulWidget {
  const CookingModeScreen({required this.recipeId, super.key});

  final String recipeId;

  @override
  State<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {
  Timer? _timer;
  int _currentStep = 0;
  int _secondsRemaining = 0;
  bool _isRunning = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_secondsRemaining != 0) return;
    final recipe = RecipeScope.of(context).recipeById(widget.recipeId);
    if (recipe != null && recipe.steps.isNotEmpty) {
      _secondsRemaining = recipe.steps.first.durationMinutes * 60;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final controller = RecipeScope.of(context);
    final recipe = controller.recipeById(widget.recipeId);
    if (recipe == null || recipe.steps.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(strings.noResults)),
      );
    }

    final step = recipe.steps[_currentStep];
    final progress = (_currentStep + 1) / recipe.steps.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.cookingMode),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_currentStep + 1}/${recipe.steps.length}',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                children: [
                  LinearProgressIndicator(value: progress, minHeight: 9),
                  const SizedBox(height: 24),
                  Text(
                    '${recipe.emoji} ${recipe.localizedTitle(strings.isVietnamese)}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Card(
                        key: ValueKey(_currentStep),
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  child: Text(
                                    '${_currentStep + 1}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  _stepTitle(step, strings),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  step.localizedInstruction(
                                    strings.isVietnamese,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(height: 1.6),
                                ),
                                if (step.durationMinutes > 0) ...[
                                  const SizedBox(height: 28),
                                  _TimerPanel(
                                    seconds: _secondsRemaining,
                                    isRunning: _isRunning,
                                    onToggle: _toggleTimer,
                                    onReset: () => _resetTimer(step),
                                    strings: strings,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: _currentStep == 0
                            ? null
                            : () => _moveToStep(recipe, _currentStep - 1),
                        icon: const Icon(Icons.arrow_back),
                        label: Text(strings.previousStep),
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: () => _nextStep(controller, recipe),
                        icon: Icon(
                          _currentStep == recipe.steps.length - 1
                              ? Icons.check_circle_outline
                              : Icons.arrow_forward,
                        ),
                        label: Text(
                          _currentStep == recipe.steps.length - 1
                              ? strings.finishCooking
                              : strings.nextStep,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _stepTitle(RecipeStep step, AppStrings strings) {
    final title = step.localizedTitle(strings.isVietnamese);
    return title.isEmpty ? '${strings.step} ${_currentStep + 1}' : title;
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
      return;
    }
    if (_secondsRemaining <= 0) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _secondsRemaining--;
        if (_secondsRemaining <= 0) {
          _secondsRemaining = 0;
          _isRunning = false;
          timer.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppStrings.of(context).timerFinished)),
          );
        }
      });
    });
  }

  void _resetTimer(RecipeStep step) {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _secondsRemaining = step.durationMinutes * 60;
    });
  }

  void _moveToStep(Recipe recipe, int stepIndex) {
    _timer?.cancel();
    setState(() {
      _currentStep = stepIndex;
      _isRunning = false;
      _secondsRemaining = recipe.steps[stepIndex].durationMinutes * 60;
    });
  }

  void _nextStep(RecipeController controller, Recipe recipe) {
    if (_currentStep < recipe.steps.length - 1) {
      _moveToStep(recipe, _currentStep + 1);
      return;
    }
    _timer?.cancel();
    controller.markCooked(recipe.id);
    showDialog<void>(
      context: context,
      builder: (context) {
        final strings = AppStrings.of(context);
        return AlertDialog(
          icon: const Icon(Icons.celebration, size: 44),
          title: Text(strings.cookingCompleted),
          content: Text(strings.enjoyMeal),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(this.context);
              },
              child: Text(strings.done),
            ),
          ],
        );
      },
    );
  }
}

class _TimerPanel extends StatelessWidget {
  const _TimerPanel({
    required this.seconds,
    required this.isRunning,
    required this.onToggle,
    required this.onReset,
    required this.strings,
  });

  final int seconds;
  final bool isRunning;
  final VoidCallback onToggle;
  final VoidCallback onReset;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            '$minutes:${remainingSeconds.toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.tonalIcon(
                onPressed: onToggle,
                icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                label: Text(isRunning ? strings.pause : strings.startTimer),
              ),
              const SizedBox(width: 10),
              IconButton.outlined(
                tooltip: strings.resetTimer,
                onPressed: onReset,
                icon: const Icon(Icons.restart_alt),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
