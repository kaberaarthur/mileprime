import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/select_location_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/save_locations/save_locations_screen.dart';

import '../../common_widgets/common_text_feild.dart';

saveAsLocationBottomSheet(BuildContext context) {
  SelectLocationController selectLocationController =
      Get.put(SelectLocationController());
  final LanguageController languageController = Get.put(LanguageController());
  languageController.loadSelectedLanguage();
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    constraints: const BoxConstraints(
      maxWidth: kIsWeb ? AppSize.size800 : double.infinity,
    ),
    isScrollControlled: true,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.size10),
        topRight: Radius.circular(AppSize.size10),
      ),
      borderSide: BorderSide.none,
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: AppSize.size326,
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: AppSize.size20,
            left: AppSize.size20,
            right: AppSize.size20,
            bottom: AppSize.size40,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSize.size10),
              topLeft: Radius.circular(AppSize.size10),
            ),
            color: AppColors.backGroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: AppSize.size16,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppStrings.saveAsLocation,
                        style: TextStyle(
                          fontFamily: FontFamily.latoBold,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSize.size20,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: AppSize.size14),
                    child: Text(
                      AppStrings.mapleAvenue3,
                      style: TextStyle(
                        fontFamily: FontFamily.latoMedium,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.size14,
                        color: AppColors.smallTextColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppSize.size20, bottom: AppSize.size14),
                    child: Row(
                      children: List.generate(AppSize.three, (index) {
                        return Obx(() => Padding(
                              padding:
                                  const EdgeInsets.only(right: AppSize.size24),
                              child: GestureDetector(
                                onTap: () {
                                  selectLocationController
                                      .setSelectedIndex(index);
                                },
                                child: Row(
                                  children: [
                                    Obx(
                                      () => Padding(
                                        padding: EdgeInsets.only(
                                            right: languageController.arb.value
                                                ? 0
                                                : AppSize.size6,
                                            left: languageController.arb.value
                                                ? AppSize.size6
                                                : AppSize.size0),
                                        child: Image.asset(
                                          index ==
                                                  selectLocationController
                                                      .selectedIndex.value
                                              ? AppIcons.radioFillIcon
                                              : AppIcons.radioEmpty,
                                          width: AppSize.size12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      selectLocationController
                                          .locationPlaces[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: FontFamily.latoMedium,
                                        fontSize: AppSize.size14,
                                        color: index ==
                                                selectLocationController
                                                    .selectedIndex.value
                                            ? AppColors.primaryColor
                                            : AppColors.blackTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: AppSize.opacity10,
                          color: AppColors.blackTextColor
                              .withOpacity(AppSize.opacity10),
                          blurRadius: AppSize.size20,
                        ),
                      ],
                    ),
                    child: CustomTextField(

                      controller:
                          selectLocationController.locationNameController,
                      hintText: AppStrings.locationName,
                      hintFontSize: AppSize.size14,
                      hintColor: AppColors.smallTextColor,
                      hintTextColor: AppColors.smallTextColor,
                      fontFamily: FontFamily.latoRegular,
                      height: AppSize.size54,
                      fillColor: AppColors.backGroundColor,
                      cursorColor: AppColors.smallTextColor,
                      fillFontFamily: FontFamily.latoSemiBold,
                      fillFontWeight: FontWeight.w600,
                      fillFontSize: AppSize.size14,
                      fontWeight: FontWeight.w400,
                      fillTextColor: AppColors.blackTextColor,
                      contentPadding: const EdgeInsets.only(
                          left: AppSize.size16,right:  AppSize.size16,
                          top: AppSize.size18,
                          bottom: AppSize.size18),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: AppSize.size54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.size10),
                          border: Border.all(
                            color: AppColors.blackTextColor,
                            width: AppSize.size1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            AppStrings.cancel,
                            style: TextStyle(
                              fontSize: AppSize.size16,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.latoSemiBold,
                              color: AppColors.blackTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: AppSize.size19,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (kIsWeb) {
                          Get.back();
                          Get.back();
                        } else {
                          Get.off(() => SaveLocationsScreen());
                        }
                      },
                      child: Container(
                        height: AppSize.size54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.size10),
                          color: AppColors.blackTextColor,
                        ),
                        child: const Center(
                          child: Text(
                            AppStrings.submit,
                            style: TextStyle(
                              fontSize: AppSize.size16,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.latoSemiBold,
                              color: AppColors.backGroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
