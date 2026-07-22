import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import 'routes/app_routes.dart';

/// Root application widget configuring global MaterialApp parameters.
class SaudiCabApp extends StatelessWidget {
  const SaudiCabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.bookingForm,
      onGenerateRoute: AppPages.generateRoute,
    );
  }
}
