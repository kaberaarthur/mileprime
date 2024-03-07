import 'package:flutter/material.dart';
import 'package:prime_taxi_flutter_ui_kit/view/otp/otp_screen.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to get the most recent document from the 'riders' collection
  Future<String?> checkRidersCollectionForPhoneNumber(
      String phoneNumber) async {
    try {
      // Query for documents with the given phone number, ordered by timestamp
      QuerySnapshot querySnapshot = await _firestore
          .collection('riders')
          .where('phone', isEqualTo: '+254$phoneNumber')
          // .orderBy('timestamp', descending: true)
          .limit(1) // Limit to only 1 document (most recent)
          .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first (most recent) document
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Convert document data to a Map<String, dynamic> using as Map<String, dynamic>?
        var data = documentSnapshot.data() as Map<String, dynamic>?;

        // Check if data is not null before accessing its fields
        if (data != null) {
          // Access the 'otpCode' field from the document data
          var otpCode = data['otpCode'];

          // Check if otpCode is not null
          if (otpCode != null) {
            // Return the OTP code
            return otpCode.toString();
          } else {
            // Return an error message
            return 'Error! OTP Code not found in document';
          }
        } else {
          // Return an error message
          return 'Error! Document data is null';
        }
      } else {
        // Return an error message
        return 'Error! No user found for phone number: +254$phoneNumber';
      }
    } catch (e) {
      // Return the error message
      return 'Error! Cannot fetch document: $e';
    }
  }
}
