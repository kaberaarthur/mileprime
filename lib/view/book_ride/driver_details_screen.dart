// ignore_for_file: must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/driver_details_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/call_with_driver_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/chat_with_driver_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/trip_to_destination_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class DriverDetailsScreen extends StatelessWidget {
  DriverDetailsScreen({Key? key}) : super(key: key);
  final LanguageController languageController = Get.put(LanguageController());
  DriverDetailsController driverDetailsController =
      Get.put(DriverDetailsController());

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
          body: _driverDetailsContent(),
          bottomNavigationBar: _bottomBarButton(context),
        ),
      ),
    );
  }

  //Driver Details Content
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
                AppStrings.driverDetails,
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

  _driverDetailsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.size34,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppIcons.driverIcon,
              width: AppSize.size84,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: AppSize.size12),
            child: Text(
              AppStrings.deirdreRaja,
              style: TextStyle(
                fontFamily: FontFamily.latoBold,
                fontWeight: FontWeight.w700,
                fontSize: AppSize.size20,
                color: AppColors.blackTextColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                msg: AppStrings.numberCopied,
                backgroundColor: AppColors.lightTheme,
                textColor: AppColors.blackTextColor,
                fontSize: AppSize.size14,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT,
              );
            },
            child: Container(
              height: AppSize.size34,
              width: AppSize.size171,
              margin: const EdgeInsets.only(top: AppSize.size16),
              decoration: BoxDecoration(
                color: AppColors.lightTheme,
                borderRadius: BorderRadius.circular(AppSize.size3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                          right:
                              languageController.arb.value ? 0 : AppSize.size12,
                          left: languageController.arb.value
                              ? AppSize.size12
                              : AppSize.size0),
                      child: const Text(
                        AppStrings.driverNumber,
                        style: TextStyle(
                          fontFamily: FontFamily.latoBold,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSize.size14,
                          color: AppColors.blackTextColor,
                        ),
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
          Container(
            height: AppSize.size115,
            margin: const EdgeInsets.only(top: AppSize.size24),
            padding: const EdgeInsets.only(
              left: AppSize.size24,
              right: AppSize.size24,
            ),
            decoration: BoxDecoration(
              color: AppColors.backGroundColor,
              borderRadius: BorderRadius.circular(AppSize.size10),
              border: Border.all(
                color: AppColors.smallTextColor.withOpacity(AppSize.opacity15),
                width: AppSize.size1and5,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: AppSize.size1,
                  color:
                      AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                  blurRadius: AppSize.size20,
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customDetails(AppIcons.ratingIcon, AppStrings.like1and6,
                      AppStrings.rating),
                  VerticalDivider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    indent: AppSize.size28,
                    endIndent: AppSize.size28,
                  ),
                  _customDetails(AppIcons.tripIcon, AppStrings.number578,
                      AppStrings.trips),
                  VerticalDivider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    indent: AppSize.size28,
                    endIndent: AppSize.size28,
                  ),
                  _customDetails(
                      AppIcons.yearIcon, AppStrings.number8, AppStrings.years),
                ],
              ),
            ),
          ),
          Container(
            height: AppSize.size137,
            margin: const EdgeInsets.only(top: AppSize.size16),
            padding: const EdgeInsets.only(
              left: AppSize.size16,
              right: AppSize.size16,
              top: AppSize.size16,
              bottom: AppSize.size16,
            ),
            decoration: BoxDecoration(
              color: AppColors.backGroundColor,
              borderRadius: BorderRadius.circular(AppSize.size10),
              border: Border.all(
                color: AppColors.smallTextColor.withOpacity(AppSize.opacity15),
                width: AppSize.size1and5,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: AppSize.size1,
                  color:
                      AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                  blurRadius: AppSize.size20,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _customCarDetails(AppStrings.memberSince, AppStrings.july15),
                _customCarDetails(AppStrings.carModel, AppStrings.mercedesBenz),
                _customCarDetails(AppStrings.plateNumber, AppStrings.carNumber),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: AppSize.size24,
                bottom: AppSize.size24,
              ),
              child: Obx(
                () => Stack(
                  alignment: languageController.arb.value
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        border: Border.all(
                          color: AppColors.smallTextColor
                              .withOpacity(AppSize.opacity15),
                          width: AppSize.size1and5,
                        ),
                        borderRadius: BorderRadius.circular(AppSize.size10),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: AppSize.size1,
                            color: AppColors.blackTextColor
                                .withOpacity(AppSize.opacity10),
                            blurRadius: AppSize.size20,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            minLeadingWidth: AppSize.size16,
                            leading: Padding(
                              padding: const EdgeInsets.only(
                                top: AppSize.size7,
                              ),
                              child: Container(
                                width: AppSize.size14,
                                height: AppSize.size14,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: AppSize.size1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: AppSize.size8,
                                    height: AppSize.size8,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: TextField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: AppStrings.yourLocation,
                                hintStyle: TextStyle(
                                  fontSize: AppSize.size14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.latoRegular,
                                  color: AppColors.smallTextColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: AppSize.size14,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.latoRegular,
                                color: AppColors.blackTextColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                              cursorColor: AppColors.smallTextColor,
                              controller:
                                  driverDetailsController.locationController,
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(
                                  left: languageController.arb.value
                                      ? AppSize.size0
                                      : AppSize.size30,
                                  right: languageController.arb.value
                                      ? AppSize.size30
                                      : AppSize.size0),
                              child: DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength:
                                    kIsWeb ? AppSize.size680 : AppSize.size255,
                                lineThickness: AppSize.size1,
                                dashLength: AppSize.size4,
                                dashColor: AppColors.smallTextColor
                                    .withOpacity(AppSize.opacity20),
                                dashRadius: AppSize.size0,
                                dashGapLength: AppSize.size4,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: AppSize.size0,
                              ),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            minLeadingWidth: AppSize.size16,
                            leading: Padding(
                              padding: const EdgeInsets.only(
                                top: AppSize.size6,
                              ),
                              child: Container(
                                width: AppSize.size14,
                                height: AppSize.size14,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow,
                                    width: AppSize.size1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: AppSize.size8,
                                    height: AppSize.size8,
                                    decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: TextField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: AppStrings.addStop,
                                hintStyle: TextStyle(
                                  fontSize: AppSize.size14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.latoRegular,
                                  color: AppColors.smallTextColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: AppSize.size14,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.latoRegular,
                                color: AppColors.blackTextColor,
                              ),
                              cursorColor: AppColors.smallTextColor,
                              controller:
                                  driverDetailsController.addStopController,
                            ),
                            trailing: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                AppIcons.editIcon,
                                width: AppSize.size16,
                              ),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(
                                  left: languageController.arb.value
                                      ? AppSize.size0
                                      : AppSize.size30,
                                  right: languageController.arb.value
                                      ? AppSize.size30
                                      : AppSize.size0),
                              child: DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength:
                                    kIsWeb ? AppSize.size680 : AppSize.size255,
                                lineThickness: AppSize.size1,
                                dashLength: AppSize.size4,
                                dashColor: AppColors.smallTextColor
                                    .withOpacity(AppSize.opacity20),
                                dashRadius: AppSize.size0,
                                dashGapLength: AppSize.size4,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: AppSize.size0,
                              ),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            minLeadingWidth: AppSize.size16,
                            leading: Padding(
                              padding: const EdgeInsets.only(
                                top: AppSize.size6,
                              ),
                              child: Container(
                                width: AppSize.size14,
                                height: AppSize.size14,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow,
                                    width: AppSize.size1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: AppSize.size8,
                                    height: AppSize.size8,
                                    decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: TextField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: AppStrings.enterDestination,
                                hintStyle: TextStyle(
                                  fontSize: AppSize.size14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.latoRegular,
                                  color: AppColors.smallTextColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: AppSize.size14,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.latoRegular,
                                color: AppColors.blackTextColor,
                              ),
                              cursorColor: AppColors.smallTextColor,
                              controller:
                                  driverDetailsController.destinationController,
                            ),
                            trailing: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                AppIcons.editIcon,
                                width: AppSize.size16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: languageController.arb.value ? 0 : AppSize.size23,
                        right:
                            languageController.arb.value ? AppSize.size23 : 0,
                        top: AppSize.size45,
                      ),
                      child: Container(
                        width: AppSize.size1,
                        height: AppSize.size46,
                        color: AppColors.smallTextColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: languageController.arb.value ? 0 : AppSize.size23,
                        right:
                            languageController.arb.value ? AppSize.size23 : 0,
                        top: AppSize.size110,
                      ),
                      child: Container(
                        width: AppSize.size1,
                        height: AppSize.size46,
                        color: AppColors.smallTextColor,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  _bottomBarButton(BuildContext context) {
    return Container(
      height: AppSize.size156,
      color: AppColors.backGroundColor,
      padding: const EdgeInsets.only(
        top: AppSize.size16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.closeIcon3,
                width: AppSize.size46,
              ),
              const SizedBox(
                width: AppSize.size16,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ChatWithDriverScreen());
                },
                child: Image.asset(
                  AppIcons.messageIcon,
                  width: AppSize.size46,
                ),
              ),
              const SizedBox(
                width: AppSize.size16,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => CallWithDriverScreen());
                },
                child: Image.asset(
                  AppIcons.callingIcon,
                  width: AppSize.size46,
                ),
              ),
              const SizedBox(
                width: AppSize.size16,
              ),
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: AppStrings.detailsShared,
                    backgroundColor: AppColors.lightTheme,
                    textColor: AppColors.blackTextColor,
                    fontSize: AppSize.size14,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                },
                child: Image.asset(
                  AppIcons.shareIcon,
                  width: AppSize.size46,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => TripToDestinationScreen());
            },
            child: Container(
              height: AppSize.size54,
              margin: const EdgeInsets.only(
                top: AppSize.size16,
                left: AppSize.size20,
                right: AppSize.size20,
              ),
              decoration: BoxDecoration(
                color: AppColors.blackTextColor,
                borderRadius: BorderRadius.circular(AppSize.size10),
              ),
              child: const Center(
                child: Text(
                  AppStrings.continueButton,
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
        ],
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

  _customCarDetails(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: AppSize.size14,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.latoRegular,
            color: AppColors.smallTextColor,
          ),
        ),
        Text(
          text2,
          style: const TextStyle(
            fontSize: AppSize.size16,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.latoBold,
            color: AppColors.blackTextColor,
          ),
        ),
      ],
    );
  }
}
