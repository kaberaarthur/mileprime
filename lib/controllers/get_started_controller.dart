import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';

class GetStartedController extends GetxController {
  final countryTextController = TextEditingController();
  RxBool isValidPhoneNumber = false.obs;
  final TextEditingController phoneController = TextEditingController();

  void checkPhoneNumberValidity(String phoneNumber) {
    isValidPhoneNumber.value = phoneNumber.length == 9;
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
}
