import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

/// A styled date selection widget that integrates with Flutter's [Form]
/// validation system via [FormField].
///
/// - Tapping opens the system [showDatePicker] dialog.
/// - Past dates are disabled (only today and future dates are selectable).
/// - Registered as a [FormField] so [Form.validate()] automatically triggers it.
class AppDatePicker extends FormField<DateTime> {
  AppDatePicker({
    super.key,
    required String label,
    required ValueChanged<DateTime> onDateSelected,
    String hint = 'Select pickup date',
    DateTime? initialDate,
    super.validator,
    IconData prefixIcon = Icons.calendar_today_outlined,
  }) : super(
          initialValue: initialDate,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (FormFieldState<DateTime> state) {
            return _AppDatePickerContent(
              label: label,
              hint: hint,
              prefixIcon: prefixIcon,
              state: state,
              onDateSelected: onDateSelected,
            );
          },
        );
}

/// Internal stateful widget that handles the tap and dialog interaction.
class _AppDatePickerContent extends StatefulWidget {
  const _AppDatePickerContent({
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.state,
    required this.onDateSelected,
  });

  final String label;
  final String hint;
  final IconData prefixIcon;
  final FormFieldState<DateTime> state;
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<_AppDatePickerContent> createState() => _AppDatePickerContentState();
}

class _AppDatePickerContentState extends State<_AppDatePickerContent> {
  Future<void> _openDatePicker() async {
    final today = DateTime.now();
    final firstAllowedDate = DateTime(today.year, today.month, today.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: widget.state.value ?? firstAllowedDate,
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
      widget.state.didChange(picked);
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = widget.state.value;
    final hasValue = selectedDate != null;
    final displayText = hasValue
        ? DateFormat('EEEE, d MMMM yyyy').format(selectedDate)
        : null;
    final errorText = widget.state.errorText;

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
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: BorderSide(
              color: errorText != null ? AppColors.error : AppColors.border,
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
