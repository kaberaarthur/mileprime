import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class SafetyScreen extends StatelessWidget {
  SafetyScreen({Key? key}) : super(key: key);
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: _appBar(),
          body: _safetyContent(),
        ),
      ),
    );
  }

  //Safety Content
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
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppIcons.arrowBack,
                width: AppSize.size20,
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: AppSize.size12, right: AppSize.size12),
              child: Text(
                AppStrings.safety,
                style: TextStyle(
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

  _safetyContent() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size90,
        right: AppSize.size20,
        left: AppSize.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppIcons.safety,
              width: AppSize.size122,
              height: AppSize.size118,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: AppSize.size40),
            child: Text(
              AppStrings.whoDoYouWantToCorrect,
              style: TextStyle(
                  fontSize: AppSize.size16,
                  fontFamily: FontFamily.latoBold,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.size40),
            child: Column(
              children: [
                _customContact(AppIcons.ambulance, AppStrings.ambulance),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.size18, bottom: AppSize.size24),
                  child: Divider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size0,
                  ),
                ),
                _customContact(AppIcons.police, AppStrings.police),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.size18, bottom: AppSize.size24),
                  child: Divider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size0,
                  ),
                ),
                _customContact(
                    AppIcons.messageSupport, AppStrings.messageSupport),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.size18, bottom: AppSize.size24),
                  child: Divider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _customContact(String image, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.only(
                    right: languageController.arb.value ? 0 : AppSize.size8,
                    left: languageController.arb.value
                        ? AppSize.size8
                        : AppSize.size0),
                child: Image.asset(
                  image,
                  width: AppSize.size20,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: AppSize.size14,
                  fontFamily: FontFamily.latoSemiBold,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackTextColor),
            ),
          ],
        ),
        Image.asset(
          AppIcons.rightArrowIcon,
          width: AppSize.size16,
        ),
      ],
    );
  }
}
