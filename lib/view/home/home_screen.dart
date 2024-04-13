import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_height_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_width_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/home_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/destination/destination_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/places_destination/places_destination_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/my_rides/my_rides_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/payments/payments_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/profile/profile_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/car_info/car_info_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/safety/safety_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/save_locations/save_locations_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/settings/settings_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/split_screen/split_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/logout_bottom_sheet.dart';
import 'package:geolocator/geolocator.dart';

import '../../common_widgets/common_text_feild.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    languageController.loadSelectedLanguage();
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          drawer: Drawer(
            shape: const RoundedRectangleBorder(),
            width: AppSize.size250,
            backgroundColor: AppColors.backGroundColor,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: AppSize.size73,
                      width: AppSize.size76,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          AppImages.menuBarImage,
                        ),
                        fit: BoxFit.fill,
                      )),
                    )),
                const CommonHeightSizedBox(height: AppSize.size12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSize.size20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: AppSize.size66,
                            spreadRadius: AppSize.size0,
                          )
                        ],
                        color: AppColors.backGroundColor,
                        borderRadius: BorderRadius.circular(AppSize.size10)),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSize.size12),
                      child: Row(
                        children: [
                          Container(
                            height: AppSize.size40,
                            width: AppSize.size40,
                            decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                shape: BoxShape.circle),
                            child: const Center(
                              child: Text(
                                AppStrings.ar,
                                style: TextStyle(
                                  color: AppColors.blackTextColor,
                                  fontFamily: FontFamily.latoBold,
                                  fontSize: AppSize.size14,
                                ),
                              ),
                            ),
                          ),
                          const CommonWidthSizedBox(width: AppSize.size10),
                          const Column(
                            children: [
                              Text(
                                AppStrings.helloAlbert,
                                style: TextStyle(
                                  color: AppColors.blackTextColor,
                                  fontFamily: FontFamily.latoBold,
                                  fontSize: AppSize.size16,
                                ),
                              ),
                              CommonHeightSizedBox(height: AppSize.size6),
                              Text(
                                AppStrings.demoMobile,
                                style: TextStyle(
                                  color: AppColors.smallTextColor,
                                  fontFamily: FontFamily.latoRegular,
                                  fontSize: AppSize.size12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const CommonHeightSizedBox(height: AppSize.size34),
                _buildProfile(),
                const CommonHeightSizedBox(height: AppSize.size34),
                _buildSplit(),
                const CommonHeightSizedBox(height: AppSize.size24),
                _buildMyRides(),
                const CommonHeightSizedBox(height: AppSize.size24),
                _buildPayments(),
                const CommonHeightSizedBox(height: AppSize.size24),
                _buildSaveLocations(),
                const CommonHeightSizedBox(height: AppSize.size24),
                _buildSafety(),
                const CommonHeightSizedBox(height: AppSize.size24),
                _buildCarInfo(),
                const CommonHeightSizedBox(height: AppSize.size24),
                _buildSetting(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.size32, vertical: AppSize.size40),
                  child: Divider(
                    height: AppSize.size0,
                    color: AppColors.dividerColor,
                    thickness: AppSize.size1,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSize.size32),
                  child: GestureDetector(
                    onTap: () {
                      logoutBottomSheet(context);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          AppIcons.logOut,
                          height: AppSize.size16,
                          width: AppSize.size16,
                        ),
                        const CommonWidthSizedBox(width: AppSize.size6),
                        const Text(
                          AppStrings.logOut,
                          style: TextStyle(
                            color: AppColors.redColor,
                            fontFamily: FontFamily.latoSemiBold,
                            fontSize: AppSize.size16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.backGroundColor,
                        child: Obx(
                          () => GoogleMap(
                            myLocationEnabled: false,
                            myLocationButtonEnabled: true,
                            zoomControlsEnabled: false,
                            initialCameraPosition: const CameraPosition(
                              target:
                                  LatLng(AppSize.latitude, AppSize.longitude),
                              zoom: AppSize.size14,
                            ),
                            mapType: MapType.normal,
                            markers: Set.from(homeController.markers),
                            onMapCreated: (controller) {
                              homeController.gMapsFunctionCall(
                                  homeController.initialLocation);
                            },
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          right: AppSize.size20,
                          left: AppSize.size20),
                      child: Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: AppSize.size12),
                              child: Builder(
                                builder: (BuildContext builderContext) {
                                  return GestureDetector(
                                    onTap: () {
                                      Scaffold.of(builderContext).openDrawer();
                                    },
                                    child: Container(
                                      height: AppSize.size46,
                                      width: AppSize.size46,
                                      decoration: BoxDecoration(
                                          color: AppColors.backGroundColor,
                                          borderRadius: BorderRadius.circular(
                                              AppSize.size10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.shadow,
                                              blurRadius: AppSize.size66,
                                              spreadRadius: AppSize.size0,
                                            )
                                          ]),
                                      child: Center(
                                          child: Image.asset(
                                        AppIcons.drawerIcon,
                                        height: AppSize.size20,
                                        width: AppSize.size20,
                                      )),
                                    ),
                                  );
                                },
                              )),
                          const CommonWidthSizedBox(
                            width: AppSize.size12,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: AppSize.size12),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: AppSize.opacity10,
                                      color: AppColors.blackTextColor
                                          .withOpacity(AppSize.opacity10),
                                      blurRadius: AppSize.size20,
                                    ),
                                  ],
                                ),
                                child: CustomTextField(
                                  controller:
                                      homeController.userLocationController,
                                  hintText: AppStrings.enterLocation,
                                  hintFontSize: AppSize.size12,
                                  hintColor: AppColors.smallTextColor,
                                  hintTextColor: AppColors.smallTextColor,
                                  fontFamily: FontFamily.latoRegular,
                                  height: AppSize.size46,
                                  fillColor: AppColors.backGroundColor,
                                  cursorColor: AppColors.smallTextColor,
                                  fillFontFamily: FontFamily.latoSemiBold,
                                  fillFontWeight: FontWeight.w400,
                                  fillFontSize: AppSize.size12,
                                  fontWeight: FontWeight.w400,
                                  fillTextColor: AppColors.blackTextColor,
                                  suffixIcon: Obx(
                                    () => Padding(
                                      padding: EdgeInsets.only(
                                          right: languageController.arb.value
                                              ? AppSize.size7
                                              : AppSize.size16,
                                          left: languageController.arb.value
                                              ? AppSize.size16
                                              : AppSize.size7),
                                      child: Obx(
                                        () => homeController.like.value
                                            ? GestureDetector(
                                                onTap: () {
                                                  homeController.like.value =
                                                      false;
                                                },
                                                child: Image.asset(
                                                  AppIcons.likeFill,
                                                  height: AppSize.size18,
                                                  width: AppSize.size18,
                                                  color: AppColors.redColor,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  homeController.like.value =
                                                      true;
                                                },
                                                child: Image.asset(
                                                  AppIcons.like,
                                                  height: AppSize.size18,
                                                  width: AppSize.size18,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                    maxWidth: AppSize.size38,
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      left: AppSize.size12,
                                      right: AppSize.size8,
                                    ),
                                    child: Image.asset(
                                      AppIcons.mapIcon,
                                      height: AppSize.size18,
                                      width: AppSize.size18,
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    maxWidth: AppSize.size36,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: AppSize.size16,
                                      top: AppSize.size10,
                                      bottom: AppSize.size10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        homeController.onTapDirection();
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: AppSize.size20,
                            bottom: AppSize.size20,
                          ),
                          child: Image.asset(
                            AppIcons.gpsIcon,
                            width: AppSize.size38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => GestureDetector(
                    onVerticalDragUpdate: (details) {
                      homeController.updateHeight(details.primaryDelta!);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: AppSize.time200),
                      height: homeController.height.value,
                      padding: const EdgeInsets.only(
                        top: AppSize.size10,
                        left: AppSize.size20,
                        right: AppSize.size20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.size10),
                          topRight: Radius.circular(AppSize.size10),
                        ),
                        color: AppColors.backGroundColor,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: AppSize.size1,
                            blurRadius: AppSize.size17,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        /*physics: homeController.height.value == AppSize.size130
                            ? const NeverScrollableScrollPhysics()
                            : const ClampingScrollPhysics(),*/
                        child: Column(
                          children: [
                            Image.asset(
                              AppIcons.bottomSheetIcon,
                              width: AppSize.size40,
                            ),
                            /*Obx(
                              () => languageController.arb.value
                                  ? Container(
                                      height: AppSize.size82,
                                      margin: const EdgeInsets.only(
                                        top: AppSize.size24,
                                      ),
                                      padding: EdgeInsets.only(
                                          left: languageController.arb.value
                                              ? 0
                                              : AppSize.size15,
                                          right: languageController.arb.value
                                              ? AppSize.size15
                                              : 0),
                                      decoration: BoxDecoration(
                                        color: AppColors.backGroundColor,
                                        border: Border.all(
                                          color: AppColors.smallTextColor
                                              .withOpacity(AppSize.opacity10),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            AppSize.size10),
                                      ),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: AppSize.four,
                                          mainAxisExtent: AppSize.size64,
                                          crossAxisSpacing: AppSize.size15,
                                        ),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(
                                          top: AppSize.size15,
                                        ),
                                        itemCount:
                                            homeController.serviceString.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              homeController
                                                  .setServiceIndex(index);
                                            },
                                            child: Obx(() => SizedBox(
                                                  width: AppSize.size30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Image.asset(
                                                            homeController
                                                                    .serviceIcon[
                                                                index],
                                                            width:
                                                                AppSize.size30,
                                                          ),
                                                          Text(
                                                            homeController
                                                                    .serviceString[
                                                                index],
                                                            style: TextStyle(
                                                              fontSize: AppSize
                                                                  .size12,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .latoRegular,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: homeController
                                                                          .selectedServiceIndex
                                                                          .value ==
                                                                      index
                                                                  ? AppColors
                                                                      .blackTextColor
                                                                  : AppColors
                                                                      .smallTextColor,
                                                            ),
                                                          ),
                                                          if (homeController
                                                                  .selectedServiceIndex
                                                                  .value ==
                                                              index) ...[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: AppSize
                                                                    .size5,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                AppIcons
                                                                    .selectLineIcon,
                                                                width: AppSize
                                                                    .size30,
                                                              ),
                                                            ),
                                                          ] else
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: AppSize
                                                                    .size5,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                AppIcons
                                                                    .selectLineIcon,
                                                                width: AppSize
                                                                    .size30,
                                                                color: AppColors
                                                                    .backGroundColor,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      height: AppSize.size82,
                                      margin: const EdgeInsets.only(
                                        top: AppSize.size24,
                                      ),
                                      padding: EdgeInsets.only(
                                          left: languageController.arb.value
                                              ? 0
                                              : AppSize.size15,
                                          right: languageController.arb.value
                                              ? AppSize.size15
                                              : 0),
                                      decoration: BoxDecoration(
                                        color: AppColors.backGroundColor,
                                        border: Border.all(
                                          color: AppColors.smallTextColor
                                              .withOpacity(AppSize.opacity10),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            AppSize.size10),
                                      ),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: AppSize.four,
                                          mainAxisExtent: AppSize.size64,
                                          crossAxisSpacing: AppSize.size15,
                                        ),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(
                                          top: AppSize.size15,
                                        ),
                                        itemCount:
                                            homeController.serviceString.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              homeController
                                                  .setServiceIndex(index);
                                            },
                                            child: Obx(() => SizedBox(
                                                  width: AppSize.size30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Image.asset(
                                                            homeController
                                                                    .serviceIcon[
                                                                index],
                                                            width:
                                                                AppSize.size30,
                                                          ),
                                                          Text(
                                                            homeController
                                                                    .serviceString[
                                                                index],
                                                            style: TextStyle(
                                                              fontSize: AppSize
                                                                  .size12,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .latoRegular,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: homeController
                                                                          .selectedServiceIndex
                                                                          .value ==
                                                                      index
                                                                  ? AppColors
                                                                      .blackTextColor
                                                                  : AppColors
                                                                      .smallTextColor,
                                                            ),
                                                          ),
                                                          if (homeController
                                                                  .selectedServiceIndex
                                                                  .value ==
                                                              index) ...[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: AppSize
                                                                    .size5,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                AppIcons
                                                                    .selectLineIcon,
                                                                width: AppSize
                                                                    .size30,
                                                              ),
                                                            ),
                                                          ] else
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: AppSize
                                                                    .size5,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                AppIcons
                                                                    .selectLineIcon,
                                                                width: AppSize
                                                                    .size30,
                                                                color: AppColors
                                                                    .backGroundColor,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                            ),*/
                            Container(
                              height: AppSize.size238,
                              margin: const EdgeInsets.only(
                                top: AppSize.size16,
                              ),
                              padding: const EdgeInsets.only(
                                left: AppSize.size15,
                                right: AppSize.size15,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.backGroundColor,
                                border: Border.all(
                                  color: AppColors.smallTextColor
                                      .withOpacity(AppSize.opacity10),
                                ),
                                borderRadius:
                                    BorderRadius.circular(AppSize.size10),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => DestinationScreen());
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: AppSize.size42,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: AppStrings.setOrigin,
                                          hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontFamily.latoSemiBold,
                                            color: AppColors.blackTextColor,
                                            fontSize: AppSize.size14,
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.smallTextColor
                                                  .withOpacity(
                                                      AppSize.opacity20),
                                              width: AppSize.size1,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.smallTextColor
                                                  .withOpacity(
                                                      AppSize.opacity20),
                                              width: AppSize.size1,
                                            ),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.smallTextColor
                                                  .withOpacity(
                                                      AppSize.opacity20),
                                              width: AppSize.size1,
                                            ),
                                          ),
                                          prefixIcon: Obx(
                                            () => Padding(
                                              padding: EdgeInsets.only(
                                                right:
                                                    languageController.arb.value
                                                        ? 0
                                                        : AppSize.size8,
                                                left:
                                                    languageController.arb.value
                                                        ? AppSize.size8
                                                        : 0,
                                                top: AppSize.size5,
                                              ),
                                              child: Image.asset(
                                                AppIcons.search,
                                              ),
                                            ),
                                          ),
                                          prefixIconConstraints:
                                              const BoxConstraints(
                                            maxWidth: AppSize.size22,
                                          ),
                                        ),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamily.latoSemiBold,
                                          color: AppColors.blackTextColor,
                                          fontSize: AppSize.size14,
                                        ),
                                        cursorColor: const Color.fromARGB(
                                            255, 177, 168, 168),
                                        // readOnly: true,
                                        onTap: () {
                                          Get.to(
                                              () => PlacesDestinationScreen());
                                          debugPrint(
                                              "Clicked Select Destination");
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: AppSize.size12,
                                          bottom: AppSize.size12,
                                        ),
                                        child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Obx(
                                                  () => Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            languageController
                                                                    .arb.value
                                                                ? 0
                                                                : AppSize.size6,
                                                        left: languageController
                                                                .arb.value
                                                            ? AppSize.size6
                                                            : AppSize.size0),
                                                    child: Image.asset(
                                                      AppIcons.mapIcon,
                                                      color: AppColors
                                                          .smallTextColor,
                                                      width: AppSize.size14,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    homeController
                                                        .locationString[index],
                                                    maxLines: AppSize.one,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: AppSize.size12,
                                                      fontFamily: FontFamily
                                                          .latoRegular,
                                                      color: AppColors
                                                          .blackTextColor,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return Divider(
                                              color: AppColors.smallTextColor
                                                  .withOpacity(
                                                      AppSize.opacity10),
                                              height: AppSize.size25,
                                            );
                                          },
                                          itemCount: homeController
                                              .locationString.length,
                                        ),
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
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ProfileScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.user,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              AppStrings.profile,
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSplit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SplitScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.user,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              'Split Screen',
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildMyRides() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => MyRidesScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.scooter,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              AppStrings.myRides,
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildPayments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => PaymentsScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.payment,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              AppStrings.payment,
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Car Info Component
  Padding _buildCarInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => CarInfoScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.bookMark,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              "Car info",
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Car Info Component

  Padding _buildSaveLocations() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SaveLocationsScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.bookMark,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              AppStrings.saveLocations,
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSafety() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SafetyScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.verify,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              AppStrings.safety,
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSetting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.size32),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SettingsScreen());
        },
        child: Row(
          children: [
            Container(
              height: AppSize.size24,
              width: AppSize.size24,
              decoration: const BoxDecoration(
                  color: AppColors.lightTheme, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                AppIcons.settings,
                height: AppSize.size14,
                width: AppSize.size14,
              )),
            ),
            const CommonWidthSizedBox(width: AppSize.size8),
            const Text(
              AppStrings.settings,
              style: TextStyle(
                color: AppColors.blackTextColor,
                fontFamily: FontFamily.latoSemiBold,
                fontSize: AppSize.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
