import 'package:flutter/material.dart';

class RecipeCategoryChip extends StatelessWidget {
  const RecipeCategoryChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      onSelected: onSelected,
      avatar: Icon(icon, size: 18),
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      showCheckmark: false,
    );
  }
}
