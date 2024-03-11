// ignore_for_file: must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/destination_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/home_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/destination/select_route_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/destination/select_route_with_map.dart';

class DestinationScreen extends StatelessWidget {
  DestinationScreen({Key? key}) : super(key: key);

  DestinationController destinationController =
      Get.put(DestinationController());
  HomeController homeController = Get.put(HomeController());
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
          body: _padding(),
          bottomNavigationBar: _locateOnMapButton(),
        ),
      ),
    );
  }

  //Destination Content
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
                destinationController.destinationController.clear();
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
                AppStrings.destination,
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

  _padding() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Stack(
              alignment: languageController.arb.value
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
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
                        spreadRadius: AppSize.size2,
                        color: AppColors.blackTextColor
                            .withOpacity(AppSize.opacity10),
                        blurRadius: AppSize.size24,
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
                          controller: destinationController.locationController,
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                              left: languageController.arb.value
                                  ? 0
                                  : AppSize.size30,
                              right: languageController.arb.value
                                  ? AppSize.size30
                                  : 0),
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
                              destinationController.destinationController,
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Get.to(() => SelectRouteScreen());
                          },
                          child: Container(
                            width: AppSize.size22,
                            height: AppSize.size22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backGroundColor,
                              border: Border.all(
                                color: AppColors.smallTextColor
                                    .withOpacity(AppSize.opacity10),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_rounded,
                                size: AppSize.size16,
                                color: AppColors.blackTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: languageController.arb.value ? 0 : AppSize.size23,
                    right: languageController.arb.value ? AppSize.size23 : 0,
                    top: AppSize.size3,
                  ),
                  child: Container(
                    width: 1,
                    height: AppSize.size39,
                    color: AppColors.smallTextColor,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: AppSize.size32,
            ),
            child: Text(
              AppStrings.popularPlaces,
              style: TextStyle(
                fontFamily: FontFamily.latoBold,
                fontWeight: FontWeight.w700,
                fontSize: AppSize.size16,
                color: AppColors.blackTextColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSize.size8,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: destinationController.destinationPlace.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  horizontalTitleGap: AppSize.size0,
                  visualDensity: const VisualDensity(vertical: AppSize.minus1),
                  title: Row(
                    children: [
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                              right: languageController.arb.value
                                  ? 0
                                  : AppSize.size6,
                              left: languageController.arb.value
                                  ? AppSize.size6
                                  : 0),
                          child: Image.asset(
                            AppIcons.mapIcon,
                            color: AppColors.smallTextColor,
                            width: AppSize.size14,
                          ),
                        ),
                      ),
                      Text(
                        destinationController.destinationPlace[index],
                        style: const TextStyle(
                          fontSize: AppSize.size14,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.latoMedium,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(
                      left: AppSize.size20,
                      top: AppSize.size8,
                    ),
                    child: Text(
                      destinationController.destinationAddressPlace[index],
                      style: const TextStyle(
                        fontSize: AppSize.size12,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.latoRegular,
                        color: AppColors.smallTextColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _locateOnMapButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.size20,
        right: AppSize.size20,
        bottom: AppSize.size20,
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SelectRouteWithMapScreen());
        },
        child: Container(
          height: AppSize.size46,
          decoration: BoxDecoration(
            color: AppColors.backGroundColor,
            borderRadius: BorderRadius.circular(AppSize.size10),
            border: Border.all(
              color: AppColors.smallTextColor.withOpacity(AppSize.opacity15),
              width: AppSize.size1,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: AppSize.size2,
                color: AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                blurRadius: AppSize.size24,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: AppSize.size4, left: AppSize.size4),
                child: Image.asset(
                  AppIcons.mapPointIcon,
                  width: AppSize.size14,
                ),
              ),
              const Text(
                AppStrings.locateOnMap,
                style: TextStyle(
                  fontFamily: FontFamily.latoRegular,
                  fontWeight: FontWeight.w400,
                  fontSize: AppSize.size12,
                  color: AppColors.blackTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
