import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';

specialOffersBottomSheet(BuildContext context) {
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
        height: AppSize.size633,
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
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: AppSize.size20,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppStrings.specialOffers,
                        style: TextStyle(
                          fontFamily: FontFamily.latoBold,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSize.size20,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    AppIcons.offerWhiteIcon,
                    width: AppSize.size80,
                    height: AppSize.size80,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: AppSize.size16,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppStrings.special25,
                        style: TextStyle(
                          fontFamily: FontFamily.latoBold,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSize.size16,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: AppSize.size4,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppStrings.specialPromoOnlyToday,
                        style: TextStyle(
                          fontFamily: FontFamily.latoRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: AppSize.size12,
                          color: AppColors.smallTextColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: AppStrings.codeCopied,
                          backgroundColor: AppColors.lightTheme,
                          textColor: AppColors.blackTextColor,
                          fontSize: AppSize.size14,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      },
                      child: Container(
                        width: AppSize.size131,
                        height: AppSize.size34,
                        margin: const EdgeInsets.only(top: AppSize.size16),
                        decoration: BoxDecoration(
                          color: AppColors.lightTheme,
                          borderRadius: BorderRadius.circular(AppSize.size3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                right: AppSize.size12,
                              ),
                              child: Text(
                                AppStrings.promoCode,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoBold,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppSize.size14,
                                  color: AppColors.blackTextColor,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppIcons.copyIcon,
                              width: AppSize.size14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size35,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: AppSize.size10,
                    ),
                    child: Text(
                      AppStrings.termsAndConditions,
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
                      top: AppSize.size10,
                    ),
                    child: Text(
                      AppStrings.termsAndConditionsString,
                      style: TextStyle(
                        fontFamily: FontFamily.latoRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.size12,
                        color: AppColors.smallTextColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSize.size12,
                      left: AppSize.size16,
                    ),
                    child: Column(
                      children: List.generate(AppSize.four, (index) => const Padding(
                        padding: EdgeInsets.only(
                          bottom: AppSize.size1,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\u2022  ",
                              style: TextStyle(
                                fontFamily: FontFamily.latoRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: AppSize.size12,
                                color: AppColors.smallTextColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppStrings.loremString,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSize.size12,
                                  color: AppColors.smallTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
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
                        AppStrings.usePromo,
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