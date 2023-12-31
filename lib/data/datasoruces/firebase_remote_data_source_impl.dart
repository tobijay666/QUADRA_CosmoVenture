import 'dart:io';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/destination_entity.dart';
import '../../domain/entities/journey_entity copy.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  ///auth
  Future<void> signUp(UserEntity user);
  Future<String> signIn(UserEntity user);
  Future<String> getCurrentUserUid();
  Future<UserEntity> getUserDetails(String uid);

  ///destinations
  Future<List<DestinationEntity>> getDestinationCards();
  Future<List<JourneyEntity>> getJourneyCards();

  ///booking
  Future<String> addBooking(BookingEntity bookingEntity);
  Future<BookingEntity> getBookingDetails(String uid);
  Future<String> addPayment(PaymentEntity paymentEntity);
}
