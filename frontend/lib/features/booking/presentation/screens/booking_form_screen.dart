import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/booking_entity.dart';
import '../../../../core/services/whatsapp_service.dart';
import '../../data/repositories/firestore_booking_repository.dart';
import '../../domain/repositories/booking_repository.dart';
import '../widgets/customer_info_section.dart';
import '../widgets/destination_section.dart';
import '../widgets/pickup_section.dart';
import '../widgets/trip_preferences_section.dart';

/// The primary booking form screen.
///
/// Holds all form field state using [setState] at the screen level.
/// Each section widget receives values and callbacks — keeping the UI
/// layer clean and ready for state management integration in a future phase.
class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // ── Customer info ───────────────────────────────────────────────────────────
  final _nameController = TextEditingController();
  final _phoneController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.SA, nsn: ''),
  );

  // ── Pickup ──────────────────────────────────────────────────────────────────
  String? _pickupCity;
  final _pickupLocationController = TextEditingController();

  // ── Destination ─────────────────────────────────────────────────────────────
  String? _destinationCity;
  final _destinationLocationController = TextEditingController();

  // ── Trip preferences ────────────────────────────────────────────────────────
  String? _passengers;
  String? _serviceType;
  String? _vehicleType;
  DateTime? _pickupDate;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pickupLocationController.dispose();
    _destinationLocationController.dispose();
    _notesController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool _isSubmitting = false;
  final BookingRepository _bookingRepository = FirestoreBookingRepository();

  Future<void> _onBookRidePressed() async {
    if (_isSubmitting) return;

    final isFormValid = _formKey.currentState?.validate() ?? false;
    final phone = _phoneController.value;
    final isPhoneValid = phone.nsn.isNotEmpty;

    if (!isFormValid || !isPhoneValid) {
      if (!isPhoneValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please enter a valid WhatsApp number.'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
        );
      }
      return;
    }

    setState(() => _isSubmitting = true);

    final booking = BookingEntity(
      customerName: _nameController.text.trim(),
      whatsappNumber: phone.international,
      pickupCity: _pickupCity!,
      pickupLocation: _pickupLocationController.text.trim(),
      destinationCity: _destinationCity!,
      destinationLocation: _destinationLocationController.text.trim(),
      passengers: _passengers!,
      serviceType: _serviceType!,
      vehicleType: _vehicleType!,
      pickupDate: _pickupDate!,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    String? bookingId;
    try {
      // 1. Save to Firebase Firestore
      bookingId = await _bookingRepository.createBooking(booking);
    } catch (e) {
      debugPrint('Firestore write note/fallback: $e');
    }

    // 2. Launch WhatsApp Chat directly to owner number (+923162624882)
    try {
      await WhatsAppService.launchWhatsAppBooking(
        booking: booking,
        bookingId: bookingId,
      );
    } catch (e) {
      debugPrint('WhatsApp launcher fallback: $e');
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    // 3. Navigate to Confirmation Screen
    Navigator.of(context).pushNamed(
      AppRoutes.bookingConfirmation,
      arguments: booking,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeroBanner(context),
          Expanded(
            child: Form(
              key: _formKey,
              // SingleChildScrollView + Column keeps ALL FormFields mounted
              // at all times — unlike ListView which recycles/destroys
              // off-screen widgets and wipes their validation error state.
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.xxl,
                ),
                child: Column(
                  children: [
                    CustomerInfoSection(
                      nameController: _nameController,
                      phoneController: _phoneController,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    PickupSection(
                      selectedCity: _pickupCity,
                      onCityChanged: (city) => setState(() => _pickupCity = city),
                      locationController: _pickupLocationController,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DestinationSection(
                      selectedCity: _destinationCity,
                      onCityChanged: (city) =>
                          setState(() => _destinationCity = city),
                      locationController: _destinationLocationController,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TripPreferencesSection(
                      selectedPassengers: _passengers,
                      onPassengersChanged: (v) =>
                          setState(() => _passengers = v),
                      selectedServiceType: _serviceType,
                      onServiceTypeChanged: (v) => setState(() {
                        _serviceType = v;
                        _vehicleType = null;
                      }),
                      selectedVehicleType: _vehicleType,
                      onVehicleTypeChanged: (v) =>
                          setState(() => _vehicleType = v),
                      selectedDate: _pickupDate,
                      onDateSelected: (date) =>
                          setState(() => _pickupDate = date),
                      notesController: _notesController,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      label: AppStrings.bookRideButton,
                      onPressed: _onBookRidePressed,
                      isLoading: _isSubmitting,
                      icon: Icons.directions_car_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Full-width green gradient hero banner with app branding.
  Widget _buildHeroBanner(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        topPadding + AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App identity row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: const Icon(
                  Icons.directions_car_filled,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                AppStrings.appTitle,
                style: AppTypography.labelMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Main heading
          const Text(
            'Book Your\nRide Today',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Safe & comfortable transport for Umrah\npilgrims across Saudi Arabia.',
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
