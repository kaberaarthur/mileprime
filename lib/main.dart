import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/storage_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/localization/app_translation.dart';
import 'package:prime_taxi_flutter_ui_kit/view/splash/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? languageCode = await StorageController.instance.getLanguage();
  String? countryCode = await StorageController.instance.getCountryCode();
  runApp(MyApp(
    languageCode: languageCode,
    countryCode: countryCode,
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    // Get reference to the 'riders' collection
    CollectionReference ridersCollection =
        FirebaseFirestore.instance.collection('riders');

    // Get the document with the specified ID
    DocumentSnapshot riderDocument =
        await ridersCollection.doc('IZ3bCXb8c8PDKZUdsCVh').get();

    // Access the document data
    if (riderDocument.exists) {
      Map<String, dynamic> riderData =
          riderDocument.data() as Map<String, dynamic>;
      debugPrint(riderData.toString()); // Convert map to string and then print
    } else {
      debugPrint('Document does not exist');
    }
  } catch (error) {
    debugPrint('Error fetching document: $error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.languageCode, this.countryCode});

  final String? languageCode;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translationsKeys: AppTranslation.translationsKeys,
      debugShowCheckedModeBanner: false,
      title: AppStrings.primeTaxiBooking,
      locale: Locale(languageCode ?? "en", countryCode ?? "US"),
      home: SplashScreen(),
    );
  }
}
