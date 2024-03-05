import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/schedule_a_ride_controller.dart';

scheduleARideBottomSheet(BuildContext context) {
  ScheduleARideController scheduleARideController = Get.put(ScheduleARideController());
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
        height: AppSize.size352,
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
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: AppSize.size20,
                  left: AppSize.size20,
                  right: AppSize.size20,
                ),
                children: [
                  const Text(
                    AppStrings.scheduleARide,
                    style: TextStyle(
                      fontFamily: FontFamily.latoBold,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSize.size20,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSize.size16,
                    ),
                    child: Obx(() => Text(
                      scheduleARideController.formattedDateTime.value,
                      style: const TextStyle(
                        fontFamily: FontFamily.latoMedium,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.size14,
                        color: AppColors.smallTextColor,
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSize.size30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: AppSize.size130,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: AppSize.size90,
                                  height: AppSize.size43,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => SizedBox(
                              width: AppSize.size90,
                              height: AppSize.size130,
                              child: PageView.builder(
                                itemCount: AppSize.seven,
                                controller: PageController(
                                  viewportFraction: AppSize.zeroAndThirtyTwo,
                                  initialPage: scheduleARideController.currentDatePage.value,
                                ),
                                scrollDirection: Axis.vertical,
                                onPageChanged: (index) {
                                  scheduleARideController.currentDatePage.value = index;
                                },
                                itemBuilder: (context, index) {
                                  DateTime currentDate = DateTime.now();
                                  DateTime displayDate = currentDate.add(Duration(days: index));
                                  String formattedDate = DateFormat(AppStrings.dateString).format(displayDate);
                                  TextStyle textStyle = (index == scheduleARideController.currentDatePage.value)
                                      ? const TextStyle(
                                    color: AppColors.blackTextColor,
                                    fontSize: AppSize.size16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.latoMedium,
                                  ) : const TextStyle(
                                    color: AppColors.smallTextColor,
                                    fontSize: AppSize.size14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.latoRegular,
                                  );

                                  return Center(
                                    child: Text(
                                      formattedDate,
                                      style: textStyle,
                                      softWrap: false,
                                    ),
                                  );
                                },
                              ),
                            )),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: AppSize.size130,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: AppSize.size48,
                                  height: AppSize.size43,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => SizedBox(
                              width: AppSize.size48,
                              height: AppSize.size130,
                              child: PageView.builder(
                                itemCount: AppSize.twelve,
                                controller: PageController(
                                  viewportFraction: AppSize.zeroAndThirtyTwo,
                                  initialPage: scheduleARideController.currentHoursPage.value,
                                ),
                                scrollDirection: Axis.vertical,
                                onPageChanged: (index) {
                                  scheduleARideController.currentHoursPage.value = index;
                                },
                                itemBuilder: (context, index) {
                                  int hour = index + AppSize.one;
                                  TextStyle textStyle = (index == scheduleARideController.currentHoursPage.value)
                                      ? const TextStyle(
                                    color: AppColors.blackTextColor,
                                    fontSize: AppSize.size16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.latoMedium,
                                  ) : const TextStyle(
                                    color: AppColors.smallTextColor,
                                    fontSize: AppSize.size14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.latoRegular,
                                  );

                                  return Center(
                                    child: Text(
                                      hour.toString(),
                                      style: textStyle,
                                    ),
                                  );
                                },
                              ),
                            )),
                          ],
                        ),
                        const Text(
                          AppStrings.doubleDot,
                          style: TextStyle(
                            fontFamily: FontFamily.latoMedium,
                            fontWeight: FontWeight.w500,
                            fontSize: AppSize.size16,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: AppSize.size130,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: AppSize.size48,
                                  height: AppSize.size43,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => SizedBox(
                              width: AppSize.size48,
                              height: AppSize.size130,
                              child: PageView.builder(
                                itemCount: AppSize.five,
                                controller: PageController(
                                  viewportFraction: AppSize.zeroAndThirtyTwo,
                                  initialPage: scheduleARideController.currentMinutesPage.value,
                                ),
                                scrollDirection: Axis.vertical,
                                onPageChanged: (index) {
                                  scheduleARideController.currentMinutesPage.value = index;
                                },
                                itemBuilder: (context, index) {
                                  int minutes = index * AppSize.fifteen;
                                  TextStyle textStyle = (index == scheduleARideController.currentMinutesPage.value)
                                      ? const TextStyle(
                                    color: AppColors.blackTextColor,
                                    fontSize: AppSize.size16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.latoMedium,
                                  ) : const TextStyle(
                                    color: AppColors.smallTextColor,
                                    fontSize: AppSize.size14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.latoRegular,
                                  );

                                  return Center(
                                    child: Text(
                                      minutes.toString().padLeft(2, '0'),
                                      style: textStyle,
                                    ),
                                  );
                                },
                              ),
                            )),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: AppSize.size130,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: AppSize.size48,
                                  height: AppSize.size43,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => SizedBox(
                              width: AppSize.size48,
                              height: AppSize.size130,
                              child: PageView.builder(
                                itemCount: AppSize.two,
                                controller: PageController(
                                  viewportFraction: AppSize.zeroAndThirtyTwo,
                                  initialPage: scheduleARideController.currentPage.value,
                                ),
                                scrollDirection: Axis.vertical,
                                onPageChanged: (index) {
                                  scheduleARideController.currentPage.value = index;
                                },
                                itemBuilder: (context, index) {
                                  String timePeriod = (index == 0) ? AppStrings.am : AppStrings.pm;
                                  TextStyle textStyle = (index == scheduleARideController.currentPage.value)
                                      ? const TextStyle(
                                    color: AppColors.blackTextColor,
                                    fontSize: AppSize.size16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.latoMedium,
                                  ) : const TextStyle(
                                    color: AppColors.smallTextColor,
                                    fontSize: AppSize.size14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontFamily.latoRegular,
                                  );

                                  return Center(
                                    child: Text(
                                      timePeriod,
                                      style: textStyle,
                                    ),
                                  );
                                },
                              ),
                            )),
                          ],
                        ),
                      ],
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
                        AppStrings.confirm,
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