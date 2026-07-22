/// Static UI strings enabling seamless internationalization (l10n/i18n) support in future releases.
class AppStrings {
  AppStrings._();

  static const String appTitle = 'Saudi Umrah Cab Service';

  // Section Headers
  static const String customerInfoTitle = 'Customer Information';
  static const String customerInfoSubtitle = 'Please enter your contact details';

  static const String pickupTitle = 'Pickup Details';
  static const String destinationTitle = 'Destination Details';
  static const String tripTitle = 'Trip Preferences';

  // Form Fields
  static const String fullNameLabel = 'Full Name';
  static const String fullNameHint = 'Enter your full name';

  static const String whatsappLabel = 'WhatsApp Number';
  static const String whatsappHint = 'e.g. +966 50 123 4567';

  static const String pickupCityLabel = 'Pickup City';
  static const String pickupCityHint = 'Select pickup city';

  static const String pickupLocationLabel = 'Pickup Address / Landmark';
  static const String pickupLocationHint = 'Hotel name, airport gate, or street name';

  static const String destinationCityLabel = 'Destination City';
  static const String destinationCityHint = 'Select destination city';

  static const String destinationLocationLabel = 'Destination Address / Landmark';
  static const String destinationLocationHint = 'Hotel name, airport gate, or street name';

  static const String passengersLabel = 'Number of Passengers';
  static const String passengersHint = 'Select passengers count';

  static const String serviceTypeLabel = 'Taxi Service Type';
  static const String serviceTypeHint = 'Select transportation service';

  static const String vehicleTypeLabel = 'Vehicle Type';
  static const String vehicleTypeHint = 'Select preferred vehicle';

  static const String pickupDateLabel = 'Pickup Date';
  static const String pickupDateHint = 'Select pickup date';

  static const String notesLabel = 'Special Requests / Notes';
  static const String notesHint = 'Extra luggage, child seat, specific meet point (Optional)';

  // Action Buttons
  static const String bookRideButton = 'Book Ride';
  static const String backToHomeButton = 'Back to Home';

  // Confirmation Screen
  static const String bookingSubmittedTitle = 'Booking Submitted Successfully!';
  static const String bookingSubmittedSubtitle = 'Your request has been received. Our team will contact you shortly via WhatsApp.';

  // Validation Error Messages
  static const String errRequiredField = 'This field is required';
  static const String errInvalidPhone = 'Please enter a valid phone number';
}
