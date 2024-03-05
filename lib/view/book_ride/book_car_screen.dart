// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/book_car_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/select_route_with_map_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/cancel_car_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/driver_details_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/trip_to_destination_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';
import '../widget/discard_route_bottom_sheet.dart';

class BookCarScreen extends StatelessWidget {
  BookCarScreen({Key? key}) : super(key: key);

  SelectRouteWithMapController selectRouteWithMapController =
      Get.put(SelectRouteWithMapController());
  BookCarController bookCarController = Get.put(BookCarController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          body: Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.backGroundColor,
                appBar: _appBar(),
                body: _bookCarContent(context),
                bottomNavigationBar: _bookCarButton(context),
              ),
              Stack(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: bookCarController.isBookingOpen.value,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: AppSize.size255,
                          padding: const EdgeInsets.all(AppSize.size20),
                          decoration: const BoxDecoration(
                            color: AppColors.backGroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.size10),
                              topRight: Radius.circular(AppSize.size10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultTextStyle(
                                    style: TextStyle(
                                      fontFamily: FontFamily.latoBold,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppSize.size20,
                                      color: AppColors.blackTextColor,
                                    ),
                                    child: Text(
                                      AppStrings.searchingDriver,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (!bookCarController.isBookingOpen.value) {
                                        Get.back();
                                      } else {
                                        discardRouteBottomSheet(context);
                                      }
                                    },
                                    child: Image.asset(
                                      AppIcons.closeIcon2,
                                      width: AppSize.size18,
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: AppSize.size16,
                                ),
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontFamily: FontFamily.latoMedium,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSize.size14,
                                    color: AppColors.smallTextColor,
                                  ),
                                  child: Text(
                                    AppStrings.searchDriverString,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSize.size33,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    bookCarController.toggleDriver();
                                  },
                                  child: Image.asset(
                                    AppImages.searchDriver,
                                    width: AppSize.size110,
                                    height: AppSize.size97,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Visibility(
                      visible: bookCarController.isDriverSearch.value,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: AppSize.size255,
                          padding: const EdgeInsets.only(
                            left: AppSize.size20,
                            right: AppSize.size20,
                            top: AppSize.size10,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.backGroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.size10),
                              topRight: Radius.circular(AppSize.size10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                AppIcons.bottomSheetIcon,
                                width: AppSize.size40,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: AppSize.size20,
                                  bottom: AppSize.size5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        fontFamily: FontFamily.latoBold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppSize.size20,
                                        color: AppColors.blackTextColor,
                                      ),
                                      child: Text(
                                        AppStrings.driverIsArriving,
                                      ),
                                    ),
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        fontFamily: FontFamily.latoRegular,
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppSize.size14,
                                        color: AppColors.smallTextColor,
                                      ),
                                      child: Text(
                                        AppStrings.mins2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                                height: AppSize.size20,
                              ),
                              ListTile(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: AppSize.size6,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => DriverDetailsScreen());
                                      },
                                      child: const Text(
                                        AppStrings.driverDetails,
                                        style: TextStyle(
                                          fontSize: AppSize.size12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: FontFamily.latoRegular,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => DriverDetailsScreen());
                                    },
                                    child: Image.asset(
                                      AppIcons.rightArrowIcon2,
                                      width: AppSize.size14,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSize.size15,
                                ),
                                child: Row(
                                  children: [
                                    _customBookCarButton(
                                      BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.blackTextColor,
                                        ),
                                        borderRadius: BorderRadius.circular(AppSize.size10),
                                      ),
                                      AppStrings.cancel,
                                      AppColors.blackTextColor,
                                      () {
                                        Get.to(() => CancelCarScreen());
                                      },
                                    ),
                                    const SizedBox(
                                      width: AppSize.size16,
                                    ),
                                    _customBookCarButton(
                                      BoxDecoration(
                                        color: AppColors.blackTextColor,
                                        borderRadius: BorderRadius.circular(AppSize.size10),
                                      ),
                                      AppStrings.accept,
                                      AppColors.backGroundColor,
                                          () {
                                        Get.to(() => TripToDestinationScreen());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Book Car Content
  _appBar() {
    return AppBar(
      backgroundColor: AppColors.backGroundColor,
      elevation: AppSize.size0,
      automaticallyImplyLeading: false,
      title: Obx(() => Padding(
            padding:
                const EdgeInsets.only(left: AppSize.size5, top: AppSize.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (bookCarController.isDriverSearch.value) {
                      bookCarController.toggleDriver();
                    } else if (bookCarController.isBookingOpen.value) {
                      bookCarController.toggleBooking();
                    } else {
                      Get.back();
                    }
                  },
                  child: Image.asset(
                    AppIcons.arrowBack,
                    width: AppSize.size20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppSize.size12,right: AppSize.size12),
                  child: Text(
                    bookCarController.appBarTitle.value,
                    style: const TextStyle(
                      fontSize: AppSize.size20,
                      fontFamily: FontFamily.latoBold,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _bookCarContent(BuildContext context) {
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
        Positioned(
          right: AppSize.size20,
          bottom: AppSize.size31,
          child: Image.asset(
            AppIcons.gpsIcon,
            width: AppSize.size38,
          ),
        ),
      ],
    );
  }

  _bookCarButton(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppSize.size10),
        topRight: Radius.circular(AppSize.size10),
      ),
      child: Container(
        height: AppSize.size228,
        decoration: const BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.size10),
            topRight: Radius.circular(AppSize.size10),
          ),
        ),
        padding: const EdgeInsets.only(
          top: AppSize.size16,
          left: AppSize.size20,
          right: AppSize.size20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.fareHasBeenUpdated,
              style: TextStyle(
                fontSize: AppSize.size20,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.latoBold,
                color: AppColors.blackTextColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: AppSize.size16,
                bottom: AppSize.size30,
              ),
              child: Text(
                AppStrings.fareUpdateString,
                style: TextStyle(
                  fontSize: AppSize.size14,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.latoRegular,
                  color: AppColors.smallTextColor,
                ),
              ),
            ),
            Row(
              children: [
                _customBookCarButton(
                  BoxDecoration(
                    border: Border.all(
                      color: AppColors.blackTextColor,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.size10),
                  ),
                  AppStrings.cancel,
                  AppColors.blackTextColor,
                  () {
                    Get.to(() => CancelCarScreen());
                  },
                ),
                const SizedBox(
                  width: AppSize.size16,
                ),
                _customBookCarButton(
                  BoxDecoration(
                    color: AppColors.blackTextColor,
                    borderRadius: BorderRadius.circular(AppSize.size10),
                  ),
                  AppStrings.book,
                  AppColors.backGroundColor,
                  () {
                    bookCarController.toggleBooking();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _customBookCarButton(
      Decoration? decoration, String text, Color? textColor, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: AppSize.size54,
          margin: const EdgeInsets.only(
            top: AppSize.size12,
          ),
          decoration: decoration,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: AppSize.size16,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.latoSemiBold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
