import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

/// A styled date selection widget that matches the app's form field design.
///
/// - Tapping opens the system [showDatePicker] dialog.
/// - Past dates are disabled (only today and future dates are selectable).
/// - Exposes [onDateSelected] to notify the parent of the chosen date.
/// - Exposes [validator] for form validation integration.
class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.hint = 'Select pickup date',
    this.initialDate,
    this.validator,
    this.prefixIcon = Icons.calendar_today_outlined,
  });

  final String label;
  final String hint;
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;
  final String? Function(DateTime?)? validator;
  final IconData prefixIcon;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime? _selectedDate;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _openDatePicker() async {
    final today = DateTime.now();
    final firstAllowedDate = DateTime(today.year, today.month, today.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? firstAllowedDate,
      firstDate: firstAllowedDate,
      lastDate: DateTime(today.year + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textOnPrimary,
              surface: AppColors.surface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _errorText = widget.validator?.call(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  /// Validates the field programmatically (called by parent Form on save/submit).
  String? validate() {
    final error = widget.validator?.call(_selectedDate);
    setState(() => _errorText = error);
    return error;
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _selectedDate != null;
    final displayText = hasValue
        ? DateFormat('EEEE, d MMMM yyyy').format(_selectedDate!)
        : null;

    return GestureDetector(
      onTap: _openDatePicker,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: hasValue ? AppColors.primary : AppColors.textMuted,
          ),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textMuted,
          ),
          errorText: _errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: BorderSide(
              color: _errorText != null ? AppColors.error : AppColors.border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.error, width: 2.0),
          ),
          filled: true,
          fillColor: AppColors.surface,
        ),
        isEmpty: !hasValue,
        child: Text(
          displayText ?? '',
          style: hasValue
              ? AppTypography.bodyLarge
              : AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
