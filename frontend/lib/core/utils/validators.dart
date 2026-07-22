/// Centralized validation functions.
///
/// All methods return null on success (valid), or an error string on failure.
/// These are pure functions — no Flutter widget dependencies.
class AppValidators {
  AppValidators._();

  /// Validates that a field is not empty or null.
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates that a date has been selected and is not in the past.
  static String? date(DateTime? value) {
    if (value == null) {
      return 'Please select a pickup date';
    }
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);
    if (value.isBefore(todayDateOnly)) {
      return 'Pickup date cannot be in the past';
    }
    return null;
  }

  /// Validates a generic dropdown selection is not null.
  static String? dropdown<T>(T? value, {String fieldName = 'This field'}) {
    if (value == null) {
      return '$fieldName is required';
    }
    return null;
  }
}
