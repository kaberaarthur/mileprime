import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: _appBar(),
          body: _privacyPolicyContent(),
        ),
      ),
    );
  }

  //Privacy Policy Content
  _appBar() {
    return AppBar(
      scrolledUnderElevation: 0,
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
              padding: EdgeInsets.only(left: AppSize.size12,right: AppSize.size12),
              child: Text(
                AppStrings.privacyPolicy,
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

  _privacyPolicyContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.policy,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.latoBold,
              fontSize: AppSize.size16,
              color: AppColors.blackTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppSize.size20, top: AppSize.size6),
            child: Column(
              children: [
                const Text(
                  AppStrings.termsAndConditionsString,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.latoRegular,
                    fontSize: AppSize.size12,
                    color: AppColors.smallTextColor,
                    height: AppSize.size1and4,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: AppSize.size12),
                  child: Text(
                    AppStrings.loremStringText,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.latoRegular,
                      fontSize: AppSize.size12,
                      color: AppColors.smallTextColor,
                      height: AppSize.size1and4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.size18,
                  ),
                  child: Column(
                    children: List.generate(AppSize.four, (index) => const Padding(
                      padding: EdgeInsets.only(
                        bottom: AppSize.size2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\u2022  ",
                            style: TextStyle(
                              fontFamily: FontFamily.latoRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: AppSize.size12,
                              color: AppColors.smallTextColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.loremString,
                              style: TextStyle(
                                fontFamily: FontFamily.latoRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: AppSize.size12,
                                color: AppColors.smallTextColor,
                                height: AppSize.size1and4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: AppSize.size12),
                  child: Text(
                    AppStrings.termsAndConditionsString,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.latoRegular,
                      fontSize: AppSize.size12,
                      color: AppColors.smallTextColor,
                      height: AppSize.size1and4,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: AppSize.size12),
                  child: Text(
                    AppStrings.loremStringText2,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.latoRegular,
                      fontSize: AppSize.size12,
                      color: AppColors.smallTextColor,
                      height: AppSize.size1and4,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: AppSize.size12),
                  child: Text(
                    AppStrings.termsAndConditionsString,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.latoRegular,
                      fontSize: AppSize.size12,
                      color: AppColors.smallTextColor,
                      height: AppSize.size1and4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
