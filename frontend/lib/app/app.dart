import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phone_form_field/phone_form_field.dart';
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
      // Required for phone_form_field country selector localization
      localizationsDelegates: [
        ...PhoneFieldLocalization.delegates,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: const [Locale('en')],
    );
  }
}

