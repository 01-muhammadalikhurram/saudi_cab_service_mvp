import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

/// A reusable section header used to label and introduce each form section.
///
/// Displays an optional colored icon alongside a title and subtitle.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor = AppColors.primary,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.titleMedium),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(subtitle!, style: AppTypography.bodyMedium),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
