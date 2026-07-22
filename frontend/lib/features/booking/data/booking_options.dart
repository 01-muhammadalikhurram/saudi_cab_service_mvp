import '../../../core/constants/saudi_locations.dart';

/// Static data provider for all booking form dropdowns.
///
/// All dropdown data is centralized here. When a backend is introduced,
/// only this file's data source changes — the UI layer remains untouched.
class BookingOptions {
  BookingOptions._();

  /// Saudi cities available for pickup and destination selection.
  static List<String> get cities => SaudiLocations.cities;

  /// Passenger count options.
  static const List<String> passengerCounts = [
    '1', '2', '3', '4', '5', '6', '7', '8+',
  ];

  /// Available taxi service types.
  static const List<String> serviceTypes = [
    'Airport Transport',
    'City Transport',
    'Holiday Tour',
    'Business Tour',
    'Shuttle Service',
    'Regular Transport',
  ];

  /// Maps each service type to its eligible vehicle options.
  ///
  /// This dependency is intentionally hardcoded for MVP.
  /// The backend will provide this mapping dynamically in a future phase.
  static const Map<String, List<String>> _vehiclesByService = {
    'Airport Transport': ['Sedan', 'SUV', 'Van', 'Bus'],
    'City Transport':    ['Sedan', 'SUV', 'Hatchback'],
    'Holiday Tour':      ['SUV', 'Van', 'Bus'],
    'Business Tour':     ['Luxury Sedan', 'SUV'],
    'Shuttle Service':   ['Van', 'Bus'],
    'Regular Transport': ['Sedan', 'SUV', 'Hatchback', 'Van'],
  };

  /// Returns the list of vehicles available for the given [serviceType].
  /// Returns an empty list if [serviceType] is null or unrecognized.
  static List<String> getVehicles(String? serviceType) {
    if (serviceType == null) return [];
    return _vehiclesByService[serviceType] ?? [];
  }
}
