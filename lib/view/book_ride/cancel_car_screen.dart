// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/cancel_car_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/cancellation_popup.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/font_family.dart';

class CancelCarScreen extends StatelessWidget {
  CancelCarScreen({Key? key}) : super(key: key);

  CancelCarController cancelCarController = Get.put(CancelCarController());
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
          resizeToAvoidBottomInset: true,
          appBar: _appBar(),
          body: _cancelCarContent(),
          bottomNavigationBar: _bottomBarButton(context),
        ),
      ),
    );
  }

  //Cancel Car Content
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
                AppStrings.cancelCar,
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

  _cancelCarContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size20,
        bottom: AppSize.size10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: List.generate(cancelCarController.cancelCarIssue.length,
                (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSize.size25),
                child: Row(
                  children: [
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                            right: languageController.arb.value
                                ? 0
                                : AppSize.size10,left:  languageController.arb.value
                            ? AppSize.size10
                            : AppSize.size0
                        ),
                        child: GestureDetector(
                          onTap: () {
                            cancelCarController.toggleCheckbox(index);
                          },
                          child: Obx(() {
                            bool isChecked = cancelCarController.checkedIndexes
                                .contains(index);
                            return Image.asset(
                              isChecked
                                  ? AppIcons.checkboxFillIcon
                                  : AppIcons.checkboxIcon,
                              width: AppSize.size16,
                            );
                          }),
                        ),
                      ),
                    ),
                    Text(
                      cancelCarController.cancelCarIssue[index],
                      style: const TextStyle(
                        fontFamily: FontFamily.latoMedium,
                        fontWeight: FontWeight.w500,
                        fontSize: AppSize.size14,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const Padding(
            padding:
                EdgeInsets.only(top: AppSize.size15, bottom: AppSize.size16),
            child: Text(
              AppStrings.otherReason,
              style: TextStyle(
                fontSize: AppSize.size16,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.latoBold,
                color: AppColors.blackTextColor,
              ),
            ),
          ),
          TextField(
            controller: cancelCarController.reasonController,
            cursorColor: AppColors.smallTextColor,
            maxLines: AppSize.four,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(
              fontFamily: FontFamily.latoMedium,
              fontWeight: FontWeight.w400,
              fontSize: AppSize.size12,
              color: AppColors.blackTextColor,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                top: AppSize.size20,
                left: AppSize.size12,
                right: AppSize.size12,
                bottom: AppSize.size3,
              ),
              hintText: AppStrings.writeAOtherReason,
              hintStyle: const TextStyle(
                fontFamily: FontFamily.latoRegular,
                fontWeight: FontWeight.w400,
                fontSize: AppSize.size12,
                color: AppColors.smallTextColor,
              ),
              filled: true,
              fillColor: AppColors.backGroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.size10),
                borderSide: BorderSide(
                  color:
                      AppColors.smallTextColor.withOpacity(AppSize.opacity10),
                  width: AppSize.size1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.size10),
                borderSide: BorderSide(
                  color:
                      AppColors.smallTextColor.withOpacity(AppSize.opacity10),
                  width: AppSize.size1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.size10),
                borderSide: BorderSide(
                  color:
                      AppColors.smallTextColor.withOpacity(AppSize.opacity10),
                  width: AppSize.size1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _bottomBarButton(BuildContext context) {
    return Container(
      height: AppSize.size120,
      color: AppColors.backGroundColor,
      padding: const EdgeInsets.only(
        top: AppSize.size16,
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return const CancellationPopup();
              },
            );
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
                AppStrings.submit,
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
