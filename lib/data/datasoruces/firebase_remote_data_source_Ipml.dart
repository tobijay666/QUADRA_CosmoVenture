import 'dart:convert';
import 'dart:io';
import 'package:cosmoventure/data/models/user_model.dart';
import 'package:cosmoventure/domain/entities/booking_entity.dart';
import 'package:cosmoventure/domain/entities/destination_entity.dart';
import 'package:cosmoventure/domain/entities/journey_entity%20copy.dart';
import 'package:cosmoventure/domain/entities/payment_entity.dart';
import 'package:cosmoventure/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:http/http.dart' as http;
import 'package:dbcrypt/dbcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_remote_data_source_impl.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl(
      {required this.auth,
      required this.firestore,
      required this.firebaseStorage});

  @override
  Future<void> signUp(UserEntity user) async {
    try {
      final userDocRef = firestore.collection('users').doc(user.iId);
      final userDocSnapshot = await userDocRef.get();

      if (!userDocSnapshot.exists) {
        final hashedPassword = await FlutterBcrypt.hashPw(
            password: user.password!, salt: r'$2b$06$C6UzMDM.H6dfI/f/IKxGhu');

        await userDocRef.set(
          {
            "name": user.name,
            "iId": user.iId,
            "address": user.address,
            "password": hashedPassword,
          },
        );
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<String> signIn(UserEntity user) async {
    try {
      final userDocRef = firestore.collection('users').doc(user.iId);
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final storedHashedPassword = userDocSnapshot.data()?['password'];
        final isPasswordMatch = await FlutterBcrypt.verify(
          password: user.password!,
          hash: storedHashedPassword,
        );

        print(isPasswordMatch);

        if (isPasswordMatch) {
          // Password matches, user is authenticated.
          print('User authenticated successfully.');
          return user.iId!;
        } else {
          throw Exception('Incorrect password.');
        }
      } else {
        throw Exception('User not found.');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<UserEntity> getUserDetails(String uid) async {
    try {
      final userDocRef = firestore.collection('users').doc("100");
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        return UserModel.formSnapshot(userDocSnapshot);
      } else {
        throw Exception('User not found.');
      }
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }

  @override
  Future<String> getCurrentUserUid() {
    // TODO: implement getCurrentUserUid
    throw UnimplementedError();
  }

  @override
  Future<List<DestinationEntity>> getDestinationCards() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('destinations').get();
      return snapshot.docs.map((doc) {
        List<String>? imageList = List<String>.from(doc.get('image'));
        return DestinationEntity(
          title: doc.get('title'),
          description: doc.get('description'),
          image: imageList,
          price: doc.get('price'),
          rating: doc.get('rating'),
          age: doc.get('age'),
          density: doc.get('density'),
          gravity: doc.get('gravity'),
          oxygen: doc.get('oxygen'),
          magnitude: doc.get('magnitude'),
          distance: doc.get('distance'),
          coordinates: doc.get('coordinates'),
          hTemp: doc.get('highest_temp'),
          lTemp: doc.get('lowest_temp'),
          cTemp: doc.get('current_temp'),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }

  @override
  Future<List<JourneyEntity>> getJourneyCards() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('journeys').get();

      return snapshot.docs.map((doc) {
        DateTime dateTime = doc.get('time').toDate();
        return JourneyEntity(
          title: doc.get('title'),
          time: dateTime,
          venue: doc.get('venue'),
          image: doc.get('image'),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }

  @override
  Future<String> addBooking(BookingEntity bookingEntity) async {
    try {
      final bookingDocRef = firestore.collection('bookings').doc();
      final documentId = bookingDocRef.id;
      await bookingDocRef.set(
        {
          "id": bookingEntity.id,
          "time": bookingEntity.time,
          "arrival": bookingEntity.arrival,
          "date": bookingEntity.date,
          "departure": bookingEntity.departure,
          "passengerCount": bookingEntity.passengerCount,
          "destination": bookingEntity.destination,
          "price": bookingEntity.price,
        },
      );
      return documentId;
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }

  @override
  Future<BookingEntity> getBookingDetails(String uid) async {
    try {
      final bookingDocRef = firestore.collection('bookings').doc(uid);
      final bookingDocSnapshot = await bookingDocRef.get();

      if (bookingDocSnapshot.exists) {
        return BookingEntity(
          destination: bookingDocSnapshot.get('destination'),
          passengerCount: bookingDocSnapshot.get('passengerCount'),
          arrival: bookingDocSnapshot.get('arrival'),
          time: bookingDocSnapshot.get('time'),
          date: bookingDocSnapshot.get('date'),
          departure: bookingDocSnapshot.get('departure'),
          price: bookingDocSnapshot.get('price'),
        );
      } else {
        throw Exception('User not found.');
      }
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }

  @override
  Future<String> addPayment(PaymentEntity paymentEntity) async {
    try {
      final paymentDocRef = firestore.collection('payments').doc();
      final documentId = paymentDocRef.id;
      await paymentDocRef.set(
        {
          "bookingId": paymentEntity.bookingId,
          "paymentType": paymentEntity.paymentType,
          "destination": paymentEntity.destination,
          "price": paymentEntity.price,
        },
      );
      return documentId;
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }
}
