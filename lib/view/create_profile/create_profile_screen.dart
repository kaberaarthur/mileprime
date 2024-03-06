import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_button.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_height_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_text_feild.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_width_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/create_profile_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/home_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/terms_of_service/terms_of_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class CreateProfileScreen extends StatelessWidget {
  CreateProfileScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final CreateProfileController createProfileController =
      Get.put(CreateProfileController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController enterCode = TextEditingController();
  final TextEditingController enterEmail = TextEditingController();

  Future<String> generatePartnerCode() async {
    try {
      // Get the current day and month
      DateTime now = DateTime.now();
      String day = now.day.toString().padLeft(2, '0');
      String month = now.month.toString().padLeft(2, '0');

      // Get the total number of riders from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('riders').get();
      int totalRiders = querySnapshot.docs.length;

      // Concatenate the total number of riders with day and month
      String code = 'MTL${totalRiders + 1}$day$month';

      return code;
    } catch (e) {
      debugPrint('Error generating partner code: $e');
      return ''; // Return empty string in case of error
    }
  }

  Future<String?> createUserWithEmailAndPassword(String email, String password,
      String otpCode, String referralCode) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid; // Get the UID of the user
      debugPrint('User created successfully: $uid');
      return uid; // Return the UID
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      return null; // Return null if an error occurs
    } catch (e) {
      debugPrint('Error creating user: $e');
      return null; // Return null if an error occurs
    }
  }

  // Function to create a document in Firestore
  void createFirestoreDocument(String uid, String email, String otpCode,
      String selectedGender, String referralCode) async {
    try {
      // Await the partner code generation
      String partnerCode = await generatePartnerCode();

      FirebaseFirestore.instance.collection('riders').doc(uid).set({
        'email': email,
        'otpCode': otpCode,
        'otpDate': generateServerTimestamp(),
        'dateRegistered': generateServerTimestamp(),
        'activeUser': true,
        'authID': uid,
        'gender': selectedGender,
        'language': 'en',
        'partnerCode': partnerCode, // Use the generated partner code
        'phone': '',
        'referralCode': referralCode,
      });
      debugPrint('Firestore document created successfully');
    } catch (e) {
      debugPrint('Error creating Firestore document: $e');
    }
  }

  // Function to generate Firestore server timestamp
  FieldValue generateServerTimestamp() {
    return FieldValue.serverTimestamp();
  }

  // Selected Gender
  String selectedGender = 'male';

  // Function to generate a random password
  String generatePassword(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join('');
  }

  // Function to generate a 5-digit OTP
  String generateOTP() {
    const chars = '0123456789';
    final random = Random.secure();
    return List.generate(5, (index) => chars[random.nextInt(chars.length)])
        .join('');
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
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(AppSize.size0),
                child: AppBar(
                  backgroundColor: AppColors.lightTheme,
                  elevation: AppSize.size0,
                )),
            body: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bgImage(context, height, width),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonHeightSizedBox(
                                      height: height / AppSize.fifteen),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppSize.size20),
                                    child: Text(
                                      AppStrings.createYourProfile,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.blackTextColor,
                                        fontFamily: FontFamily.latoBold,
                                        fontSize: AppSize.size20,
                                      ),
                                    ),
                                  ),
                                  CommonHeightSizedBox(
                                      height: height / AppSize.seventy),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppSize.size20),
                                    child: Text(
                                      AppStrings.pleaseCreateYourAccount,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.smallTextColor,
                                        fontFamily: FontFamily.latoRegular,
                                        fontSize: AppSize.size12,
                                      ),
                                    ),
                                  ),
                                  CommonHeightSizedBox(
                                      height: height / AppSize.size20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSize.size20),
                                    child: Container(
                                      height: AppSize.size54,
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadow,
                                          blurRadius: AppSize.size66,
                                          spreadRadius: AppSize.size0,
                                        )
                                      ]),
                                      child: CustomTextField(
                                        prefixIcon: const SizedBox(
                                          width: AppSize.size16,
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: AppSize.size16,
                                        ),
                                        hintColor: AppColors.smallTextColor,
                                        fontFamily: FontFamily.latoRegular,
                                        fontSize: AppSize.size14,
                                        hintText: AppStrings.enterFullName,
                                        fillFontFamily: FontFamily.latoSemiBold,
                                        fillFontSize: AppSize.size14,
                                        colorText: AppColors.blackTextColor,
                                        textInputAction: TextInputAction.done,
                                        fillColor: AppColors.backGroundColor,
                                        controller: nameController,
                                      ),
                                    ),
                                  ),
                                  CommonHeightSizedBox(
                                      height: height / AppSize.size35),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSize.size20),
                                    child: Container(
                                      height: AppSize.size54,
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadow,
                                          blurRadius: AppSize.size66,
                                          spreadRadius: AppSize.size0,
                                        )
                                      ]),
                                      child: CustomTextField(
                                        prefixIcon: const SizedBox(
                                          width: AppSize.size16,
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: AppSize.size16,
                                        ),
                                        hintColor: AppColors.smallTextColor,
                                        fontFamily: FontFamily.latoRegular,
                                        fontSize: AppSize.size14,
                                        hintText: AppStrings.enterEmail,
                                        fillFontFamily: FontFamily.latoSemiBold,
                                        fillFontSize: AppSize.size14,
                                        colorText: AppColors.blackTextColor,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        fillColor: AppColors.backGroundColor,
                                        controller: enterEmail,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CommonHeightSizedBox(height: height / AppSize.size60),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.size20),
                            child: Text(
                              AppStrings.gender,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.smallTextColor,
                                fontFamily: FontFamily.latoRegular,
                                fontSize: AppSize.size14,
                              ),
                            ),
                          ),
                          CommonHeightSizedBox(height: height / AppSize.size70),
                          _buildGenderRow(),
                          CommonHeightSizedBox(height: height / AppSize.size35),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.size20),
                            child: Container(
                              height: AppSize.size54,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: AppSize.size66,
                                  spreadRadius: AppSize.size0,
                                )
                              ]),
                              child: CustomTextField(
                                prefixIcon: const SizedBox(
                                  width: AppSize.size16,
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: AppSize.size16,
                                ),
                                hintColor: AppColors.smallTextColor,
                                fontFamily: FontFamily.latoRegular,
                                fontSize: AppSize.size14,
                                hintText: AppStrings.enterReferralCode,
                                fillFontFamily: FontFamily.latoSemiBold,
                                fillFontSize: AppSize.size14,
                                colorText: AppColors.blackTextColor,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                fillColor: AppColors.backGroundColor,
                                controller: enterCode,
                              ),
                            ),
                          ),
                          CommonHeightSizedBox(height: height / AppSize.size50),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.size15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: AppSize.size20,
                                right: AppSize.size20,
                                bottom: AppSize.size20),
                            child: ButtonCommon(
                              onTap: () async {
                                // Generate new OTP
                                String newOTP = generateOTP();
                                // Get email and password from text controllers
                                String email = enterEmail.text;
                                String referralCode = enterCode.text;
                                String password = generatePassword(8);

                                // Create user with email, password, and OTP
                                String? uid =
                                    await createUserWithEmailAndPassword(
                                        email, password, newOTP, referralCode);

                                // Check if user creation was successful
                                if (uid != null) {
                                  // Create Firestore document with user data
                                  createFirestoreDocument(uid, email, newOTP,
                                      selectedGender, referralCode);

                                  // Navigate to TermsOfService screen
                                  Get.to(() => TermsOfService());
                                } else {
                                  // Handle error if user creation failed
                                  // Display error message or take appropriate action
                                }
                              },
                              text: AppStrings.proceed,
                              height: AppSize.size54,
                              buttonColor: AppColors.blackTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  Padding _buildGenderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size20),
      child: Row(
        children: [
          Obx(
            () => Expanded(
              child: GestureDetector(
                onTap: () {
                  selectedGender = 'male';
                  createProfileController.male.value = true;
                  createProfileController.female.value = false;
                  createProfileController.other.value = false;
                },
                child: Container(
                  height: AppSize.size44,
                  decoration: BoxDecoration(
                      color: AppColors.backGroundColor,
                      border: Border.all(
                          color: createProfileController.male.value
                              ? AppColors.primaryColor
                              : AppColors.borderColor,
                          width: AppSize.size1),
                      borderRadius: BorderRadius.circular(AppSize.size8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: AppSize.size66,
                          spreadRadius: AppSize.size0,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      AppStrings.male,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: createProfileController.male.value
                            ? AppColors.primaryColor
                            : AppColors.blackTextColor,
                        fontFamily: FontFamily.latoRegular,
                        fontSize: AppSize.size14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const CommonWidthSizedBox(width: AppSize.size19),
          Obx(
            () => Expanded(
                child: GestureDetector(
                    onTap: () {
                      selectedGender = 'female';
                      createProfileController.male.value = false;
                      createProfileController.female.value = true;
                      createProfileController.other.value = false;
                    },
                    child: Container(
                      height: AppSize.size44,
                      decoration: BoxDecoration(
                          color: AppColors.backGroundColor,
                          border: Border.all(
                              color: createProfileController.female.value
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: AppSize.size1),
                          borderRadius: BorderRadius.circular(AppSize.size8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: AppSize.size66,
                              spreadRadius: AppSize.size0,
                            )
                          ]),
                      child: Center(
                        child: Text(
                          AppStrings.female,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: createProfileController.female.value
                                ? AppColors.primaryColor
                                : AppColors.blackTextColor,
                            fontFamily: FontFamily.latoRegular,
                            fontSize: AppSize.size14,
                          ),
                        ),
                      ),
                    ))),
          ),
          const CommonWidthSizedBox(width: AppSize.size19),
          Obx(() => Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedGender = 'other';
                    createProfileController.male.value = false;
                    createProfileController.female.value = false;
                    createProfileController.other.value = true;
                  },
                  child: Container(
                    height: AppSize.size44,
                    decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        border: Border.all(
                            color: createProfileController.other.value
                                ? AppColors.primaryColor
                                : AppColors.borderColor,
                            width: AppSize.size1),
                        borderRadius: BorderRadius.circular(AppSize.size8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: AppSize.size66,
                            spreadRadius: AppSize.size0,
                          )
                        ]),
                    child: Center(
                      child: Text(
                        AppStrings.other,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: createProfileController.other.value
                              ? AppColors.primaryColor
                              : AppColors.blackTextColor,
                          fontFamily: FontFamily.latoRegular,
                          fontSize: AppSize.size14,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget bgImage(
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      color: AppColors.lightTheme,
      height: height / AppSize.size3And5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppSize.size20, bottom: AppSize.size30),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child:
                      Image.asset(AppIcons.arrowBack, height: AppSize.size20)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AppImages.createProfileImage,
              height: height / AppSize.size5and2,
            ),
          ),
        ],
      ),
    );
  }
}
