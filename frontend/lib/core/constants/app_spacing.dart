import 'package:flutter/material.dart';

/// Centralized layout metrics (spacing, padding, margin, border radii).
class AppSpacing {
  AppSpacing._();

  // Padding / Margin Metrics
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // EdgeInsets Helper Presets
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets paddingSymmetricHSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingSymmetricHMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingSymmetricHLg = EdgeInsets.symmetric(horizontal: lg);
  
  static const EdgeInsets paddingSymmetricVSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingSymmetricVMd = EdgeInsets.symmetric(vertical: md);

  // Border Radius Tokens
  static const double radiusSm = 6.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusCircular = 999.0;

  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderRadiusXl = BorderRadius.all(Radius.circular(radiusXl));
}
