import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/book_car_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/home/home_screen.dart';

discardRouteBottomSheet(BuildContext context) {
  BookCarController bookCarController = Get.put(BookCarController());
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
        height: AppSize.size228,
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSize.size16,
                  ),
                  child: Text(
                    AppStrings.discardRoute,
                    style: TextStyle(
                      fontFamily: FontFamily.latoBold,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSize.size20,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
                Text(
                  AppStrings.discardRouteString,
                  style: TextStyle(
                    fontFamily: FontFamily.latoMedium,
                    fontWeight: FontWeight.w500,
                    fontSize: AppSize.size14,
                    color: AppColors.smallTextColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      bookCarController.startTimerAndToggleBooking();
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
                          AppStrings.no,
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
                      Get.offAll(HomeScreen());
                      bookCarController.toggleBooking();
                    },
                    child: Container(
                      height: AppSize.size54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.size10),
                        color: AppColors.blackTextColor,
                      ),
                      child: const Center(
                        child: Text(
                          AppStrings.yesDiscard,
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
      );
    },
  );
}