import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';

/// Firebase Firestore implementation of [BookingRepository].
///
/// Stores booking documents under the `bookings` collection in Firestore.
class FirestoreBookingRepository implements BookingRepository {
  FirestoreBookingRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<String> createBooking(BookingEntity booking) async {
    final docRef = _firestore.collection('bookings').doc();

    final data = {
      'bookingId': docRef.id,
      'customerName': booking.customerName,
      'whatsappNumber': booking.whatsappNumber,
      'pickupCity': booking.pickupCity,
      'pickupLocation': booking.pickupLocation,
      'destinationCity': booking.destinationCity,
      'destinationLocation': booking.destinationLocation,
      'passengers': booking.passengers,
      'serviceType': booking.serviceType,
      'vehicleType': booking.vehicleType,
      'pickupDate': Timestamp.fromDate(booking.pickupDate),
      'notes': booking.notes,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    };

    await docRef.set(data);
    return docRef.id;
  }
}
