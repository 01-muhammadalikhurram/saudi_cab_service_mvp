import 'package:flutter/material.dart';
import '../../features/booking/presentation/screens/booking_form_screen.dart';

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
          builder: (_) => const BookingFormScreen(),
        );
      case AppRoutes.bookingConfirmation:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Booking Confirmation — Phase 4'),
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

