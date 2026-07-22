import 'package:flutter/material.dart';

/// Centralized route name definitions.
class AppRoutes {
  AppRoutes._();

  static const String bookingForm = '/';
  static const String bookingConfirmation = '/confirmation';
}

/// Centralized route generator.
class AppPages {
  AppPages._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.bookingForm:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Booking Form Screen Scaffolding'),
            ),
          ),
        );
      case AppRoutes.bookingConfirmation:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Booking Confirmation Screen Scaffolding'),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
