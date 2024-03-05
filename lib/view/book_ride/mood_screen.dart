// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/mood_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/home/home_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class MoodScreen extends StatelessWidget {
  MoodScreen({Key? key}) : super(key: key);

  MoodController moodController = Get.put(MoodController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: _appBar(),
          body: _moodContent(context),
          bottomNavigationBar: _bottomButtons(),
        ),
      ),
    );
  }

  //Mood Screen Content
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
                Get.back();
                moodController.pageController?.jumpToPage(0);
                moodController.selectedPageIndex.value = 0;
                moodController.selectedMoodIndex.value = 0;
                moodController.selectedTipIndex.value = 0;
              },
              child: Image.asset(
                AppIcons.arrowBack,
                width: AppSize.size20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _moodContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size24,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.size16),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(
                vertical: AppSize.minus1,
              ),
              dense: true,
              horizontalTitleGap: AppSize.size3,
              leading: Image.asset(
                AppIcons.driverIcon,
                width: AppSize.size34,
              ),
              title: const Text(
                AppStrings.deirdreRaja,
                style: TextStyle(
                  fontSize: AppSize.size16,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.latoBold,
                  color: AppColors.blackTextColor,
                ),
              ),
              subtitle: const Text(
                AppStrings.carMercedes,
                style: TextStyle(
                  fontSize: AppSize.size12,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.latoRegular,
                  color: AppColors.smallTextColor,
                ),
              ),
              trailing: SizedBox(
                width: AppSize.size65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: AppSize.size3,
                          ),
                          child: Image.asset(
                            AppIcons.starIcon,
                            width: AppSize.size14,
                          ),
                        ),
                        const Text(
                          AppStrings.like1and6,
                          style: TextStyle(
                            fontSize: AppSize.size12,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.latoRegular,
                            color: AppColors.smallTextColor,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: AppSize.size6,
                      ),
                      child: Text(
                        AppStrings.carNumber,
                        style: TextStyle(
                          fontSize: AppSize.size12,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.latoBold,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
            height: AppSize.size0,
          ),
          Expanded(
            child: PageView.builder(
              itemCount: moodController.pageViewList.length,
              controller: moodController.pageController,
              onPageChanged: (value) {
                moodController.selectedPageIndex.value = value;
              },
              itemBuilder: (context, index) {
                var itemData = moodController.pageViewList[index];
                return _customPageViewWidget(
                  itemData["title"],
                  itemData["subtitle"],
                  widget: index == 0
                      ? _emojiGridWidget()
                      : index == 1
                      ? _starRatingWidget()
                      : _driverTipsWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _bottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.size20,
        right: AppSize.size20,
        bottom: AppSize.size30,
      ),
      child: SizedBox(
        height: AppSize.size94,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(AppSize.three, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: AppSize.size4),
                  child: Obx(() => Container(
                        width: AppSize.size22and4,
                        height: AppSize.size2,
                        decoration: BoxDecoration(
                          color: moodController.selectedPageIndex.value == index
                              ? AppColors.blackTextColor
                              : AppColors.containerColor,
                          borderRadius: BorderRadius.circular(AppSize.size5),
                        ),
                      )),
                );
              }),
            ),
            Row(
              children: [
                Obx(() => _customMoodButton(
                  BoxDecoration(
                    border: Border.all(
                      color: AppColors.blackTextColor,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.size10),
                  ),
                  moodController.selectedPageIndex.value == 2
                      ? AppStrings.noThanks
                      : AppStrings.skip,
                  AppColors.blackTextColor,
                      () {
                    Get.offAll(() => HomeScreen());
                    moodController.selectedPageIndex.value = 0;
                    moodController.selectedMoodIndex.value = 0;
                    moodController.selectedTipIndex.value = 0;
                  },
                )),
                const SizedBox(
                  width: AppSize.size19,
                ),
                _customMoodButton(
                  BoxDecoration(
                    color: AppColors.blackTextColor,
                    borderRadius: BorderRadius.circular(AppSize.size10),
                  ),
                  AppStrings.submit,
                  AppColors.backGroundColor,
                  () {
                    int totalPages = moodController.pageViewList.length;
                    if (moodController.selectedPageIndex.value + 1 < totalPages) {
                      moodController.pageController?.jumpToPage(
                          moodController.selectedPageIndex.value + 1);
                    } else {
                      Get.offAll(() => HomeScreen());
                      moodController.selectedPageIndex.value = 0;
                      moodController.selectedMoodIndex.value = 0;
                      moodController.selectedTipIndex.value = 0;
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _customMoodButton(
      Decoration? decoration, String text, Color? textColor, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: AppSize.size54,
          margin: const EdgeInsets.only(
            top: AppSize.size12,
          ),
          decoration: decoration,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: AppSize.size16,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.latoSemiBold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _customPageViewWidget(String title, String subtitle,
      {required Widget widget}) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: AppSize.size31, bottom: AppSize.size8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: AppSize.size20,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.latoBold,
              color: AppColors.blackTextColor,
            ),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: AppSize.size12,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.latoRegular,
            color: AppColors.smallTextColor,
          ),
        ),
        widget,
      ],
    );
  }

  _emojiGridWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.size45),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppSize.three,
          mainAxisExtent: AppSize.size88,
          crossAxisSpacing: AppSize.size35,
          mainAxisSpacing: AppSize.size25,
        ),
        itemCount: moodController.moodEmoji.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              moodController.selectedMoodIndex.value = index;
            },
            child: Obx(() => Container(
                  width: AppSize.size88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.size20),
                    border: Border.all(
                      color: moodController.selectedMoodIndex.value == index
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: AppSize.size1and5,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      moodController.moodEmoji[index],
                      width: AppSize.size64,
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  _starRatingWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.size65),
      child: RatingBar(
        initialRating: AppSize.size1,
        glow: false,
        itemSize: AppSize.size42,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: AppSize.five,
        ratingWidget: RatingWidget(
          full: Image.asset(AppIcons.starFillIcon, width: AppSize.size42),
          half: Image.asset(AppIcons.starUnfillIcon, width: AppSize.size42),
          empty: Image.asset(AppIcons.starUnfillIcon, width: AppSize.size42),
        ),
        itemPadding: const EdgeInsets.symmetric(horizontal: AppSize.size12),
        onRatingUpdate: (rating) {

        },
      ),
    );
  }

  _driverTipsWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.size61),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(AppSize.five, (index) {
          return GestureDetector(
            onTap: () {
              moodController.selectedTipIndex.value = index;
            },
            child: Obx(() {
              final isSelected = moodController.selectedTipIndex.value == index;
              return Container(
                height: AppSize.size53,
                width: AppSize.size53,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    width: AppSize.size1,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.size10),
                ),
                child: Center(
                  child: Text(
                    moodController.tipList[index],
                    style: const TextStyle(
                      fontSize: AppSize.size20,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.latoBold,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
