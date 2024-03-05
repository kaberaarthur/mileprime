import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';

class CallWithDriverScreen extends StatelessWidget {
  CallWithDriverScreen({Key? key}) : super(key: key);
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    languageController.loadSelectedLanguage();
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          body: _callWithDriverContent(context),
        ),
      ),
    );
  }

  //Call with Driver Content
  _callWithDriverContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.callBlurImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.only(
                top: AppSize.size48,
                right: languageController.arb.value ? AppSize.size20 : 0,
                left: languageController.arb.value
                    ? AppSize.size0
                    : AppSize.size20),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppIcons.closeIcon2,
                width: AppSize.size18,
                color: AppColors.backGroundColor,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSize.size182,
            ),
            child: Column(
              children: [
                Image.asset(
                  AppIcons.driverIcon,
                  width: AppSize.size107,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: AppSize.size16),
                  child: Text(
                    AppStrings.time9and45,
                    style: TextStyle(
                      fontFamily: FontFamily.latoRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSize.size14,
                      color: AppColors.text3Color,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: AppSize.size6),
                  child: Text(
                    AppStrings.deirdreRaja,
                    style: TextStyle(
                      fontFamily: FontFamily.latoBold,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSize.size20,
                      color: AppColors.backGroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: AppSize.size302,
                height: AppSize.size64,
                margin: const EdgeInsets.only(bottom: AppSize.size40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.size70),
                ),
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.size24),
                    width: AppSize.size302,
                    height: AppSize.size52,
                    decoration: BoxDecoration(
                      color: AppColors.blackTextColor,
                      borderRadius: BorderRadius.circular(AppSize.size70),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(
                                    left: languageController.arb.value
                                        ? AppSize.size24
                                        : 0,
                                    right: languageController.arb.value
                                        ? AppSize.size0
                                        : AppSize.size24),
                                child: Image.asset(
                                  AppIcons.volumeIcon,
                                  width: AppSize.size24,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppIcons.videoIcon,
                              width: AppSize.size24,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(
                                    left: languageController.arb.value
                                        ? AppSize.size24
                                        : 0 ,right: languageController.arb.value
                                        ? AppSize.size0
                                        : AppSize.size24),
                                child: Image.asset(
                                  AppIcons.microphoneIcon,
                                  width: AppSize.size24,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppIcons.addUserIcon,
                              width: AppSize.size24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppSize.size1,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const CircleAvatar(
                    radius: AppSize.size32,
                    backgroundColor: AppColors.smallTextColor,
                    child: CircleAvatar(
                      radius: AppSize.size27,
                      backgroundColor: AppColors.smallTextColor,
                      backgroundImage: AssetImage(AppIcons.callDeclineIcon),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
