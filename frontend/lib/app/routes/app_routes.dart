import 'package:flutter/material.dart';
import '../../features/booking/domain/entities/booking_entity.dart';
import '../../features/booking/presentation/screens/booking_confirmation_screen.dart';
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
        final booking = settings.arguments as BookingEntity;
        return MaterialPageRoute(
          builder: (_) => BookingConfirmationScreen(booking: booking),
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
