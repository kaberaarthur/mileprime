import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_height_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/get_started_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/otp_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/home/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController otpController = Get.put(OtpController());
  final GetStartedController getStartedController =
      Get.put(GetStartedController());

  late String phoneNumber;
  late String otp;

  String? riderEmail;
  String? riderPassword;
  String? riderName;

  void debugPrintEmail(String? email) {
    if (email != null) {
      debugPrint('Rider email: $email');
    } else {
      debugPrint('Email not found or null');
    }
  }

  void debugPrintPassword(String? password) {
    if (password != null) {
      debugPrint('Rider password: $password');
    } else {
      debugPrint('Email not found or null');
    }
  }

  Future<void> signInWithEmailAndPassword(
      String riderEmail, String riderPassword) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: riderEmail,
        password: riderPassword,
      );
      final user = userCredential.user;
      if (user != null) {
        debugPrint('Sign in successful. User UID: ${user.uid}');
        debugPrint('Sign in successful. User UID: ${user.uid}');
        debugPrint('Sign in successful. User UID: ${user.uid}');
        // You can add any additional logic here after successful sign-in

        Get.to(() => HomeScreen(), arguments: {
          'phoneNumber': phoneNumber,
          'riderEmail': riderEmail,
          'riderName': riderName,
        });
      } else {
        debugPrint('Error: User is null');
        // Handle the case where the user is null
      }
    } catch (e) {
      debugPrint('Error signing in: $e');
      // Handle error here
    }
  }

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      phoneNumber = args['phoneNumber'] ?? '';
      otp = args['otp'] ?? '';
    } else {
      phoneNumber = '';
      otp = '';
    }
    debugPrint('Phone Number: $phoneNumber');
    debugPrint('OTP: $otp');

    if (phoneNumber.isNotEmpty) {
      fetchRiderDocument();
    }
  }

  Future<void> fetchRiderDocument() async {
    try {
      final CollectionReference ridersCollection =
          FirebaseFirestore.instance.collection('riders');
      final QuerySnapshot snapshot =
          await ridersCollection.where('phone', isEqualTo: phoneNumber).get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot document = snapshot.docs.first;
        final Map<String, dynamic>? data =
            document.data() as Map<String, dynamic>?;

        // Get Rider Email
        if (data != null && data.containsKey('email')) {
          debugPrint('Rider email: ${data['email']}');
          riderEmail = data['email'] as String;
          riderName = data['name'] as String;
        } else {
          debugPrint('Email not found in rider document');
        }

        // Get Rider Password
        if (data != null && data.containsKey('password')) {
          debugPrint('Rider password: ${data['password']}');
          riderPassword = data['password'] as String;
        } else {
          debugPrint('Password not found in rider document');
        }
      } else {
        debugPrint('No document found for the provided phone number');
      }
    } catch (e) {
      debugPrint('Error fetching rider document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bgImage(context, height, width),
                const CommonHeightSizedBox(height: AppSize.size50),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.size20),
                  child: Text(
                    AppStrings.enterTheOtp,
                    style: TextStyle(
                      color: AppColors.blackTextColor,
                      fontFamily: FontFamily.latoBold,
                      fontSize: AppSize.size20,
                    ),
                  ),
                ),
                const CommonHeightSizedBox(height: AppSize.size12),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppSize.size20, right: AppSize.size50),
                  child: Text(
                    "${AppStrings.weHaveSent}${getStartedController.phoneController.text}",
                    style: const TextStyle(
                      color: AppColors.smallTextColor,
                      fontFamily: FontFamily.latoRegular,
                      fontSize: AppSize.size12,
                    ),
                  ),
                ),
                const CommonHeightSizedBox(height: AppSize.size68),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSize.size20),
                  child: pinPutField(context),
                ),
                const CommonHeightSizedBox(height: AppSize.size24),
                Obx(() => otpController.isTimerExpired.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSize.size20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppStrings.didNotReceive,
                              style: TextStyle(
                                color: AppColors.smallTextColor,
                                fontFamily: FontFamily.latoRegular,
                                fontSize: AppSize.size12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                otpController.resendOTP();
                                otpController.isTimerExpired.value = false;
                              },
                              child: const Text(
                                AppStrings.resendOtp,
                                style: TextStyle(
                                  color: AppColors.blackTextColor,
                                  fontFamily: FontFamily.latoRegular,
                                  fontSize: AppSize.size12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSize.size20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              AppStrings.resendOtpIn,
                              style: TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontSize: AppSize.size12,
                                  color: AppColors.smallTextColor),
                            ),
                            Text(
                              "${otpController.timer.value}s",
                              style: const TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontSize: AppSize.size12,
                                  color: AppColors.blackTextColor),
                            ),
                          ],
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pinPutField(BuildContext context) {
    return Pinput(
      length: 5,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      controller: otpController.pinPutController,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: AppSize.size56,
        height: AppSize.size54,
        padding:
            const EdgeInsets.only(left: AppSize.size23, right: AppSize.size23),
        textStyle: TextStyle(
          fontSize: AppSize.size14,
          fontFamily: FontFamily.latoSemiBold,
          color: Theme.of(context).appBarTheme.titleTextStyle?.color,
        ),
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: AppSize.size66,
              spreadRadius: AppSize.size0,
            )
          ],
          borderRadius: BorderRadius.circular(AppSize.size10),
          border: Border.all(color: AppColors.borderColor),
        ),
      ),
      onChanged: (value) {
        otpController.otp.value = value;
        if (value.length == 5 && value == otp) {
          debugPrint("Length Met and OTP matched with phone number");
          /*debugPrintPassword(riderPassword);
          debugPrintEmail(riderEmail);*/
          signInWithEmailAndPassword(riderEmail!, riderPassword!);
        }
      },
    );
  }

  Widget bgImage(
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      color: AppColors.lightTheme,
      height: height / AppSize.size3_2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.size20,
                left: AppSize.size20,
                bottom: AppSize.size30),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                    otpController.resendOTP();
                    otpController.isTimerExpired.value = false;
                  },
                  child:
                      Image.asset(AppIcons.arrowBack, height: AppSize.size20)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AppImages.otpImage,
              height: height / AppSize.size5_2,
            ),
          ),
        ],
      ),
    );
  }
}
