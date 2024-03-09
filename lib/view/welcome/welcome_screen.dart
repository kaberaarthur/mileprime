import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_height_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_width_sized_box.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/view/lets_get_started/lets_get_started_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/create_profile/create_profile_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark));
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
          backgroundColor: AppColors.backGroundColor,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
                bottom: AppSize.size20,
                right: AppSize.size20,
                left: AppSize.size20),
            child: GestureDetector(
              onTap: () {
                Get.to(() => GetStartedScreen());
              },
              child: Container(
                height: AppSize.size54,
                decoration: BoxDecoration(
                    color: AppColors.blackTextColor,
                    borderRadius: BorderRadius.circular(AppSize.size10)),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.logIn,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.backGroundColor,
                          fontFamily: FontFamily.latoSemiBold,
                          fontSize: AppSize.size16),
                    ),
                    const CommonWidthSizedBox(
                      width: AppSize.size10,
                    ),
                    Image.asset(
                      AppIcons.arrowRight,
                      height: AppSize.size20,
                      width: AppSize.size20,
                    )
                  ],
                )),
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // height: height * AppSize.size0_50,
                child: Column(
                  children: [
                    const CommonHeightSizedBox(height: AppSize.size20),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSize.size10),
                      child: Center(
                        child: Image.asset(
                          AppIcons.splashLogo,
                          height: AppSize.size82,
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: height / AppSize.size2_5,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.cloud),
                              fit: kIsWeb ? BoxFit.fill : BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: AppSize.size25,
                            right: AppSize.size25,
                            top: AppSize.size26,
                          ),
                          height: height / AppSize.size4_5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.carImage),
                              fit: kIsWeb ? BoxFit.contain : BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.size20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            AppStrings.bookYourRide,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.blackTextColor,
                              fontFamily: FontFamily.latoBold,
                              fontSize: AppSize.size28,
                            ),
                          ),
                          CommonHeightSizedBox(height: AppSize.size12),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.size40),
                            child: Text(
                              AppStrings.getRide,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.smallTextColor,
                                fontFamily: FontFamily.latoRegular,
                                fontSize: AppSize.size14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSize.size10,
                  right: AppSize.size20,
                  left: AppSize.size20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => CreateProfileScreen());
                  },
                  child: Container(
                    height: AppSize.size54,
                    decoration: BoxDecoration(
                      color: AppColors.blackTextColor,
                      borderRadius: BorderRadius.circular(AppSize.size10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            AppStrings.register,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.backGroundColor,
                              fontFamily: FontFamily.latoSemiBold,
                              fontSize: AppSize.size16,
                            ),
                          ),
                          const CommonWidthSizedBox(width: AppSize.size10),
                          Image.asset(
                            AppIcons.arrowRight,
                            height: AppSize.size20,
                            width: AppSize.size20,
                          ),
                        ],
                      ),
                    ),
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
