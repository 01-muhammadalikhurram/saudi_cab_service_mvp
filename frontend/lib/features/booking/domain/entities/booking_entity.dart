/// Immutable data object representing a confirmed booking.
///
/// Created after successful form validation in [BookingFormScreen]
/// and passed to [BookingConfirmationScreen] for display.
class BookingEntity {
  const BookingEntity({
    required this.customerName,
    required this.whatsappNumber,
    required this.pickupCity,
    required this.pickupLocation,
    required this.destinationCity,
    required this.destinationLocation,
    required this.passengers,
    required this.serviceType,
    required this.vehicleType,
    required this.pickupDate,
    this.notes,
  });

  final String customerName;
  final String whatsappNumber; // E.164 format e.g. +966501234567
  final String pickupCity;
  final String pickupLocation;
  final String destinationCity;
  final String destinationLocation;
  final String passengers;
  final String serviceType;
  final String vehicleType;
  final DateTime pickupDate;
  final String? notes;
}
