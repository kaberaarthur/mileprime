import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/home/home_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/save_locations/select_location_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class SaveLocationsScreen extends StatelessWidget {
  SaveLocationsScreen({Key? key}) : super(key: key);
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
          body: _saveLocationsContent(context),
        ),
      ),
    );
  }

  //Save Locations Content
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
                Get.off(() => HomeScreen());
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
                AppStrings.saveLocations,
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

  _saveLocationsContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: AppSize.size8),
            child: Text(
              AppStrings.createALocation,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.latoBold,
                fontSize: AppSize.size16,
                color: AppColors.blackTextColor,
              ),
            ),
          ),
          const Text(
            AppStrings.addFrequentedLocation,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.latoRegular,
              fontSize: AppSize.size12,
              color: AppColors.smallTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSize.size33,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        right:
                            languageController.arb.value ? 0 : AppSize.size10,
                        left: languageController.arb.value
                            ? AppSize.size10
                            : AppSize.size0),
                    child: Image.asset(
                      AppIcons.homeIcon,
                      width: AppSize.size16,
                    ),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: AppSize.size6),
                      child: Text(
                        AppStrings.home,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.latoSemiBold,
                          fontSize: AppSize.size14,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                    Text(
                      AppStrings.willowLane777,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.latoRegular,
                        fontSize: AppSize.size12,
                        color: AppColors.smallTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.size16, bottom: AppSize.size44),
            child: Divider(
              color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
              height: AppSize.size0,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => SelectLocationScreen());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: AppSize.size81,
              decoration: BoxDecoration(
                color: AppColors.backGroundColor,
                border: Border.all(
                  color:
                      AppColors.smallTextColor.withOpacity(AppSize.opacity15),
                  width: AppSize.size1and5,
                ),
                borderRadius: BorderRadius.circular(AppSize.size10),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: AppSize.opacity10,
                    color:
                        AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                    blurRadius: AppSize.size10,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSize.size8),
                    child: Image.asset(
                      AppIcons.addIcon,
                      width: AppSize.size24,
                    ),
                  ),
                  const Text(
                    AppStrings.addMore,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.latoRegular,
                      fontSize: AppSize.size14,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
