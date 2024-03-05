// ignore_for_file: must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/select_route_with_map_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/book_ride_screen.dart';

import '../widget/discard_route_bottom_sheet.dart';

class SelectRouteWithMapScreen extends StatelessWidget {
  SelectRouteWithMapScreen({Key? key}) : super(key: key);

  SelectRouteWithMapController selectRouteWithMapController =
      Get.put(SelectRouteWithMapController());
  final LanguageController languageController = Get.put(LanguageController());

  void initializeList(BuildContext context) {
    selectRouteWithMapController.routeListTiles.assignAll([
      _buildListTile(
          AppStrings.yourLocation,
          Padding(
            padding: const EdgeInsets.only(
              top: AppSize.size7,
            ),
            child: Container(
              width: AppSize.size14,
              height: AppSize.size14,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greenColor,
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
          selectRouteWithMapController.locationController),
      _buildListTile(
          AppStrings.addStop,
          Padding(
            padding: const EdgeInsets.only(
              top: AppSize.size6,
            ),
            child: Obx(() {
              if (selectRouteWithMapController.isTimerElapsed.value) {
                return GestureDetector(
                  onTap: () {
                    discardRouteBottomSheet(context);
                  },
                  child: Image.asset(
                    AppIcons.closeIcon,
                    width: AppSize.size14,
                    height: AppSize.size14,
                  ),
                );
              } else {
                return Container(
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
                );
              }
            }),
          ),
          selectRouteWithMapController.addStopController),
      _buildListTile(
          AppStrings.enterDestination,
          Padding(
            padding: const EdgeInsets.only(
              top: AppSize.size6,
            ),
            child: Obx(() {
              if (selectRouteWithMapController.isTimerElapsed.value) {
                return GestureDetector(
                  onTap: () {
                    discardRouteBottomSheet(context);
                  },
                  child: Image.asset(
                    AppIcons.closeIcon,
                    width: AppSize.size14,
                    height: AppSize.size14,
                  ),
                );
              } else {
                return Container(
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
                );
              }
            }),
          ),
          selectRouteWithMapController.destinationController),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    initializeList(context);
    languageController.loadSelectedLanguage();
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          resizeToAvoidBottomInset: false,
          appBar: _appBar(),
          body: _routeMapContent(context),
          bottomNavigationBar: _bookRideButton(context),
        ),
      ),
    );
  }

  //Select Route with Map Content
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
                selectRouteWithMapController.showPolyline.value = false;
                selectRouteWithMapController.isTimerElapsed.value = false;
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

  _routeMapContent(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.backGroundColor,
            child: Obx(
              () => GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(AppSize.latitude, AppSize.longitude),
                  zoom: AppSize.size14,
                ),
                mapType: MapType.normal,
                markers: Set.from(selectRouteWithMapController.markers),
                polylines: selectRouteWithMapController.showPolyline.value
                    ? Set.from(selectRouteWithMapController.polylines)
                    : <Polyline>{},
                onMapCreated: (controller) {
                  selectRouteWithMapController.myMapController = controller;
                  selectRouteWithMapController.gMapsFunctionCall(
                      selectRouteWithMapController.initialLocation);
                },
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(
            top: AppSize.size12,
            left: AppSize.size20,
            right: AppSize.size20,
          ),
          child: Obx(() => Stack(
            alignment: languageController.arb.value
                ? Alignment.topRight
                : Alignment.topLeft,
            children: [
              Container(
                // height: AppSize.size173,
                decoration: BoxDecoration(
                  color: AppColors.backGroundColor,
                  border: Border.all(
                    color:
                    AppColors.smallTextColor.withOpacity(AppSize.opacity15),
                    width: AppSize.size1,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.size10),
                ),
                child: Obx(() => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    selectRouteWithMapController.routeListTiles[0],
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSize.size30,
                      ),
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
                    selectRouteWithMapController.routeListTiles[1],
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSize.size30,
                      ),
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
                    selectRouteWithMapController.routeListTiles[2],
                  ],
                )),
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
                padding:  EdgeInsets.only(
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
                right:languageController.arb.value?null: AppSize.size16,left:languageController.arb.value? AppSize.size16:null ,
                child: GestureDetector(
                  onTap: () {
                    selectRouteWithMapController.swapItems();
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
          ),)
        ),
      ],
    );
  }

  _bookRideButton(BuildContext context) {
    return Container(
      height: AppSize.size120,
      color: AppColors.backGroundColor,
      padding: const EdgeInsets.only(
        top: AppSize.size16,
      ),
      child: Column(
        children: [
          const Text(
            AppStrings.youCanSpendUp,
            style: TextStyle(
              fontSize: AppSize.size14,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.latoSemiBold,
              color: AppColors.blackTextColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              selectRouteWithMapController.addPolylineToDestination();
              Get.to(() => BookRideScreen());
            },
            child: Container(
              height: AppSize.size54,
              margin: const EdgeInsets.only(
                top: AppSize.size12,
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
        ],
      ),
    );
  }

  _buildListTile(
      String hintText, Widget leading, TextEditingController controller) {
    return ListTile(
      dense: true,
      minLeadingWidth: AppSize.size16,
      leading: leading,
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
