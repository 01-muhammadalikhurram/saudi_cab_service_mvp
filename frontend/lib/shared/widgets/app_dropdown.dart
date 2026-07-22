import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

/// A reusable, generic typed dropdown component.
///
/// Wraps [DropdownButtonFormField] with consistent styling.
/// Generic type [T] allows use with String, enums, or any model.
///
/// Example:
/// ```dart
/// AppDropdown<String>(
///   label: 'Pickup City',
///   hint: 'Select a city',
///   value: selectedCity,
///   items: cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
///   onChanged: (city) => setState(() => selectedCity = city),
///   validator: (v) => AppValidators.dropdown(v, fieldName: 'Pickup City'),
/// )
/// ```
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.hint,
    this.value,
    this.validator,
    this.prefixIcon,
  });

  final String label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      validator: validator,
      onChanged: onChanged,
      style: AppTypography.bodyLarge,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textMuted),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      dropdownColor: AppColors.surface,
      borderRadius: AppSpacing.borderRadiusMd,
      isExpanded: true,
      items: items,
    );
  }
}
