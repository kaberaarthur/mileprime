// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/settings_controller.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({Key? key}) : super(key: key);

  SettingsController settingsController = Get.put(SettingsController());
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
          body: _languageContent(context),
        ),
      ),
    );
  }

  //Language Content
  _appBar() {
    return AppBar(
      backgroundColor: AppColors.backGroundColor,
      elevation: AppSize.size0,
      automaticallyImplyLeading: false,
      title: Obx(() => Padding(
            padding:
                const EdgeInsets.only(left: AppSize.size5, top: AppSize.size10),
            child: !settingsController.searchBoolean.value
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => RotationTransition(
                          turns: AlwaysStoppedAnimation(
                              languageController.arb.value ? 0.5 : 1.0),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSize.size12, right: AppSize.size12),
                        child: Text(
                          AppStrings.language.tr,
                          style: const TextStyle(
                            fontSize: AppSize.size20,
                            fontFamily: FontFamily.latoBold,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : _searchTextField(),
          )),
      actions: [
        Obx(() => Padding(
              padding: const EdgeInsets.only(
                  left: AppSize.size20,
                  top: AppSize.size10,
                  right: AppSize.size20),
              child: !settingsController.searchBoolean.value
                  ? GestureDetector(
                      onTap: () {
                        settingsController.searchBoolean.value = true;
                      },
                      child: Image.asset(
                        AppIcons.search,
                        width: AppSize.size18,
                        color: AppColors.blackTextColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        settingsController.searchBoolean.value = false;
                      },
                      child: Image.asset(
                        AppIcons.closeIcon2,
                        width: AppSize.size18,
                        color: AppColors.blackTextColor,
                      ),
                    ),
            )),
      ],
    );
  }

  _languageContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size15,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: settingsController.languageList.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = settingsController.languageList[index] ==
                languageController.languageName.value;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSize.size13),
                  child: ListTile(
                    onTap: () {
                      languageController.changeLanguage(
                          language: settingsController.languageList[index]);
                      languageController.languageName.value =
                          settingsController.languageList[index];
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      settingsController.languageList[index],
                      style: const TextStyle(
                        fontSize: AppSize.size16,
                        fontFamily: FontFamily.latoSemiBold,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                    trailing: GestureDetector(
                      child: Container(
                        width: AppSize.size16,
                        height: AppSize.size16,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: AppSize.size1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: isSelected
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
                      ),
                    ),
                  ),
                ),
                if (index < settingsController.languageList.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSize.size5),
                    child: Divider(
                      color: AppColors.smallTextColor
                          .withOpacity(AppSize.opacity20),
                      height: AppSize.size0,
                    ),
                  ),
              ],
            );
          });
        },
      ),
    );
  }

  _searchTextField() {
    return const TextField(
      autofocus: true,
      cursorColor: AppColors.smallTextColor,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.latoRegular,
        fontSize: AppSize.size16,
        color: AppColors.blackTextColor,
      ),
      decoration: InputDecoration(
        hintText: AppStrings.searchHere,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.latoRegular,
          fontSize: AppSize.size16,
          color: AppColors.smallTextColor,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
