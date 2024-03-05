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

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({Key? key}) : super(key: key);

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
          body: _helpCenterContent(),
        ),
      ),
    );
  }

  //Help Center Content
  _appBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backGroundColor,
      elevation: AppSize.size0,
      automaticallyImplyLeading: false,
      title: Obx(() => Padding(
            padding:
                const EdgeInsets.only(left: AppSize.size5, top: AppSize.size10),
            child: !settingsController.search2Boolean.value
                ? Row(
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
                        padding: EdgeInsets.only(
                            left: AppSize.size12, right: AppSize.size12),
                        child: Text(
                          AppStrings.helpCenter,
                          style: TextStyle(
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
                right: AppSize.size20,
                left: AppSize.size20,
                top: AppSize.size10,
              ),
              child: !settingsController.search2Boolean.value
                  ? GestureDetector(
                      onTap: () {
                        settingsController.search2Boolean.value = true;
                      },
                      child: Image.asset(
                        AppIcons.search,
                        width: AppSize.size18,
                        color: AppColors.blackTextColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        settingsController.search2Boolean.value = false;
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

  _helpCenterContent() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size16,
      ),
      child: Column(
        children: [
          DefaultTabController(
            length: AppSize.two,
            initialIndex: 0,
            child: Container(
              margin: const EdgeInsets.only(
                left: AppSize.size20,
                right: AppSize.size20,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                  ),
                ),
              ),
              child: TabBar(
                controller: settingsController.tabController,
                labelStyle: const TextStyle(
                  fontSize: AppSize.size14,
                  fontFamily: FontFamily.latoSemiBold,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                dividerColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.blackTextColor,
                indicatorColor: AppColors.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelStyle: const TextStyle(
                  fontSize: AppSize.size14,
                  fontFamily: FontFamily.latoSemiBold,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackTextColor,
                ),
                tabs: const [
                  Tab(text: AppStrings.faq),
                  Tab(text: AppStrings.contactUs),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: settingsController.tabController,
              children: [
                _faqTab(),
                _contactUsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _faqTab() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        children: List.generate(settingsController.faqList.length, (index) {
          return Obx(() => GestureDetector(
                onTap: () {
                  settingsController.toggleExpansion(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutQuart,
                  margin: const EdgeInsets.only(top: AppSize.size24),
                  height: settingsController.isExpanded(index)
                      ? AppSize.size116
                      : AppSize.size49,
                  padding: const EdgeInsets.only(
                    top: AppSize.size14,
                    left: AppSize.size16,
                    right: AppSize.size16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColor,
                    borderRadius: BorderRadius.circular(AppSize.size10),
                    border: Border.all(
                      color: AppColors.smallTextColor
                          .withOpacity(AppSize.opacity15),
                      width: AppSize.size1and5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: AppSize.size1,
                        color: AppColors.blackTextColor
                            .withOpacity(AppSize.opacity10),
                        blurRadius: AppSize.size17,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            settingsController.faqList[index],
                            style: const TextStyle(
                              fontFamily: FontFamily.latoSemiBold,
                              fontWeight: FontWeight.w600,
                              fontSize: AppSize.size14,
                              color: AppColors.blackTextColor,
                            ),
                          ),
                        ),
                        if (settingsController.isExpanded(index)) ...[
                          Column(
                            children: [
                              Divider(
                                color: AppColors.smallTextColor
                                    .withOpacity(AppSize.opacity20),
                                height: AppSize.size25,
                              ),
                              const Text(
                                AppStrings.loremStringText3,
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
                      ],
                    ),
                  ),
                ),
              ));
        }),
      ),
    );
  }

  _contactUsTab() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        children:
            List.generate(settingsController.contactUsOption.length, (index) {
          return Container(
            margin: const EdgeInsets.only(top: AppSize.size24),
            height: AppSize.size52,
            padding: const EdgeInsets.only(
              left: AppSize.size16,
              right: AppSize.size16,
            ),
            decoration: BoxDecoration(
              color: AppColors.backGroundColor,
              borderRadius: BorderRadius.circular(AppSize.size10),
              border: Border.all(
                color: AppColors.smallTextColor.withOpacity(AppSize.opacity15),
                width: AppSize.size1and5,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: AppSize.size1,
                  color:
                      AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                  blurRadius: AppSize.size17,
                ),
              ],
            ),
            child: Row(
              children: [
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        right: languageController.arb.value ? 0 : AppSize.size8,
                        left: languageController.arb.value
                            ? AppSize.size8
                            : AppSize.size0),
                    child: SizedBox(
                      width: AppSize.size25,
                      height: AppSize.size25,
                      child: Center(
                        child: Image.asset(
                          settingsController.contactUsOption[index],
                          width: settingsController.contactUsOptionSize[index],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  settingsController.contactUsOptionString[index],
                  style: const TextStyle(
                    fontFamily: FontFamily.latoSemiBold,
                    fontWeight: FontWeight.w600,
                    fontSize: AppSize.size14,
                    color: AppColors.blackTextColor,
                  ),
                ),
              ],
            ),
          );
        }),
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
