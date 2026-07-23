import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../features/booking/domain/entities/booking_entity.dart';

/// Helper service responsible for formatting and launching WhatsApp chats directly.
class WhatsAppService {
  WhatsAppService._();

  /// Target owner phone number to receive bookings.
  static const String ownerPhoneNumber = '+923162624882';

  /// Formats [BookingEntity] details into a clean WhatsApp message and launches the app.
  static Future<bool> launchWhatsAppBooking({
    required BookingEntity booking,
    String? bookingId,
  }) async {
    final formattedDate = DateFormat(
      'EEEE, d MMMM yyyy',
    ).format(booking.pickupDate);

    final idHeader = bookingId != null ? ' (Ref: $bookingId)' : '';

    final message = StringBuffer()
      ..writeln('🕋 *NEW CAB BOOKING REQUEST*$idHeader')
      ..writeln('━━━━━━━━━━━━━━━━━━━━')
      ..writeln('👤 *Customer:* ${booking.customerName}')
      ..writeln('📞 *WhatsApp:* ${booking.whatsappNumber}')
      ..writeln(
        '📍 *Pickup:* ${booking.pickupCity} (${booking.pickupLocation})',
      )
      ..writeln(
        '🏁 *Destination:* ${booking.destinationCity} (${booking.destinationLocation})',
      )
      ..writeln('📅 *Date:* $formattedDate')
      ..writeln('🚖 *Service:* ${booking.serviceType}')
      ..writeln('🚘 *Vehicle:* ${booking.vehicleType}')
      ..writeln('👥 *Passengers:* ${booking.passengers}');

    if (booking.notes != null && booking.notes!.trim().isNotEmpty) {
      message.writeln('📝 *Notes:* ${booking.notes!.trim()}');
    }

    message
      ..writeln('━━━━━━━━━━━━━━━━━━━━')
      ..writeln(
        'Please confirm vehicle availability and total fare. JazakALLAH!',
      );

    // Clean target number (digits only for wa.me URL)
    final cleanNumber = ownerPhoneNumber.replaceAll(RegExp(r'\D'), '');
    final encodedMessage = Uri.encodeComponent(message.toString());
    final whatsappUrl = Uri.parse(
      'https://wa.me/$cleanNumber?text=$encodedMessage',
    );

    if (await canLaunchUrl(whatsappUrl)) {
      return await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Fallback for browsers or devices where deep link isn't directly caught
      final webUrl = Uri.parse(
        'https://api.whatsapp.com/send?phone=$cleanNumber&text=$encodedMessage',
      );
      return await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }
}
