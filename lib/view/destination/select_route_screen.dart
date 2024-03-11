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
import 'package:prime_taxi_flutter_ui_kit/view/destination/select_route_with_map.dart';

class SelectRouteScreen extends StatelessWidget {
  SelectRouteScreen({Key? key}) : super(key: key);

  DestinationController destinationController =
      Get.put(DestinationController());
  HomeController homeController = Get.put(HomeController());
  final LanguageController languageController = Get.put(LanguageController());

  void initializeList() {
    destinationController.routeListTiles.assignAll([
      _buildListTile(Colors.green, AppStrings.yourLocation,
          destinationController.locationController),
      _buildListTile(Colors.yellow, AppStrings.addStop,
          destinationController.addStopController),
      _buildListTile(Colors.yellow, AppStrings.enterDestination,
          destinationController.destinationController),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    initializeList();
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

  //Select Route Content
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
                destinationController.addStopController.clear();
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
                AppStrings.selectRoute,
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
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
                          spreadRadius: AppSize.size2,
                          color: AppColors.blackTextColor
                              .withOpacity(AppSize.opacity10),
                          blurRadius: AppSize.size24,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Obx(() => Column(
                              children: [
                                destinationController.routeListTiles[0],
                                _buildDivider(),
                                destinationController.routeListTiles[1],
                                _buildDivider(),
                                destinationController.routeListTiles[2],
                              ],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: languageController.arb.value ? 0 : AppSize.size23,
                      right: languageController.arb.value
                          ? AppSize.size23
                          : AppSize.size0,
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
                      right: languageController.arb.value
                          ? AppSize.size23
                          : AppSize.size0,
                      top: AppSize.size110,
                    ),
                    child: Container(
                      width: AppSize.size1,
                      height: AppSize.size46,
                      color: AppColors.smallTextColor,
                    ),
                  ),
                  Positioned(
                    bottom: AppSize.size55,
                    left: languageController.arb.value ? AppSize.size16 : null,
                    right: languageController.arb.value ? null : AppSize.size16,
                    child: GestureDetector(
                      onTap: () {
                        destinationController.swapItems();
                      },
                      child: Container(
                        width: AppSize.size22,
                        height: AppSize.size22,
                        decoration: BoxDecoration(
                          color: AppColors.backGroundColor,
                          border: Border.all(
                            color: AppColors.smallTextColor
                                .withOpacity(AppSize.opacity10),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppIcons.swapIcon,
                            width: AppSize.size14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppSize.size25,
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
                    visualDensity:
                        const VisualDensity(vertical: AppSize.minus1),
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
                                  : 0,
                            ),
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

  _buildDivider() {
    return Obx(() => Padding(
          padding: EdgeInsets.only(
            left: languageController.arb.value ? 0 : AppSize.size30,
            right:
                languageController.arb.value ? AppSize.size30 : AppSize.size0,
          ),
          child: DottedLine(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            lineLength: kIsWeb ? AppSize.size680 : AppSize.size255,
            lineThickness: AppSize.size1,
            dashLength: AppSize.size4,
            dashColor: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
            dashRadius: AppSize.size0,
            dashGapLength: AppSize.size4,
            dashGapColor: Colors.transparent,
            dashGapRadius: AppSize.size0,
          ),
        ));
  }

  _buildListTile(
      Color color, String hintText, TextEditingController controller) {
    return ListTile(
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
              color: color,
              width: AppSize.size1,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: AppSize.size8,
              height: AppSize.size8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
      title: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: AppSize.size14,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.latoRegular,
            color: AppColors.smallTextColor,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
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
        controller: controller,
      ),
    );
  }
}
