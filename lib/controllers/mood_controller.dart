import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

class MoodController extends GetxController {
  RxInt selectedMoodIndex = 0.obs;
   PageController? pageController;
  RxInt selectedPageIndex = 0.obs;
  RxInt selectedTipIndex = 0.obs;

  List<String> moodEmoji = [
    AppIcons.cryEmoji,
    AppIcons.starEmoji,
    AppIcons.loveEmoji,
    AppIcons.laughEmoji,
    AppIcons.calmEmoji,
    AppIcons.thinkEmoji,
    AppIcons.zipEmoji,
    AppIcons.stressEmoji,
    AppIcons.angryEmoji,
  ];

  List<String> tipList = [
    AppStrings.dollar2,
    AppStrings.dollar4,
    AppStrings.dollar6,
    AppStrings.dollar8,
    AppStrings.dollar10,
  ];

  List pageViewList = [
    {"title" : AppStrings.whatsYourMood, "subtitle" : AppStrings.aboutThisTrip},
    {"title" : AppStrings.howIsYourDriver, "subtitle" : AppStrings.pleaseRateTourDriver},
    {"title" : AppStrings.whatGivesADriverTips, "subtitle" : AppStrings.doYouAddAdditionalTip},
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void dispose() {
    selectedPageIndex.value = 0;
    super.dispose();
  }
}