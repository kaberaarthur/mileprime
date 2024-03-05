// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/my_rides_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/my_rides/my_rides_cancelled_details_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/my_rides/my_rides_active_details_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/my_rides/my_rides_completed_details_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/font_family.dart';

class MyRidesScreen extends StatelessWidget {
  MyRidesScreen({Key? key}) : super(key: key);

  MyRidesController myRidesController = Get.put(MyRidesController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          resizeToAvoidBottomInset: false,
          appBar: _appBar(),
          body: _myRidesContent(),
        ),
      ),
    );
  }

  //My Rides Content
  _appBar() {
    return AppBar(
      backgroundColor: AppColors.backGroundColor,
      elevation: AppSize.size0,
      automaticallyImplyLeading: false,
      title: Obx(() => Padding(
            padding:
                const EdgeInsets.only(left: AppSize.size5, top: AppSize.size10),
            child: !myRidesController.searchBoolean.value
                ? Row(
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
                        padding: EdgeInsets.only(
                            left: AppSize.size12, right: AppSize.size12),
                        child: Text(
                          AppStrings.myRides,
                          style: TextStyle(
                            fontSize: AppSize.size20,
                            fontFamily: FontFamily.latoBold,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : _searchTextField(),
          )),
      actions: [
        Obx(() => Padding(
              padding: const EdgeInsets.only(
                  top: AppSize.size10,
                  right: AppSize.size20,
                  left: AppSize.size20),
              child: !myRidesController.searchBoolean.value
                  ? GestureDetector(
                      onTap: () {
                        myRidesController.searchBoolean.value = true;
                      },
                      child: Image.asset(
                        AppIcons.search,
                        width: AppSize.size18,
                        color: AppColors.blackTextColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        myRidesController.searchBoolean.value = false;
                      },
                      child: Image.asset(
                        AppIcons.closeIcon2,
                        width: AppSize.size18,
                        color: AppColors.blackTextColor,
                      ),
                    ),
            )),
      ],
    );
  }

  _myRidesContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        right: AppSize.size20,
        left: AppSize.size20,
      ),
      child: Column(
        children: [
          _customRidesStatus(
            () {
              Get.to(() => MyRidesActiveDetailsScreen());
            },
            AppIcons.rikshaw2Icon,
            AppStrings.today1038AM,
            AppStrings.autoCRM,
            AppStrings.mapleAvenue2,
            AppStrings.meadowCountry2,
            AppStrings.active,
            AppColors.primaryColor,
            AppIcons.man1Icon,
          ),
          _customRidesStatus(
            () {
              Get.to(() => MyRidesCancelledDetailsScreen());
            },
            AppIcons.bike2Icon,
            AppStrings.thursdayNov7,
            AppStrings.bikeCRM,
            AppStrings.pineStreet,
            AppStrings.sereneValley,
            AppStrings.cancelled,
            AppColors.redColor,
            AppIcons.man2Icon,
          ),
          _customRidesStatus(
            () {
              Get.to(() => MyRidesCompletedDetailsScreen());
            },
            AppIcons.carModelIcon,
            AppStrings.sunday6,
            AppStrings.carCRM,
            AppStrings.willow777,
            AppStrings.meadowCountry2,
            AppStrings.completed,
            AppColors.parrotColor,
            AppIcons.man3Icon,
          ),
        ],
      ),
    );
  }

  _customRidesStatus(
      Function()? onTap,
      String rideImage,
      String dateText,
      String crmText,
      String address1,
      String address2,
      String rideStatus,
      Color statusColor,
      String riderImage) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSize.size24),
        padding: const EdgeInsets.only(
          left: AppSize.size16,
          top: AppSize.size16,
          right: AppSize.size16,
          bottom: AppSize.size16,
        ),
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.circular(AppSize.size10),
          border: Border.all(
            color: AppColors.smallTextColor.withOpacity(AppSize.opacity10),
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: AppSize.size2,
              color: AppColors.blackTextColor.withOpacity(AppSize.opacity10),
              blurRadius: AppSize.size20,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                            right: languageController.arb.value
                                ? 0
                                : AppSize.size8,
                            left: languageController.arb.value
                                ? AppSize.size8
                                : AppSize.size0),
                        child: Image.asset(
                          rideImage,
                          width: AppSize.size24,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSize.size6),
                          child: Text(
                            dateText,
                            style: const TextStyle(
                              fontSize: AppSize.size16,
                              fontFamily: FontFamily.latoBold,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackTextColor,
                            ),
                          ),
                        ),
                        Text(
                          crmText,
                          style: const TextStyle(
                            fontSize: AppSize.size12,
                            fontFamily: FontFamily.latoRegular,
                            fontWeight: FontWeight.w400,
                            color: AppColors.smallTextColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppSize.size16),
                          child: Row(
                            children: [
                              Obx(
                                () => Container(
                                  width: AppSize.size10,
                                  height: AppSize.size10,
                                  margin: EdgeInsets.only(
                                      right: languageController.arb.value
                                          ? 0
                                          : AppSize.size6,
                                      left: languageController.arb.value
                                          ? AppSize.size6
                                          : AppSize.size0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.greenColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: AppSize.size6,
                                      height: AppSize.size6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.greenColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppSize.size173,
                                child: Text(
                                  address1,
                                  style: const TextStyle(
                                    fontSize: AppSize.size12,
                                    fontFamily: FontFamily.latoRegular,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackTextColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => Container(
                            margin: EdgeInsets.only(
                                right: languageController.arb.value
                                    ? AppSize.size4
                                    : 0,
                                left: languageController.arb.value
                                    ? AppSize.size0
                                    : AppSize.size4),
                            height: AppSize.size12,
                            width: AppSize.size1,
                            color: AppColors.smallTextColor,
                          ),
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Container(
                                width: AppSize.size10,
                                height: AppSize.size10,
                                margin: EdgeInsets.only(
                                  left: languageController.arb.value
                                      ? AppSize.size6
                                      : 0,
                                  right: languageController.arb.value
                                      ? AppSize.size0
                                      : AppSize.size6,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.redColor,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: AppSize.size6,
                                    height: AppSize.size6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppSize.size173,
                              child: Text(
                                address2,
                                style: const TextStyle(
                                  fontSize: AppSize.size12,
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackTextColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      rideStatus,
                      style: TextStyle(
                        fontSize: AppSize.size12,
                        fontFamily: FontFamily.latoMedium,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppSize.size38),
                      child: Image.asset(
                        riderImage,
                        width: AppSize.size28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _searchTextField() {
    return const TextField(
      autofocus: true,
      cursorColor: AppColors.smallTextColor,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.latoRegular,
        fontSize: AppSize.size16,
        color: AppColors.blackTextColor,
      ),
      decoration: InputDecoration(
        hintText: AppStrings.searchHere,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.latoRegular,
          fontSize: AppSize.size16,
          color: AppColors.smallTextColor,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
