import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_button.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_height_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/view/create_profile/create_profile_screen.dart';

class LocationPermission extends StatelessWidget {
  const LocationPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(AppSize.size0),
              child: AppBar(
                backgroundColor: AppColors.backGroundColor,
                elevation: AppSize.size0,
              )),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
                left: AppSize.size20,
                right: AppSize.size20,
                bottom: AppSize.size20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCommon(
                  onTap: () async {
                    await Geolocator.requestPermission();

                    if (await Geolocator.isLocationServiceEnabled()) {
                      Get.to(() => CreateProfileScreen());
                    } else {
                      await Geolocator.openLocationSettings();
                    }
                  },
                  text: AppStrings.turnOnLocation,
                  height: AppSize.size54,
                  buttonColor: AppColors.blackTextColor,
                ),
                const CommonHeightSizedBox(height: AppSize.size24),
                GestureDetector(
                  onTap: () {
                    Get.to(() => CreateProfileScreen());
                  },
                  child: const Text(
                    AppStrings.notNow,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.blackTextColor,
                      fontFamily: FontFamily.latoSemiBold,
                      fontSize: AppSize.size16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          backgroundColor: AppColors.backGroundColor,
          body: Column(
            children: [
              const CommonHeightSizedBox(height: AppSize.size60),
              Padding(
                padding: const EdgeInsets.all(AppSize.size60),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    AppImages.map,
                    width: kIsWeb ? AppSize.size250 : null,
                  ),
                ),
              ),
              const CommonHeightSizedBox(height: AppSize.size20),
              const Text(
                AppStrings.turnOnYourLocation,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.blackTextColor,
                  fontFamily: FontFamily.latoBold,
                  fontSize: AppSize.size20,
                ),
              ),
              const CommonHeightSizedBox(height: AppSize.size12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.size60),
                child: Text(
                  AppStrings.toEnjoyYour,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.smallTextColor,
                    fontFamily: FontFamily.latoRegular,
                    fontSize: AppSize.size12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
