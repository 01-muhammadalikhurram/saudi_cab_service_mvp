import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../app/routes/app_routes.dart';
import '../../domain/entities/booking_entity.dart';

/// Confirmation screen displayed after a successful booking form submission.
///
/// Receives a [BookingEntity] via route arguments and presents a polished
/// summary of all booking details with a clear success state.
class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key, required this.booking});

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            children: [
              _SuccessBadge(),
              const SizedBox(height: AppSpacing.xl),
              _BookingSummaryCard(booking: booking),
              const SizedBox(height: AppSpacing.xl),
              _ActionButtons(context: context),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Success badge at the top ─────────────────────────────────────────────────

class _SuccessBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryDark, AppColors.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 48,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Booking Confirmed!',
          style: AppTypography.headingMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Your ride has been booked successfully.\nWe will contact you on WhatsApp shortly.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ── Booking details card ─────────────────────────────────────────────────────

class _BookingSummaryCard extends StatelessWidget {
  const _BookingSummaryCard({required this.booking});

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(booking.pickupDate);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusLg),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.receipt_long_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Booking Summary',
                  style: AppTypography.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.person_rounded,
                  label: 'Customer',
                  value: booking.customerName,
                ),
                _Divider(),
                _DetailRow(
                  icon: Icons.phone_rounded,
                  label: 'WhatsApp',
                  value: booking.whatsappNumber,
                ),
                _Divider(),
                _DetailRow(
                  icon: Icons.my_location_rounded,
                  label: 'Pickup',
                  value: '${booking.pickupCity}\n${booking.pickupLocation}',
                ),
                _Divider(),
                _DetailRow(
                  icon: Icons.location_on_rounded,
                  label: 'Destination',
                  value:
                      '${booking.destinationCity}\n${booking.destinationLocation}',
                ),
                _Divider(),
                _DetailRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Date',
                  value: formattedDate,
                ),
                _Divider(),
                _DetailRow(
                  icon: Icons.local_taxi_rounded,
                  label: 'Service',
                  value: booking.serviceType,
                ),
                _Divider(),
                _DetailRow(
                  icon: Icons.directions_car_rounded,
                  label: 'Vehicle',
                  value: booking.vehicleType,
                ),
                _Divider(),
                _DetailRow(
                  icon: Icons.group_rounded,
                  label: 'Passengers',
                  value: '${booking.passengers} passengers',
                ),
                if (booking.notes != null && booking.notes!.isNotEmpty) ...[
                  _Divider(),
                  _DetailRow(
                    icon: Icons.notes_rounded,
                    label: 'Notes',
                    value: booking.notes!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.divider, height: 1, thickness: 1);
  }
}

// ── Action buttons ───────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary: Book another ride
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bookingForm,
              (route) => false,
            ),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Book Another Ride'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              textStyle: AppTypography.labelMedium,
              shape: RoundedRectangleBorder(
                borderRadius: AppSpacing.borderRadiusMd,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
