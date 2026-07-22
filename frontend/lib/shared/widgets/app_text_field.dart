import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_typography.dart';

/// A reusable, design-token-driven text input component.
///
/// Wraps [TextFormField] with consistent styling from [AppTheme].
/// Supports single-line and multiline modes, icons, and form validation.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.isMultiline = false,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.words,
    this.autofocus = false,
    this.focusNode,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final bool isMultiline;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final effectiveMaxLines = isMultiline ? (maxLines ?? 3) : 1;
    final effectiveKeyboardType = keyboardType ??
        (isMultiline ? TextInputType.multiline : TextInputType.text);

    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      maxLines: effectiveMaxLines,
      minLines: isMultiline ? 2 : 1,
      maxLength: maxLength,
      keyboardType: effectiveKeyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      focusNode: focusNode,
      style: AppTypography.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        alignLabelWithHint: isMultiline,
        counterText: '',
      ),
    );
  }
}
