import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_phone_field.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../core/utils/validators.dart';

/// Form section widget for collecting customer contact information.
///
/// Receives controllers from the parent [BookingFormScreen] to keep
/// all form state centralized at the screen level.
class CustomerInfoSection extends StatelessWidget {
  const CustomerInfoSection({
    super.key,
    required this.nameController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final PhoneController phoneController;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: AppStrings.customerInfoTitle,
            subtitle: AppStrings.customerInfoSubtitle,
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: AppStrings.fullNameLabel,
            hint: AppStrings.fullNameHint,
            controller: nameController,
            prefixIcon: Icons.badge_outlined,
            textCapitalization: TextCapitalization.words,
            validator: (value) => AppValidators.required(
              value,
              fieldName: 'Full name',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPhoneField(
            label: AppStrings.whatsappLabel,
            controller: phoneController,
          ),
        ],
      ),
    );
  }
}
