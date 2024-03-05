// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/select_location_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/save_as_location_bottom_sheet.dart';

import '../../common_widgets/common_text_feild.dart';
import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class SelectLocationScreen extends StatelessWidget {
  SelectLocationScreen({Key? key}) : super(key: key);

  SelectLocationController selectLocationController =
      Get.put(SelectLocationController());
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: _appBar(),
          body: _selectLocationContent(),
          bottomNavigationBar: _bottomButton(context),
        ),
      ),
    );
  }

  //Select Location Content
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
                AppStrings.selectLocation,
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

  _selectLocationContent() {
    return Stack(
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
                  target: LatLng(AppSize.latitude, AppSize.longitude),
                  zoom: AppSize.size14,
                ),
                mapType: MapType.normal,
                markers: Set.from(selectLocationController.markers),
                onMapCreated: (controller) {
                  selectLocationController.gMapsFunctionCall(
                      selectLocationController.initialLocation);
                },
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(
            top: AppSize.size12,
            left: AppSize.size20,
            right: AppSize.size20,
          ),
          child: CustomTextField(
            controller: selectLocationController.selectLocationController,
            hintText: AppStrings.enterLocation,
            hintFontSize: AppSize.size14,
            hintColor: AppColors.smallTextColor,
            hintTextColor: AppColors.smallTextColor,
            fontFamily: FontFamily.latoRegular,
            height: AppSize.size54,
            fillColor: AppColors.backGroundColor,
            cursorColor: AppColors.smallTextColor,
            fillFontFamily: FontFamily.latoSemiBold,
            fillFontWeight: FontWeight.w600,
            fillFontSize: AppSize.size14,
            fontWeight: FontWeight.w400,
            fillTextColor: AppColors.blackTextColor,
            prefixIcon: Obx(
              () => Padding(
                padding: EdgeInsets.only(
                    left: languageController.arb.value
                        ? AppSize.size8
                        : AppSize.size16,
                    right: languageController.arb.value
                        ? AppSize.size16
                        : AppSize.size8),
                child: Image.asset(
                  AppIcons.greenPin,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              maxWidth: AppSize.size36,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                  right: AppSize.size16, left: AppSize.size10),
              child: GestureDetector(
                onTap: () {
                  selectLocationController.selectLocationController.clear();
                },
                child: Image.asset(
                  AppIcons.closeIcon2,
                ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(
              maxWidth: AppSize.size40,
            ),
            contentPadding: const EdgeInsets.only(
                left: AppSize.size16,
                top: AppSize.size18,
                bottom: AppSize.size18),
          ),
        ),
      ],
    );
  }

  _bottomButton(BuildContext context) {
    return Container(
      height: AppSize.size100,
      color: AppColors.backGroundColor,
      child: Center(
        child: GestureDetector(
          onTap: () {
            saveAsLocationBottomSheet(context);
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
                AppStrings.confirmLocation,
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
}
