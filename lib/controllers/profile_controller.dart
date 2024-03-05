// ignore_for_file: unrelated_type_equality_checks

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

import '../config/app_colors.dart';
import '../config/app_size.dart';
import '../config/font_family.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController(text: AppStrings.albertRadhe);
  TextEditingController mobileController = TextEditingController(text: AppStrings.mobileNumber);
  TextEditingController birthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final countryTextController = TextEditingController();
  RxBool isValidPhoneNumber = false.obs;
  RxInt selectedIndex = 0.obs;
  RxString imagePath = ''.obs;
  Rx<DateTime?> selectedDate = DateTime.now().obs;

  void setDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void checkPhoneNumberValidity(String phoneNumber) {
    isValidPhoneNumber.value = phoneNumber.length == 10;
  }

  FlCountryCodePicker? countryPicker;
  RxBool isChanged = false.obs;
  CountryCode? countryCode;

  @override
  void onInit() {
    countryPicker = const FlCountryCodePicker(
      countryTextStyle: TextStyle(
        color: AppColors.blackTextColor,
        fontFamily: FontFamily.latoMedium,
        fontSize: AppSize.size16,
      ),
      dialCodeTextStyle: TextStyle(
          color: AppColors.smallTextColor,
          fontSize: AppSize.size14,
          fontFamily: FontFamily.latoRegular),
    );
    super.onInit();
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      keyboardType: TextInputType.datetime,
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate.value = picked;
      birthController.text =
      "${picked.toLocal()}".split(' ')[0];
    }
  }

  List<String> genderList = [
    AppStrings.male,
    AppStrings.female,
    AppStrings.other,
  ];
}
