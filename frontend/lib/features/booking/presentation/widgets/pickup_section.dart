import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_dropdown.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../data/booking_options.dart';

/// Form section widget for collecting pickup city and address.
class PickupSection extends StatelessWidget {
  const PickupSection({
    super.key,
    required this.selectedCity,
    required this.onCityChanged,
    required this.locationController,
  });

  final String? selectedCity;
  final ValueChanged<String?> onCityChanged;
  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: AppStrings.pickupTitle,
            icon: Icons.my_location_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppDropdown<String>(
            label: AppStrings.pickupCityLabel,
            hint: AppStrings.pickupCityHint,
            value: selectedCity,
            prefixIcon: Icons.location_city_outlined,
            items: BookingOptions.cities
                .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                .toList(),
            onChanged: onCityChanged,
            validator: (v) => AppValidators.dropdown<String>(
              v,
              fieldName: 'Pickup city',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: AppStrings.pickupLocationLabel,
            hint: AppStrings.pickupLocationHint,
            controller: locationController,
            prefixIcon: Icons.place_outlined,
            isMultiline: true,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) => AppValidators.required(
              value,
              fieldName: 'Pickup location',
            ),
          ),
        ],
      ),
    );
  }
}
