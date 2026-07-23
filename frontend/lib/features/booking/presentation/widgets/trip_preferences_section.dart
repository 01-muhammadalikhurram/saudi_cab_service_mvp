import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_date_picker.dart';
import '../../../../shared/widgets/app_dropdown.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../data/booking_options.dart';

/// Form section widget for collecting trip-related preferences.
///
/// The vehicle type dropdown items are dynamically filtered based on the
/// selected service type. A [ValueKey] on the vehicle dropdown forces a
/// widget recreation (and a reset to null) whenever the service type changes.
class TripPreferencesSection extends StatelessWidget {
  const TripPreferencesSection({
    super.key,
    required this.selectedPassengers,
    required this.onPassengersChanged,
    required this.selectedServiceType,
    required this.onServiceTypeChanged,
    required this.selectedVehicleType,
    required this.onVehicleTypeChanged,
    required this.selectedDate,
    required this.onDateSelected,
    required this.notesController,
  });

  final String? selectedPassengers;
  final ValueChanged<String?> onPassengersChanged;

  final String? selectedServiceType;
  final ValueChanged<String?> onServiceTypeChanged;

  final String? selectedVehicleType;
  final ValueChanged<String?> onVehicleTypeChanged;

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    final availableVehicles = BookingOptions.getVehicles(selectedServiceType);

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: AppStrings.tripTitle,
            icon: Icons.tune_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Passengers
          AppDropdown<String>(
            label: AppStrings.passengersLabel,
            hint: AppStrings.passengersHint,
            value: selectedPassengers,
            prefixIcon: Icons.group_outlined,
            items: BookingOptions.passengerCounts
                .map((p) => DropdownMenuItem(value: p, child: Text('$p passengers')))
                .toList(),
            onChanged: onPassengersChanged,
            validator: (v) => AppValidators.dropdown<String>(
              v,
              fieldName: 'Number of passengers',
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Service Type
          AppDropdown<String>(
            label: AppStrings.serviceTypeLabel,
            hint: AppStrings.serviceTypeHint,
            value: selectedServiceType,
            prefixIcon: Icons.local_taxi_outlined,
            items: BookingOptions.serviceTypes
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: onServiceTypeChanged,
            validator: (v) => AppValidators.dropdown<String>(
              v,
              fieldName: 'Service type',
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Vehicle Type — uses ValueKey to reset when service type changes
          AppDropdown<String>(
            key: ValueKey(selectedServiceType),
            label: AppStrings.vehicleTypeLabel,
            hint: availableVehicles.isEmpty
                ? 'Select a service type first'
                : AppStrings.vehicleTypeHint,
            value: selectedVehicleType,
            prefixIcon: Icons.directions_car_outlined,
            items: availableVehicles
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: availableVehicles.isEmpty
                ? (String? _) {}
                : onVehicleTypeChanged,
            validator: (v) => AppValidators.dropdown<String>(
              v,
              fieldName: 'Vehicle type',
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Pickup Date
          AppDatePicker(
            label: AppStrings.pickupDateLabel,
            hint: AppStrings.pickupDateHint,
            initialDate: selectedDate,
            onDateSelected: onDateSelected,
            validator: AppValidators.date,
          ),
          const SizedBox(height: AppSpacing.md),

          // Notes (optional)
          AppTextField(
            label: AppStrings.notesLabel,
            hint: AppStrings.notesHint,
            controller: notesController,
            prefixIcon: Icons.notes_rounded,
            isMultiline: true,
            maxLines: 4,
            maxLength: 300,
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }
}
