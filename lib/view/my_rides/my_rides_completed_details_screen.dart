// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/my_rides_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/driver_details_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/safety/safety_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';
import '../book_ride/book_ride_screen.dart';

class MyRidesCompletedDetailsScreen extends StatelessWidget {
  MyRidesCompletedDetailsScreen({Key? key}) : super(key: key);

  MyRidesController myRidesController = Get.put(MyRidesController());
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
          body: _myRidesCompletedDetailsContent(),
          bottomNavigationBar: _bottomButton(),
        ),
      ),
    );
  }

  //My Rides Completed Details Content
  _appBar() {
    return AppBar(
      scrolledUnderElevation: 0,
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
                AppStrings.car,
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

  _myRidesCompletedDetailsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
      ),
      child: Column(
        children: [
          Container(
            height: AppSize.size238,
            margin: const EdgeInsets.only(bottom: AppSize.size24),
            child: Obx(
              () => GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(AppSize.latitude, AppSize.longitude),
                  zoom: AppSize.size15,
                ),
                mapType: MapType.normal,
                markers: Set.from(myRidesController.markers),
                onMapCreated: (controller) {
                  myRidesController.myMapController = controller;
                  myRidesController
                      .gMapsFunctionCall(myRidesController.initialLocation);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: AppSize.size20, right: AppSize.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              AppIcons.carModelIcon,
                              width: AppSize.size24,
                            ),
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: AppSize.size6),
                              child: Text(
                                AppStrings.sundayNov6,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.latoBold,
                                  fontSize: AppSize.size16,
                                  color: AppColors.blackTextColor,
                                ),
                              ),
                            ),
                            Text(
                              AppStrings.carCRM,
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
                    const Text(
                      AppStrings.completed,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.latoMedium,
                        fontSize: AppSize.size12,
                        color: AppColors.parrotColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.size24, bottom: AppSize.size24),
                  child: Divider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size0,
                  ),
                ),
                Row(
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
                    const Text(
                      AppStrings.willow777,
                      style: TextStyle(
                        fontSize: AppSize.size12,
                        fontFamily: FontFamily.latoRegular,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.only(
                        left: languageController.arb.value ? 0 : AppSize.size4,
                        right: languageController.arb.value
                            ? AppSize.size4
                            : AppSize.size0),
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
                            right: languageController.arb.value
                                ? 0
                                : AppSize.size6,
                            left: languageController.arb.value
                                ? AppSize.size6
                                : AppSize.size0),
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
                    const Text(
                      AppStrings.meadowCountry2,
                      style: TextStyle(
                        fontSize: AppSize.size12,
                        fontFamily: FontFamily.latoRegular,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.size24, bottom: AppSize.size16),
                  child: Divider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size0,
                  ),
                ),
                Container(
                  height: AppSize.size115,
                  padding: const EdgeInsets.only(
                    left: AppSize.size28,
                    right: AppSize.size28,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColor,
                    borderRadius: BorderRadius.circular(AppSize.size10),
                    border: Border.all(
                      color: AppColors.smallTextColor
                          .withOpacity(AppSize.opacity15),
                      width: AppSize.size1and5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: AppSize.size1,
                        color: AppColors.blackTextColor
                            .withOpacity(AppSize.opacity10),
                        blurRadius: AppSize.size17,
                      ),
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _customDetails(AppIcons.dollarIcon, AppStrings.dollar78,
                            AppStrings.rideFare),
                        VerticalDivider(
                          color: AppColors.smallTextColor
                              .withOpacity(AppSize.opacity20),
                          indent: AppSize.size28,
                          endIndent: AppSize.size28,
                        ),
                        _customDetails(AppIcons.tripIcon, AppStrings.trip1,
                            AppStrings.trip),
                        VerticalDivider(
                          color: AppColors.smallTextColor
                              .withOpacity(AppSize.opacity20),
                          indent: AppSize.size28,
                          endIndent: AppSize.size28,
                        ),
                        _customDetails(AppIcons.yearIcon, AppStrings.minute2,
                            AppStrings.tripTime),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: AppSize.size16),
                  height: AppSize.size173,
                  padding: const EdgeInsets.only(
                    top: AppSize.size16,
                    left: AppSize.size16,
                    right: AppSize.size16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColor,
                    borderRadius: BorderRadius.circular(AppSize.size10),
                    border: Border.all(
                      color: AppColors.smallTextColor
                          .withOpacity(AppSize.opacity15),
                      width: AppSize.size1and5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: AppSize.size1,
                        color: AppColors.blackTextColor
                            .withOpacity(AppSize.opacity10),
                        blurRadius: AppSize.size17,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(
                                  right: languageController.arb.value
                                      ? 0
                                      : AppSize.size10,
                                  left: languageController.arb.value
                                      ? AppSize.size10
                                      : AppSize.size0),
                              child: Image.asset(
                                AppIcons.scooterIcon,
                                width: AppSize.size28,
                              ),
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: AppSize.size4),
                                child: Text(
                                  AppStrings.confirmedRide,
                                  style: TextStyle(
                                    fontSize: AppSize.size14,
                                    fontFamily: FontFamily.latoMedium,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackTextColor,
                                  ),
                                ),
                              ),
                              Text(
                                AppStrings.wed08,
                                style: TextStyle(
                                  fontSize: AppSize.size12,
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.smallTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Container(
                              margin: EdgeInsets.only(
                                  left: languageController.arb.value
                                      ? AppSize.size24
                                      : AppSize.size13,
                                  right: languageController.arb.value
                                      ? AppSize.size13
                                      : AppSize.size24),
                              height: AppSize.size65,
                              width: AppSize.size1,
                              color: AppColors.blackTextColor,
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: AppSize.size4),
                                child: Text(
                                  AppStrings.driverArrived,
                                  style: TextStyle(
                                    fontSize: AppSize.size14,
                                    fontFamily: FontFamily.latoMedium,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackTextColor,
                                  ),
                                ),
                              ),
                              Text(
                                AppStrings.wed08,
                                style: TextStyle(
                                  fontSize: AppSize.size12,
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.smallTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(
                                  right: languageController.arb.value
                                      ? 0
                                      : AppSize.size10,
                                  left: languageController.arb.value
                                      ? AppSize.size10
                                      : AppSize.size0),
                              child: Image.asset(
                                AppIcons.doneBlackIcon,
                                width: AppSize.size28,
                              ),
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: AppSize.size4),
                                child: Text(
                                  AppStrings.completedTrip,
                                  style: TextStyle(
                                    fontSize: AppSize.size14,
                                    fontFamily: FontFamily.latoMedium,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackTextColor,
                                  ),
                                ),
                              ),
                              Text(
                                AppStrings.wed08,
                                style: TextStyle(
                                  fontSize: AppSize.size12,
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.smallTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: AppSize.size16),
                  height: AppSize.size115,
                  padding: const EdgeInsets.only(
                    top: AppSize.size10,
                    left: AppSize.size16,
                    right: AppSize.size16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColor,
                    borderRadius: BorderRadius.circular(AppSize.size10),
                    border: Border.all(
                      color: AppColors.smallTextColor
                          .withOpacity(AppSize.opacity15),
                      width: AppSize.size1and5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: AppSize.size1,
                        color: AppColors.blackTextColor
                            .withOpacity(AppSize.opacity10),
                        blurRadius: AppSize.size17,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(
                          vertical: AppSize.minus1,
                        ),
                        dense: true,
                        horizontalTitleGap: AppSize.size3,
                        leading: Image.asset(
                          AppIcons.man3Icon,
                          width: AppSize.size34,
                        ),
                        title: const Text(
                          AppStrings.deirdreRaja,
                          style: TextStyle(
                            fontSize: AppSize.size16,
                            fontWeight: FontWeight.w700,
                            fontFamily: FontFamily.latoBold,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                        subtitle: const Text(
                          AppStrings.miniCRM,
                          style: TextStyle(
                            fontSize: AppSize.size12,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.latoRegular,
                            color: AppColors.smallTextColor,
                          ),
                        ),
                        trailing: SizedBox(
                          width: AppSize.size65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: AppSize.size3,
                                    ),
                                    child: Image.asset(
                                      AppIcons.starIcon,
                                      width: AppSize.size14,
                                    ),
                                  ),
                                  const Text(
                                    AppStrings.like1and6,
                                    style: TextStyle(
                                      fontSize: AppSize.size12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.latoRegular,
                                      color: AppColors.smallTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: AppSize.size6,
                                ),
                                child: Text(
                                  AppStrings.carNumber,
                                  style: TextStyle(
                                    fontSize: AppSize.size12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.latoBold,
                                    color: AppColors.blackTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppSize.size5, bottom: AppSize.size10),
                        child: Divider(
                          color: AppColors.smallTextColor
                              .withOpacity(AppSize.opacity20),
                          height: AppSize.size0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => DriverDetailsScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  right: AppSize.size6, left: AppSize.size6),
                              child: Text(
                                AppStrings.driverDetails,
                                style: TextStyle(
                                  fontSize: AppSize.size14,
                                  fontFamily: FontFamily.latoMedium,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppIcons.rightArrowIcon2,
                              width: AppSize.size14,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  SafetyScreen());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: AppSize.size16, bottom: AppSize.size24),
                    height: AppSize.size54,
                    padding: const EdgeInsets.only(
                      left: AppSize.size16,
                      right: AppSize.size16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backGroundColor,
                      borderRadius: BorderRadius.circular(AppSize.size10),
                      border: Border.all(
                        color: AppColors.smallTextColor
                            .withOpacity(AppSize.opacity15),
                        width: AppSize.size1and5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: AppSize.size1,
                          color: AppColors.blackTextColor
                              .withOpacity(AppSize.opacity10),
                          blurRadius: AppSize.size17,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(
                                    right: languageController.arb.value
                                        ? 0
                                        : AppSize.size10,
                                    left: languageController.arb.value
                                        ? AppSize.size10
                                        : AppSize.size0),
                                child: Image.asset(
                                  AppIcons.helpIcon,
                                  width: AppSize.size18,
                                ),
                              ),
                            ),
                            const Text(
                              AppStrings.getHelp,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamily.latoSemiBold,
                                fontSize: AppSize.size14,
                                color: AppColors.blackTextColor,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          AppIcons.rightArrowIcon,
                          width: AppSize.size18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _bottomButton() {
    return Container(
      height: AppSize.size100,
      color: AppColors.backGroundColor,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Get.to(() => BookRideScreen());
          },
          child: Container(
            height: AppSize.size54,
            margin: const EdgeInsets.only(
              left: AppSize.size20,
              right: AppSize.size20,
            ),
            decoration: BoxDecoration(
              color: AppColors.blackTextColor,
              borderRadius: BorderRadius.circular(AppSize.size10),
            ),
            child: const Center(
              child: Text(
                AppStrings.bookRide,
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
    );
  }

  _customDetails(String image, String text1, String text2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: AppSize.size38,
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSize.size8),
          child: Text(
            text1,
            style: const TextStyle(
              fontSize: AppSize.size16,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.latoBold,
              color: AppColors.blackTextColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSize.size4),
          child: Text(
            text2,
            style: const TextStyle(
              fontSize: AppSize.size12,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.latoRegular,
              color: AppColors.smallTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
