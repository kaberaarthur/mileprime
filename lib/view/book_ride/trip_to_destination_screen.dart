// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/select_route_with_map_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/arrived_destination_popup.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';

class TripToDestinationScreen extends StatelessWidget {
  TripToDestinationScreen({Key? key}) : super(key: key);

  SelectRouteWithMapController selectRouteWithMapController =
      Get.put(SelectRouteWithMapController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    languageController.loadSelectedLanguage();
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          body: _tripToDestinationContent(context),
        ),
      ),
    );
  }

  _tripToDestinationContent(BuildContext context) {
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
          ),
        ),
        Positioned(
          left: AppSize.size20,
          top: AppSize.size48,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppIcons.arrowBack,
              width: AppSize.size20,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppSize.size20),
                child: Image.asset(
                  AppIcons.gpsIcon,
                  width: AppSize.size38,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: AppSize.size311,
                padding: const EdgeInsets.only(
                  top: AppSize.size10,
                  left: AppSize.size20,
                  right: AppSize.size20,
                ),
                margin: const EdgeInsets.only(top: AppSize.size20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.size12),
                    topRight: Radius.circular(AppSize.size12),
                  ),
                  color: AppColors.backGroundColor,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      AppIcons.bottomSheetIcon,
                      width: AppSize.size40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: AppSize.size20, bottom: AppSize.size16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.tripToDestination,
                            style: TextStyle(
                              fontSize: AppSize.size20,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontFamily.latoBold,
                              color: AppColors.blackTextColor,
                            ),
                          ),
                          Text(
                            AppStrings.km4point5,
                            style: TextStyle(
                              fontSize: AppSize.size14,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.latoRegular,
                              color: AppColors.smallTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColors.smallTextColor
                          .withOpacity(AppSize.opacity20),
                      height: AppSize.size0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppSize.size5, bottom: AppSize.size22),
                      child: ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const ArrivedDestinationPopup();
                            },
                          );
                        },
                        contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(
                          vertical: AppSize.minus1,
                        ),
                        dense: true,
                        horizontalTitleGap: AppSize.size3,
                        leading: Image.asset(
                          AppIcons.driverIcon,
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
                          AppStrings.carMercedes,
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
                    ),
                    Divider(
                      color: AppColors.smallTextColor
                          .withOpacity(AppSize.opacity20),
                      height: AppSize.size0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppSize.size18),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Padding(
                                      padding: EdgeInsets.only(
                                        right: languageController.arb.value
                                            ? 0
                                            : AppSize.size8,
                                        left: languageController.arb.value
                                            ? AppSize.size8
                                            : AppSize.size0,
                                      ),
                                      child: Image.asset(
                                        AppIcons.myLocationIcon,
                                        width: AppSize.size34,
                                      ),
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.myCurrentLocation,
                                        style: TextStyle(
                                          fontFamily: FontFamily.latoBold,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppSize.size14,
                                          color: AppColors.blackTextColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppSize.size6,
                                      ),
                                      Text(
                                        AppStrings.mapleAvenue,
                                        style: TextStyle(
                                          fontFamily: FontFamily.latoRegular,
                                          fontWeight: FontWeight.w400,
                                          fontSize: AppSize.size12,
                                          color: AppColors.smallTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Text(
                                AppStrings.km0,
                                style: TextStyle(
                                  fontFamily: FontFamily.latoRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSize.size12,
                                  color: AppColors.blackTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Align(
                        alignment: languageController.arb.value
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: languageController.arb.value
                                  ? AppSize.size16and5
                                  : 0,  left: languageController.arb.value
                                  ? AppSize.size0
                                  : AppSize.size16and5,
                              top: AppSize.size4,
                              bottom: AppSize.size4),
                          height: AppSize.size22,
                          width: AppSize.size1,
                          color: AppColors.smallTextColor,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(
                                      right: languageController.arb.value
                                          ? 0
                                          : AppSize.size8,
                                      left: languageController.arb.value
                                          ? AppSize.size8
                                          : AppSize.size0,
                                    ),
                                    child: Image.asset(
                                      AppIcons.locationPinIcon,
                                      width: AppSize.size34,
                                    ),
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.myDestination,
                                      style: TextStyle(
                                        fontFamily: FontFamily.latoBold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppSize.size14,
                                        color: AppColors.blackTextColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: AppSize.size6,
                                    ),
                                    Text(
                                      AppStrings.state26,
                                      style: TextStyle(
                                        fontFamily: FontFamily.latoRegular,
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppSize.size12,
                                        color: AppColors.smallTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Text(
                              AppStrings.km4point5,
                              style: TextStyle(
                                fontFamily: FontFamily.latoRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: AppSize.size12,
                                color: AppColors.blackTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
