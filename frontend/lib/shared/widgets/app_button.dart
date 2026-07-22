import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

/// Button variant enum — controls visual style of [AppButton].
enum AppButtonVariant { primary, secondary }

/// A reusable, design-token-driven button component.
///
/// Supports:
/// - [primary]: filled green — used for primary CTAs (e.g. "Book Ride")
/// - [secondary]: outlined green — used for secondary actions (e.g. "Back to Home")
/// - [isLoading]: shows a circular spinner in place of the label
/// - [isDisabled]: prevents interaction and applies a muted appearance
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final double width;
  final IconData? icon;

  bool get _isInteractable => !isLoading && !isDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 52.0,
      child: variant == AppButtonVariant.primary
          ? _buildPrimary()
          : _buildSecondary(),
    );
  }

  Widget _buildPrimary() {
    return ElevatedButton(
      onPressed: _isInteractable ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isInteractable ? AppColors.primary : AppColors.border,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
      child: _buildChild(AppColors.textOnPrimary),
    );
  }

  Widget _buildSecondary() {
    return OutlinedButton(
      onPressed: _isInteractable ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: _isInteractable ? AppColors.primary : AppColors.textMuted,
        side: BorderSide(
          color: _isInteractable ? AppColors.primary : AppColors.border,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
      child: _buildChild(
        _isInteractable ? AppColors.primary : AppColors.textMuted,
      ),
    );
  }

  Widget _buildChild(Color color) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.0),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppTypography.buttonLabel.copyWith(color: color)),
        ],
      );
    }

    return Text(label, style: AppTypography.buttonLabel.copyWith(color: color));
  }
}
