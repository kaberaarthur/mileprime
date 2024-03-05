// ignore_for_file: must_be_immutable

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/book_ride_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/add_promo_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/book_car_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/auto_details_bottom_sheet.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';
import '../widget/schedule_a_ride_bottom_sheet.dart';

class BookRideFullScreen extends StatelessWidget {
  BookRideFullScreen({Key? key}) : super(key: key);

  BookRideController bookRideController = Get.put(BookRideController());
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
          resizeToAvoidBottomInset: false,
          appBar: _appBar(),
          body: _body(context),
          bottomNavigationBar: _bottomBarButton(),
        ),
      ),
    );
  }

  //Book Ride Full Screen Content
  _appBar() {
    return AppBar(
      scrolledUnderElevation: 0.0,
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
                AppStrings.distance,
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

  _body(BuildContext context) {
    return SingleChildScrollView(
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
                top: AppSize.size10,
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
                              controller: bookRideController.locationController,
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
                                    : AppSize.size0,
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
                              controller: bookRideController.addStopController,
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
                                    ? 0
                                    : AppSize.size30,
                                right: languageController.arb.value
                                    ? AppSize.size30
                                    : AppSize.size0,
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
                                  bookRideController.destinationController,
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
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity15),
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
                              AppIcons.alarmIcon,
                              width: AppSize.size18,
                            ),
                          ),
                        ),
                        const Text(
                          AppStrings.selectTime,
                          style: TextStyle(
                            fontSize: AppSize.size14,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.latoSemiBold,
                            color: AppColors.blackTextColor,
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
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bookRideController.rides.length,
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
                          .withOpacity(AppSize.opacity15),
                      width: AppSize.size1and5,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.size10),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: AppSize.opacity10,
                        color: AppColors.blackTextColor
                            .withOpacity(AppSize.opacity10),
                        blurRadius: AppSize.size10,
                      ),
                    ],
                  ),
                  child: ListTile(
                    horizontalTitleGap: AppSize.size7,
                    dense: true,
                    leading: Image.asset(
                      bookRideController.ridesImage[index],
                      width: AppSize.size32,
                    ),
                    title: Text(
                      bookRideController.rides[index],
                      style: const TextStyle(
                        fontSize: AppSize.size14,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.latoBold,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                    subtitle: Text(
                      bookRideController.ridesSubtitle[index],
                      style: const TextStyle(
                        fontSize: AppSize.size12,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.latoRegular,
                        color: AppColors.smallTextColor,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (index == 0) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: AppSize.size6,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        autoDetailsBottomSheet(context);
                                      },
                                      child: Image.asset(
                                        AppIcons.infoIcon,
                                        width: AppSize.size14,
                                      ),
                                    ),
                                  ),
                                ],
                                Text(
                                  bookRideController.ridesPrice[index],
                                  style: const TextStyle(
                                    fontFamily: FontFamily.latoMedium,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppSize.size14,
                                    color: AppColors.blackTextColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    bookRideController
                                        .selectFullScreenContainer(index);
                                  },
                                  child: Obx(() => Container(
                                        width: AppSize.size16,
                                        height: AppSize.size16,
                                        margin: EdgeInsets.only(
                                            left: languageController.arb.value
                                                ? 0
                                                : AppSize.size8,
                                            right: languageController.arb.value
                                                ? AppSize.size8
                                                : AppSize.size0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: bookRideController
                                                    .selectedFullScreenRideContainerIndex
                                                    .value ==
                                                index
                                            ? Center(
                                                child: Container(
                                                  width: AppSize.size8,
                                                  height: AppSize.size8,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
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
    );
  }

  _bottomBarButton() {
    return Container(
      height: AppSize.size120,
      color: AppColors.backGroundColor,
      padding: const EdgeInsets.only(
        top: AppSize.size16,
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: AppSize.size8,left: AppSize.size8
                  ),
                  child: Image.asset(
                    AppIcons.cashIcon,
                    width: AppSize.size16,
                  ),
                ),
                const Text(
                  AppStrings.cash,
                  style: TextStyle(
                    fontSize: AppSize.size14,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.latoSemiBold,
                    color: AppColors.blackTextColor,
                  ),
                ),
                VerticalDivider(
                  color:
                      AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                  width: AppSize.size60,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: AppSize.size8,left: AppSize.size8
                  ),
                  child: Image.asset(
                    AppIcons.couponIcon,
                    width: AppSize.size16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => AddPromoScreen());
                  },
                  child: const Text(
                    AppStrings.coupon,
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
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => BookCarScreen());
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
}
