// ignore_for_file: must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/book_ride_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/select_route_with_map_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/book_ride_full_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/auto_details_bottom_sheet.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/schedule_a_ride_bottom_sheet.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/select_payment_bottom_sheet.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class BookRideScreen extends StatelessWidget {
  BookRideScreen({Key? key}) : super(key: key);

  SelectRouteWithMapController selectRouteWithMapController =
      Get.put(SelectRouteWithMapController());
  BookRideController bookRideController = Get.put(BookRideController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    languageController.loadSelectedLanguage();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          body: _bookRideContent(context),
        ),
      ),
    );
  }

  //Book Ride Content
  _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: AppSize.size0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding:
            const EdgeInsets.only(left: AppSize.size5, top: AppSize.size10),
        child: Align(
          alignment: Alignment.topLeft,
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
      ),
    );
  }

  _bookRideContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: AppSize.size250,
          color: AppColors.backGroundColor,
          child: Obx(
            () => GoogleMap(
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(AppSize.latitude, AppSize.longitude72),
                zoom: AppSize.size13,
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
        _appBar(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: AppSize.size616,
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSize.size12,
                      right: AppSize.size20,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => BookRideFullScreen());
                        },
                        child: Image.asset(
                          AppIcons.fullScreenIcon,
                          width: AppSize.size38,
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(AppSize.size10),
                      topLeft: Radius.circular(AppSize.size10),
                    ),
                    child: Container(
                      height: AppSize.size560,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppSize.size10),
                          topLeft: Radius.circular(AppSize.size10),
                        ),
                        color: AppColors.backGroundColor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.backGroundColor,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.only(
                                  top: AppSize.size10,
                                  left: AppSize.size20,
                                  right: AppSize.size20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: AppSize.size20,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset(
                                          AppIcons.bottomSheetIcon,
                                          width: AppSize.size40,
                                        ),
                                      ),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppStrings.distance,
                                          style: TextStyle(
                                            fontFamily: FontFamily.latoBold,
                                            fontWeight: FontWeight.w700,
                                            fontSize: AppSize.size20,
                                            color: AppColors.blackTextColor,
                                          ),
                                        ),
                                        Text(
                                          AppStrings.km4point5,
                                          style: TextStyle(
                                            fontFamily: FontFamily.latoRegular,
                                            fontWeight: FontWeight.w400,
                                            fontSize: AppSize.size14,
                                            color: AppColors.blackTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: AppColors.smallTextColor
                                          .withOpacity(AppSize.opacity10),
                                      height: AppSize.size28,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          top: AppSize.size10,
                                        ),
                                        child: Obx(
                                          () => Stack(
                                            alignment:
                                                languageController.arb.value
                                                    ? Alignment.topRight
                                                    : Alignment.topLeft,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.backGroundColor,
                                                  border: Border.all(
                                                    color: AppColors
                                                        .smallTextColor
                                                        .withOpacity(
                                                            AppSize.opacity15),
                                                    width: AppSize.size1and5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSize.size10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      spreadRadius:
                                                          AppSize.size1,
                                                      color: AppColors
                                                          .blackTextColor
                                                          .withOpacity(AppSize
                                                              .opacity10),
                                                      blurRadius:
                                                          AppSize.size20,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      dense: true,
                                                      minLeadingWidth:
                                                          AppSize.size16,
                                                      leading: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: AppSize.size7,
                                                        ),
                                                        child: Container(
                                                          width: AppSize.size14,
                                                          height:
                                                              AppSize.size14,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.green,
                                                              width:
                                                                  AppSize.size1,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Container(
                                                              width:
                                                                  AppSize.size8,
                                                              height:
                                                                  AppSize.size8,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      title: TextField(
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          hintText: AppStrings
                                                              .yourLocation,
                                                          hintStyle: TextStyle(
                                                            fontSize:
                                                                AppSize.size14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily
                                                                    .latoRegular,
                                                            color: AppColors
                                                                .smallTextColor,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                        ),
                                                        style: const TextStyle(
                                                          fontSize:
                                                              AppSize.size14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: FontFamily
                                                              .latoRegular,
                                                          color: AppColors
                                                              .blackTextColor,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        cursorColor: AppColors
                                                            .smallTextColor,
                                                        controller:
                                                            bookRideController
                                                                .locationController,
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              languageController
                                                                      .arb.value
                                                                  ? 0
                                                                  : AppSize
                                                                      .size30,
                                                          right:
                                                              languageController
                                                                      .arb.value
                                                                  ? AppSize
                                                                      .size30
                                                                  : 0,
                                                        ),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          alignment:
                                                              WrapAlignment
                                                                  .center,
                                                          lineLength: kIsWeb
                                                              ? AppSize.size680
                                                              : AppSize.size255,
                                                          lineThickness:
                                                              AppSize.size1,
                                                          dashLength:
                                                              AppSize.size4,
                                                          dashColor: AppColors
                                                              .smallTextColor
                                                              .withOpacity(AppSize
                                                                  .opacity20),
                                                          dashRadius:
                                                              AppSize.size0,
                                                          dashGapLength:
                                                              AppSize.size4,
                                                          dashGapColor: Colors
                                                              .transparent,
                                                          dashGapRadius:
                                                              AppSize.size0,
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      dense: true,
                                                      minLeadingWidth:
                                                          AppSize.size16,
                                                      leading: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: AppSize.size6,
                                                        ),
                                                        child: Container(
                                                          width: AppSize.size14,
                                                          height:
                                                              AppSize.size14,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.yellow,
                                                              width:
                                                                  AppSize.size1,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Container(
                                                              width:
                                                                  AppSize.size8,
                                                              height:
                                                                  AppSize.size8,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      title: TextField(
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          hintText: AppStrings
                                                              .addStop,
                                                          hintStyle: TextStyle(
                                                            fontSize:
                                                                AppSize.size14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily
                                                                    .latoRegular,
                                                            color: AppColors
                                                                .smallTextColor,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                        ),
                                                        style: const TextStyle(
                                                          fontSize:
                                                              AppSize.size14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: FontFamily
                                                              .latoRegular,
                                                          color: AppColors
                                                              .blackTextColor,
                                                        ),
                                                        cursorColor: AppColors
                                                            .smallTextColor,
                                                        controller:
                                                            bookRideController
                                                                .addStopController,
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
                                                            left:
                                                                languageController
                                                                        .arb
                                                                        .value
                                                                    ? 0
                                                                    : AppSize
                                                                        .size30,
                                                            right:
                                                                languageController
                                                                        .arb
                                                                        .value
                                                                    ? AppSize
                                                                        .size30
                                                                    : 0),
                                                        child: DottedLine(
                                                          direction:
                                                              Axis.horizontal,
                                                          alignment:
                                                              WrapAlignment
                                                                  .center,
                                                          lineLength: kIsWeb
                                                              ? AppSize.size680
                                                              : AppSize.size255,
                                                          lineThickness:
                                                              AppSize.size1,
                                                          dashLength:
                                                              AppSize.size4,
                                                          dashColor: AppColors
                                                              .smallTextColor
                                                              .withOpacity(AppSize
                                                                  .opacity20),
                                                          dashRadius:
                                                              AppSize.size0,
                                                          dashGapLength:
                                                              AppSize.size4,
                                                          dashGapColor: Colors
                                                              .transparent,
                                                          dashGapRadius:
                                                              AppSize.size0,
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      dense: true,
                                                      minLeadingWidth:
                                                          AppSize.size16,
                                                      leading: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: AppSize.size6,
                                                        ),
                                                        child: Container(
                                                          width: AppSize.size14,
                                                          height:
                                                              AppSize.size14,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.yellow,
                                                              width:
                                                                  AppSize.size1,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Container(
                                                              width:
                                                                  AppSize.size8,
                                                              height:
                                                                  AppSize.size8,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      title: TextField(
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          hintText: AppStrings
                                                              .enterDestination,
                                                          hintStyle: TextStyle(
                                                            fontSize:
                                                                AppSize.size14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily
                                                                    .latoRegular,
                                                            color: AppColors
                                                                .smallTextColor,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                        ),
                                                        style: const TextStyle(
                                                          fontSize:
                                                              AppSize.size14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: FontFamily
                                                              .latoRegular,
                                                          color: AppColors
                                                              .blackTextColor,
                                                        ),
                                                        cursorColor: AppColors
                                                            .smallTextColor,
                                                        controller:
                                                            bookRideController
                                                                .destinationController,
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
                                                  left: languageController
                                                          .arb.value
                                                      ? 0
                                                      : AppSize.size23,
                                                  right: languageController
                                                          .arb.value
                                                      ? AppSize.size23
                                                      : 0,
                                                  top: AppSize.size45,
                                                ),
                                                child: Container(
                                                  width: AppSize.size1,
                                                  height: AppSize.size46,
                                                  color:
                                                      AppColors.smallTextColor,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: languageController
                                                          .arb.value
                                                      ? 0
                                                      : AppSize.size23,
                                                  right: languageController
                                                          .arb.value
                                                      ? AppSize.size23
                                                      : 0,
                                                  top: AppSize.size110,
                                                ),
                                                child: Container(
                                                  width: AppSize.size1,
                                                  height: AppSize.size46,
                                                  color:
                                                      AppColors.smallTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: AppSize.size24,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          scheduleARideBottomSheet(context);
                                        },
                                        child: Container(
                                          height: AppSize.size54,
                                          padding: const EdgeInsets.only(
                                            left: AppSize.size16,
                                            right: AppSize.size16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.backGroundColor,
                                            border: Border.all(
                                              color: AppColors.smallTextColor
                                                  .withOpacity(
                                                      AppSize.opacity15),
                                              width: AppSize.size1and5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                AppSize.size10),
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: AppSize.size1,
                                                color: AppColors.blackTextColor
                                                    .withOpacity(
                                                        AppSize.opacity10),
                                                blurRadius: AppSize.size20,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Obx(
                                                    () => Padding(
                                                      padding: EdgeInsets.only(
                                                        right:
                                                            languageController
                                                                    .arb.value
                                                                ? 0
                                                                : AppSize
                                                                    .size10,
                                                        left: languageController
                                                                .arb.value
                                                            ? AppSize.size10
                                                            : 0,
                                                      ),
                                                      child: Image.asset(
                                                        AppIcons.alarmIcon,
                                                        width: AppSize.size18,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    AppStrings.selectTime,
                                                    style: TextStyle(
                                                      fontSize: AppSize.size14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: FontFamily
                                                          .latoSemiBold,
                                                      color: AppColors
                                                          .blackTextColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Image.asset(
                                                AppIcons.rightArrowIcon,
                                                width: AppSize.size16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        top: AppSize.size20,
                                        bottom: AppSize.size16,
                                      ),
                                      child: Text(
                                        AppStrings.recommendedRides,
                                        style: TextStyle(
                                          fontFamily: FontFamily.latoBold,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppSize.size16,
                                          color: AppColors.blackTextColor,
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          bookRideController.rides.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: AppSize.size16,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.backGroundColor,
                                              border: Border.all(
                                                color: AppColors.smallTextColor
                                                    .withOpacity(
                                                        AppSize.opacity15),
                                                width: AppSize.size1and5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.size10),
                                              boxShadow: [
                                                BoxShadow(
                                                  spreadRadius:
                                                      AppSize.opacity10,
                                                  color: AppColors
                                                      .blackTextColor
                                                      .withOpacity(
                                                          AppSize.opacity10),
                                                  blurRadius: AppSize.size10,
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              horizontalTitleGap: AppSize.size7,
                                              dense: true,
                                              leading: Image.asset(
                                                bookRideController
                                                    .ridesImage[index],
                                                width: AppSize.size32,
                                              ),
                                              title: Text(
                                                bookRideController.rides[index],
                                                style: const TextStyle(
                                                  fontSize: AppSize.size14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      FontFamily.latoBold,
                                                  color:
                                                      AppColors.blackTextColor,
                                                ),
                                              ),
                                              subtitle: Text(
                                                bookRideController
                                                    .ridesSubtitle[index],
                                                style: const TextStyle(
                                                  fontSize: AppSize.size12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      FontFamily.latoRegular,
                                                  color:
                                                      AppColors.smallTextColor,
                                                ),
                                              ),
                                              trailing: index == 3
                                                  ? Image.asset(
                                                      AppIcons.rightArrowIcon,
                                                      width: AppSize.size16,
                                                    )
                                                  : SizedBox(
                                                      width: AppSize.size72,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          if (index == 0) ...[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: AppSize
                                                                    .size6,
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  autoDetailsBottomSheet(
                                                                      context);
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  AppIcons
                                                                      .infoIcon,
                                                                  width: AppSize
                                                                      .size14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                          Text(
                                                            bookRideController
                                                                    .ridesPrice[
                                                                index],
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  FontFamily
                                                                      .latoMedium,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: AppSize
                                                                  .size14,
                                                              color: AppColors
                                                                  .blackTextColor,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              bookRideController
                                                                  .selectInnerContainer(
                                                                      index);
                                                            },
                                                            child: Obx(
                                                                () => Container(
                                                                      width: AppSize
                                                                          .size16,
                                                                      height: AppSize
                                                                          .size16,
                                                                      margin: EdgeInsets.only(
                                                                          right: languageController.arb.value
                                                                              ? AppSize
                                                                                  .size8
                                                                              : 0,
                                                                          left: languageController.arb.value
                                                                              ? 0
                                                                              : AppSize.size8),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                        ),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: bookRideController.selectedInnerContainerIndex.value ==
                                                                              index
                                                                          ? Center(
                                                                              child: Container(
                                                                                width: AppSize.size8,
                                                                                height: AppSize.size8,
                                                                                decoration: const BoxDecoration(
                                                                                  color: AppColors.primaryColor,
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : null,
                                                                    )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: AppSize.size120,
                            color: AppColors.backGroundColor,
                            padding: const EdgeInsets.only(
                              top: AppSize.size16,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: AppSize.size8,left: AppSize.size8
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          selectPaymentBottomSheet(context);
                                        },
                                        child: Image.asset(
                                          AppIcons.walletIcon,
                                          width: AppSize.size16,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        selectPaymentBottomSheet(context);
                                      },
                                      child: const Text(
                                        AppStrings.selectPayment,
                                        style: TextStyle(
                                          fontSize: AppSize.size14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.latoSemiBold,
                                          color: AppColors.blackTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: AppSize.size54,
                                    margin: const EdgeInsets.only(
                                      top: AppSize.size12,
                                      left: AppSize.size20,
                                      right: AppSize.size20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.blackTextColor,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.size10),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
