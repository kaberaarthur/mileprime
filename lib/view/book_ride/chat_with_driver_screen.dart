// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_images.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/chat_with_driver_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/book_ride/call_with_driver_screen.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class ChatWithDriverScreen extends StatelessWidget {
  ChatWithDriverScreen({Key? key}) : super(key: key);

  ChatWithDriverController chatWithDriverController =
      Get.put(ChatWithDriverController());
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
          appBar: _appBar(),
          body: _chatWithDriverContent(context),
        ),
      ),
    );
  }

  //Chat with Driver Content
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
                chatWithDriverController.chatMessageController.clear();
                chatWithDriverController.isSentIconVisible.value = false;
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
                AppStrings.deirdreRaja,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: AppSize.size16,
            top: AppSize.size11,
          ),
          child: GestureDetector(
            onTap: () {
              Get.to(() =>  CallWithDriverScreen());
            },
            child: Image.asset(
              AppIcons.callIcon,
              width: AppSize.size18,
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.only(
                right: AppSize.size18,
                top: AppSize.size10,
                left: languageController.arb.value ? AppSize.size18 : 0),
            child: Image.asset(
              AppIcons.moreIcon,
              width: AppSize.size18,
            ),
          ),
        )
      ],
    );
  }

  _chatWithDriverContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
              top: AppSize.size24,
              left: AppSize.size20,
              right: AppSize.size20,
            ),
            children: [
              Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: AppSize.size3),
                      child: Text(
                        AppStrings.today,
                        style: TextStyle(
                          fontFamily: FontFamily.latoMedium,
                          fontWeight: FontWeight.w500,
                          fontSize: AppSize.size12,
                          color: AppColors.smallTextColor,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color:
                        AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.size20),
                    child: Column(
                      children: [
                        _customChatMessages(
                          Alignment.topRight,
                          EdgeInsets.zero,
                          AppColors.blackTextColor,
                          const BorderRadius.only(
                            topLeft: Radius.circular(AppSize.size20),
                            topRight: Radius.circular(AppSize.size20),
                            bottomLeft: Radius.circular(AppSize.size20),
                            bottomRight: Radius.circular(AppSize.size4),
                          ),
                          AppStrings.hiGoodAfternoon,
                          AppColors.backGroundColor,
                          AppColors.backGroundColor,
                          AppStrings.time20,
                        ),
                        _customChatMessages(
                          Alignment.topRight,
                          const EdgeInsets.only(
                            top: AppSize.size6,
                          ),
                          AppColors.blackTextColor,
                          const BorderRadius.only(
                            topLeft: Radius.circular(AppSize.size20),
                            topRight: Radius.circular(AppSize.size20),
                            bottomLeft: Radius.circular(AppSize.size20),
                            bottomRight: Radius.circular(AppSize.size4),
                          ),
                          AppStrings.justHeadingAirport,
                          AppColors.backGroundColor,
                          AppColors.backGroundColor,
                          AppStrings.time20,
                        ),
                        _customChatMessages(
                          Alignment.topLeft,
                          const EdgeInsets.only(
                            top: AppSize.size16,
                          ),
                          AppColors.containerColor,
                          const BorderRadius.only(
                            topLeft: Radius.circular(AppSize.size4),
                            topRight: Radius.circular(AppSize.size20),
                            bottomLeft: Radius.circular(AppSize.size20),
                            bottomRight: Radius.circular(AppSize.size20),
                          ),
                          AppStrings.helloRadhikaMandana,
                          AppColors.blackTextColor,
                          AppColors.blackTextColor
                              .withOpacity(AppSize.opacity70),
                          AppStrings.time20and1,
                        ),
                        _customChatMessages(
                          Alignment.topLeft,
                          const EdgeInsets.only(
                            top: AppSize.size6,
                          ),
                          AppColors.containerColor,
                          const BorderRadius.only(
                            topLeft: Radius.circular(AppSize.size4),
                            topRight: Radius.circular(AppSize.size20),
                            bottomLeft: Radius.circular(AppSize.size20),
                            bottomRight: Radius.circular(AppSize.size20),
                          ),
                          AppStrings.noProblem,
                          AppColors.blackTextColor,
                          AppColors.blackTextColor
                              .withOpacity(AppSize.opacity70),
                          AppStrings.time20and1,
                        ),
                        _customChatMessages(
                          Alignment.topRight,
                          const EdgeInsets.only(
                            top: AppSize.size16,
                            bottom: AppSize.size6,
                          ),
                          AppColors.blackTextColor,
                          const BorderRadius.only(
                            topLeft: Radius.circular(AppSize.size20),
                            topRight: Radius.circular(AppSize.size20),
                            bottomLeft: Radius.circular(AppSize.size20),
                            bottomRight: Radius.circular(AppSize.size4),
                          ),
                          AppStrings.terminal3Thanks,
                          AppColors.backGroundColor,
                          AppColors.backGroundColor,
                          AppStrings.time20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(
                                    left: languageController.arb.value
                                        ? AppSize.size16
                                        : 0,
                                    right: languageController.arb.value
                                        ? AppSize.size0
                                        : AppSize.size16),
                                child: Image.asset(
                                  AppImages.terminal1,
                                  width: AppSize.size90,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppImages.terminal2,
                              width: AppSize.size90,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: AppSize.size90,
          padding: const EdgeInsets.only(
            left: AppSize.size20,
            right: AppSize.size20,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  cursorColor: AppColors.text2Color,
                  controller: chatWithDriverController.chatMessageController,
                  style: const TextStyle(
                    fontSize: AppSize.size14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.latoRegular,
                    color: AppColors.blackTextColor,
                  ),
                  onChanged: (value) {
                    chatWithDriverController.toggleIcon();
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.typeAMessage,
                    hintStyle: const TextStyle(
                      fontSize: AppSize.size14,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.latoRegular,
                      color: AppColors.text2Color,
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: AppColors.containerColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.size12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.size12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.size12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: AppSize.size12,
                        right: AppSize.size10,
                      ),
                      child: Image.asset(
                        AppIcons.smileIcon,
                      ),
                    ),
                    suffixIcon: Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                            right: languageController.arb.value
                                ? 0
                                : AppSize.size12,
                            left: languageController.arb.value
                                ? AppSize.size12
                                : AppSize.size0),
                        child: Row(
                          children: [
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(
                                    right: languageController.arb.value
                                        ? 0
                                        : AppSize.size12,
                                    left: languageController.arb.value
                                        ? AppSize.size12
                                        : AppSize.size0),
                                child: Image.asset(
                                  AppIcons.pinIcon,
                                  width: AppSize.size16,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppIcons.cameraIcon,
                              width: AppSize.size16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      maxWidth: AppSize.size38,
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: AppSize.size58,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                      left: languageController.arb.value ? 0 : AppSize.size8,
                      right: languageController.arb.value
                          ? AppSize.size8
                          : AppSize.size0),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      chatWithDriverController.chatMessageController.clear();
                      chatWithDriverController.isSentIconVisible.value = false;
                    },
                    child: Obx(
                      () => Image.asset(
                        chatWithDriverController.isSentIconVisible.value
                            ? AppIcons.messageSentIcon
                            : AppIcons.recordIcon,
                        width: AppSize.size42,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _customChatMessages(
    Alignment alignment,
    EdgeInsets? margin,
    Color? containerColor,
    BorderRadius borderRadius,
    String text,
    Color textColor,
    Color textColor2,
    String text2,
  ) {
    return Align(
      alignment: alignment,
      child: Stack(
        children: [
          Container(
            width: AppSize.size223,
            margin: margin,
            padding: const EdgeInsets.only(
              top: AppSize.size15,
              bottom: AppSize.size15,
              left: AppSize.size20,
              right: AppSize.size6,
            ),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: borderRadius,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: AppSize.size14,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.latoSemiBold,
                color: textColor,
              ),
            ),
          ),
          Obx(
            () => Positioned(
              left: languageController.arb.value ? AppSize.size6 : null,
              right: languageController.arb.value ? null : AppSize.size6,
              bottom: AppSize.size14,
              child: Row(
                children: [
                  Text(
                    text2,
                    style: TextStyle(
                      fontFamily: FontFamily.latoMedium,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSize.size10,
                      color: textColor2,
                    ),
                  ),
                  if (alignment == Alignment.topRight) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSize.size4,
                      ),
                      child: Image.asset(
                        AppIcons.doubleCheckIcon,
                        width: AppSize.size10,
                      ),
                    ),
                  ] else
                    const Padding(
                      padding: EdgeInsets.only(right: AppSize.size6),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
