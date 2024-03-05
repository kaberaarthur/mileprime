import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

class SettingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isSwitched = false.obs;

  TabController? tabController;
  RxList<bool> isExpandedList =
      List.generate(AppSize.six, (index) => false).obs;
  RxBool searchBoolean = false.obs;
  RxBool search2Boolean = false.obs;

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.onInit();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  bool isExpanded(int index) => isExpandedList[index];

  void toggleExpansion(int index) {
    for (int i = 0; i < isExpandedList.length; i++) {
      if (i != index && isExpandedList[i]) {
        isExpandedList[i] = false;
      }
    }
    isExpandedList[index] = !isExpandedList[index];
  }

  List<String> languageList = [
    AppStrings.english,
    AppStrings.french,
    AppStrings.hindi,
    AppStrings.german,
    AppStrings.arabic,
  ];

  List<String> faqList = [
    AppStrings.whatIsPrime,
    AppStrings.howToUsePrime,
    AppStrings.howDoICancelARide,
    AppStrings.howDoIExitTheApp,
    AppStrings.howToUsePrime,
    AppStrings.whatIsPrime,
  ];

  List<String> contactUsOption = [
    AppIcons.customerService,
    AppIcons.whatsapp,
    AppIcons.website,
    AppIcons.facebook,
    AppIcons.twitter,
    AppIcons.instagram,
  ];

  List<String> contactUsOptionString = [
    AppStrings.customerService,
    AppStrings.whatsapp,
    AppStrings.website,
    AppStrings.facebook,
    AppStrings.twitter,
    AppStrings.instagram,
  ];

  List<double> contactUsOptionSize = [
    AppSize.size24,
    AppSize.size18,
    AppSize.size20,
    AppSize.size20,
    AppSize.size20,
    AppSize.size20,
  ];
}
