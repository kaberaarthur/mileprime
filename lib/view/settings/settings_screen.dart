// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/settings_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/settings/help_center_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/settings/language_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/settings/privacy_policy_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  SettingsController settingsController = Get.put(SettingsController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    languageController.loadSelectedLanguage();
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: _appBar(),
          body: _settingsContent(),
        ),
      ),
    );
  }

  //Settings Content
  _appBar() {
    return AppBar(
      backgroundColor: AppColors.backGroundColor,
      elevation: AppSize.size0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding:
            const EdgeInsets.only(left: AppSize.size5, top: AppSize.size10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Obx(() =>  RotationTransition(
             turns: AlwaysStoppedAnimation(languageController.arb.value?0.5:1.0),
             child: GestureDetector(
               onTap: () {
                 Get.back();
               },
               child: Image.asset(
                 AppIcons.arrowBack,
                 width: AppSize.size20,
               ),
             ),
           ),),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppSize.size12, right: AppSize.size12),
              child: Text(
                AppStrings.settings.tr,
                style: const TextStyle(
                  fontSize: AppSize.size20,
                  fontFamily: FontFamily.latoBold,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _settingsContent() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.size16),
            child: Text(
              AppStrings.appPreferences.tr,
              style: const TextStyle(
                fontSize: AppSize.size14,
                fontFamily: FontFamily.latoRegular,
                fontWeight: FontWeight.w400,
                color: AppColors.smallTextColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _customPreferences(
                  () {}, AppIcons.darkModeIcon, AppStrings.darkMode.tr),
              Container(
                width: AppSize.size30,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    spreadRadius: AppSize.size1,
                    color:
                        AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                    blurRadius: AppSize.size14,
                  ),
                ]),
                child: GestureDetector(
                  onTap: () {
                    settingsController.isSwitched.value =
                        !settingsController.isSwitched.value;
                  },
                  child: Obx(() => Image.asset(
                        settingsController.isSwitched.value
                            ? AppIcons.switchOn
                            : AppIcons.switchOff,
                        width: AppSize.size30,
                      )),
                ),
              ),
            ],
          ),
          _customPreferences(() {
            Get.to(() => LanguageScreen());
          }, AppIcons.languageIcon, AppStrings.language.tr),
          _customPreferences(() {
            Get.to(() => const PrivacyPolicyScreen());
          }, AppIcons.privacyPolicyIcon, AppStrings.privacyPolicy.tr),
          _customPreferences(() {
            Get.to(() => HelpCenterScreen());
          }, AppIcons.helpCenterIcon, AppStrings.helpCenter.tr),
        ],
      ),
    );
  }

  _customPreferences(Function()? onTap, String image, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.size24),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: AppSize.size8, left: AppSize.size8),
              child: Image.asset(
                image,
                width: AppSize.size24,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
                color: AppColors.blackTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
