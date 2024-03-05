import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';

autoDetailsBottomSheet(BuildContext context) {
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
      return Container(
        height: AppSize.size438,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.size10),
            topLeft: Radius.circular(AppSize.size10),
          ),
          color: AppColors.backGroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                  top: AppSize.size20,
                  left: AppSize.size20,
                  right: AppSize.size20,
                ),
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          right: AppSize.size6,
                        ),
                        child: Text(
                          AppStrings.car,
                          style: TextStyle(
                            fontFamily: FontFamily.latoBold,
                            fontWeight: FontWeight.w700,
                            fontSize: AppSize.size20,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ),
                      Image.asset(
                        AppIcons.carModelIcon,
                        width: AppSize.size22,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: AppSize.size12,
                    ),
                    child: Text(
                      AppStrings.autoDetailString,
                      style: TextStyle(
                        fontFamily: FontFamily.latoMedium,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.size14,
                        color: AppColors.smallTextColor,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: AppSize.size21,
                    ),
                    child: Text(
                      AppStrings.totalFare,
                      style: TextStyle(
                        fontFamily: FontFamily.latoBold,
                        fontWeight: FontWeight.w700,
                        fontSize: AppSize.size16,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: AppSize.size10,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppSize.size16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.includesTaxes,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSize.size14,
                                  color: AppColors.smallTextColor,
                                ),
                              ),
                              Text(
                                AppStrings.dollar76,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoBold,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppSize.size16,
                                  color: AppColors.blackTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppSize.size18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.rideFare,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSize.size14,
                                  color: AppColors.smallTextColor,
                                ),
                              ),
                              Text(
                                AppStrings.dollar50,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoSemiBold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppSize.size14,
                                  color: AppColors.blackTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppSize.size18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.totalAccessFee,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSize.size14,
                                  color: AppColors.smallTextColor,
                                ),
                              ),
                              Text(
                                AppStrings.dollar50,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoSemiBold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppSize.size14,
                                  color: AppColors.blackTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSize.size3,
                    ),
                    child: RichText(
                      text: const TextSpan(
                        text: AppStrings.note,
                        style: TextStyle(
                          fontFamily: FontFamily.latoRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: AppSize.size14,
                          color: AppColors.blackTextColor,
                        ),
                        children: [
                          TextSpan(
                            text: AppStrings.noteString,
                            style: TextStyle(
                              fontFamily: FontFamily.latoRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: AppSize.size12,
                              color: AppColors.smallTextColor,
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: AppSize.size100,
              color: AppColors.backGroundColor,
              padding: const EdgeInsets.only(
                top: AppSize.size24,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: AppSize.size54,
                    margin: const EdgeInsets.only(
                      left: AppSize.size20,
                      right: AppSize.size20,
                      bottom: AppSize.size20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blackTextColor,
                      borderRadius: BorderRadius.circular(AppSize.size10),
                    ),
                    child: const Center(
                      child: Text(
                        AppStrings.done,
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
            ),
          ],
        ),
      );
    },
  );
}