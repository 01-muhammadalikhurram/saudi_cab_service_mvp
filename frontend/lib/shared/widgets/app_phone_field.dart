import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

/// A reusable phone number input widget with integrated country code picker.
///
/// Wraps [PhoneFormField] from the `phone_form_field` package with
/// app-consistent styling. Validation is handled per-country using the
/// ITU/libphonenumber standard — the correct format is enforced based on
/// the selected country (e.g. Pakistani numbers validate differently from
/// Saudi or US numbers).
///
/// The widget exposes a [controller] for reading the full international
/// number (E.164 format: e.g. +966501234567) from a parent form.
///
/// Example:
/// ```dart
/// AppPhoneField(
///   label: 'WhatsApp Number',
///   controller: _phoneController,
/// )
/// ```
class AppPhoneField extends StatelessWidget {
  const AppPhoneField({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.initialCountryCode = IsoCode.SA,
  });

  final String label;
  final PhoneController? controller;
  final ValueChanged<PhoneNumber?>? onChanged;
  final IsoCode initialCountryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelMedium),
        const SizedBox(height: AppSpacing.xs),
        PhoneFormField(
          controller: controller,
          onChanged: onChanged,
          initialValue: PhoneNumber.parse('', callerCountry: initialCountryCode),
          countrySelectorNavigator: CountrySelectorNavigator.bottomSheet(
            searchBoxDecoration: InputDecoration(
              hintText: 'Search country...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: AppSpacing.borderRadiusMd,
              ),
            ),
            favorites: const [
              IsoCode.SA,
              IsoCode.PK,
              IsoCode.IN,
              IsoCode.BD,
              IsoCode.EG,
              IsoCode.ID,
              IsoCode.MY,
              IsoCode.TR,
              IsoCode.GB,
              IsoCode.US,
            ],
          ),
          validator: PhoneValidator.compose([
            PhoneValidator.required(
              context,
              errorText: 'WhatsApp number is required',
            ),
            PhoneValidator.validMobile(
              context,
              errorText: 'Please enter a valid mobile number',
            ),
          ]),
          isCountryButtonPersistent: true,
          countryButtonStyle: const CountryButtonStyle(
            showFlag: true,
            showDialCode: true,
            showIsoCode: false,
            flagSize: 20,
          ),
          keyboardType: TextInputType.phone,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Enter phone number',
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
            filled: true,
            fillColor: AppColors.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(color: AppColors.error, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
