// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/common_widgets/common_text_feild.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/language_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/profile_controller.dart';
import '../../common_widgets/common_width_sized_box.dart';
import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;
  final LanguageController languageController = Get.put(LanguageController());

  late String riderName = '';
  late String riderEmail = '';
  late String riderPhone = '';

  @override
  void initState() {
    super.initState();
    profileController = Get.put(ProfileController());

    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      riderEmail = args['riderEmail'] ?? {};
      riderPhone = args['riderPhone'] ?? {};
      riderName = args['riderName'] ?? '';
    } else {
      riderName = '';
      riderPhone = '';
      riderEmail = '';
    }
    debugPrint('#############################');
    debugPrint('Rider Name: $riderName');
    debugPrint('Rider Phone: $riderPhone');
    debugPrint('#############################');
  }

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
          body: _profileContent(context),
        ),
      ),
    );
  }

  //Profile Content
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
              padding:
                  EdgeInsets.only(left: AppSize.size12, right: AppSize.size12),
              child: Text(
                AppStrings.profile,
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

  _profileContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.size40,
        left: AppSize.size20,
        right: AppSize.size20,
        bottom: AppSize.size10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSize.size50),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      profileController.pickImage();
                    },
                    child: Obx(
                      () => CircleAvatar(
                        radius: AppSize.size39,
                        backgroundColor: riderName != null &&
                                riderName.isNotEmpty
                            ? Color.fromARGB(255, 255, 215,
                                35) // Use yellow background color if riderName is not null or empty
                            : Color.fromARGB(255, 255, 215,
                                35), // Use black background color if riderName is null or empty
                        child: Text(
                          riderName != null && riderName.isNotEmpty
                              ? riderName[0]
                                  .toUpperCase() // Use the capitalized first letter of riderName if not null or empty
                              : 'U', // Use 'U' if riderName is null or empty
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 40,
                            fontFamily: FontFamily.latoBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: AppSize.size7,
                    right: AppSize.size7,
                    child: Image.asset(
                      AppIcons.editPicIcon,
                      width: AppSize.size16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: AppSize.opacity10,
                  color:
                      AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                  blurRadius: AppSize.size20,
                ),
              ],
            ),
            child: CustomTextField(
              controller: profileController.nameController,
              hintText: riderName,
              hintFontSize: AppSize.size14,
              hintColor: AppColors.smallTextColor,
              hintTextColor: AppColors.smallTextColor,
              fontFamily: FontFamily.latoRegular,
              height: AppSize.size54,
              fillColor: AppColors.backGroundColor,
              cursorColor: AppColors.smallTextColor,
              fillFontFamily: FontFamily.latoSemiBold,
              fillFontWeight: FontWeight.w600,
              fillFontSize: AppSize.size14,
              fontWeight: FontWeight.w400,
              fillTextColor: AppColors.blackTextColor,
              contentPadding: const EdgeInsets.only(
                  left: AppSize.size16,
                  right: AppSize.size16,
                  top: AppSize.size18,
                  bottom: AppSize.size18),
            ),
          ),*/
          // Name
          Padding(
            padding: const EdgeInsets.only(top: AppSize.size24),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: AppSize.opacity10,
                    color:
                        AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                    blurRadius: AppSize.size20,
                  ),
                ],
              ),
              child: CustomTextField(
                controller: profileController.emailController,
                hintText: riderName,
                hintFontSize: AppSize.size14,
                hintColor: AppColors.smallTextColor,
                hintTextColor: AppColors.smallTextColor,
                fontFamily: FontFamily.latoRegular,
                height: AppSize.size54,
                fillColor: AppColors.backGroundColor,
                cursorColor: AppColors.smallTextColor,
                fillFontFamily: FontFamily.latoSemiBold,
                fillFontWeight: FontWeight.w600,
                fillFontSize: AppSize.size14,
                fontWeight: FontWeight.w400,
                fillTextColor: AppColors.blackTextColor,
                suffixIcon: Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        right:
                            languageController.arb.value ? 0 : AppSize.size16,
                        left: languageController.arb.value
                            ? AppSize.size16
                            : AppSize.size0),
                    child: Image.asset(
                      AppIcons.emailIcon,
                    ),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: AppSize.size30,
                ),
                contentPadding: const EdgeInsets.only(
                    left: AppSize.size16,
                    right: AppSize.size16,
                    top: AppSize.size18,
                    bottom: AppSize.size18),
              ),
            ),
          ),
          // Phone Number
          Padding(
            padding: const EdgeInsets.only(top: AppSize.size24),
            child: Container(
              height: AppSize.size54,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: AppSize.opacity10,
                    color:
                        AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                    blurRadius: AppSize.size20,
                  ),
                ],
              ),
              child: CustomTextField(
                contentPadding: const EdgeInsets.only(
                    bottom: AppSize.size16, top: AppSize.size16),
                onChanged: (p0) {
                  profileController.checkPhoneNumberValidity(p0);
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(AppSize.ten),
                ],
                fillFontFamily: FontFamily.latoSemiBold,
                fillFontSize: AppSize.size14,
                colorText: AppColors.blackTextColor,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                prefixIcon: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: GestureDetector(
                    onTap: () async {
                      final code =
                          await profileController.countryPicker?.showPicker(
                        context: context,
                      );
                      if (code != null) {
                        profileController.countryCode = code;
                        profileController.countryTextController.text =
                            code.name;
                        profileController.isChanged.toggle();
                      }
                    },
                    child: Obx(() => profileController.isChanged.value
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: AppSize.size16, right: AppSize.size8),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: AppSize.size19,
                                    width: AppSize.size19,
                                    child: profileController.countryCode
                                            ?.flagImage() ??
                                        Image.asset(AppIcons.kenya)),
                                const CommonWidthSizedBox(width: AppSize.size4),
                                SizedBox(
                                    height: AppSize.size12,
                                    width: AppSize.size12,
                                    child: Center(
                                        child:
                                            Image.asset(AppIcons.arrowDown))),
                                const CommonWidthSizedBox(
                                    width: AppSize.size10),
                                Container(
                                  height: AppSize.size12,
                                  width: AppSize.size1,
                                  decoration: const BoxDecoration(
                                      color: AppColors.smallTextColor),
                                ),
                                const CommonWidthSizedBox(
                                    width: AppSize.size10),
                                Text(
                                    profileController.countryCode?.dialCode ??
                                        AppStrings.kenyaCode,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: AppSize.size16, right: AppSize.size8),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: AppSize.size19,
                                    width: AppSize.size19,
                                    child: profileController.countryCode
                                            ?.flagImage() ??
                                        Image.asset(AppIcons.kenya)),
                                const CommonWidthSizedBox(width: AppSize.size4),
                                SizedBox(
                                    height: AppSize.size12,
                                    width: AppSize.size12,
                                    child: Center(
                                        child:
                                            Image.asset(AppIcons.arrowDown))),
                                const CommonWidthSizedBox(
                                    width: AppSize.size10),
                                Container(
                                  height: AppSize.size12,
                                  width: AppSize.size1,
                                  decoration: const BoxDecoration(
                                      color: AppColors.smallTextColor),
                                ),
                                const CommonWidthSizedBox(
                                    width: AppSize.size10),
                                Text(
                                    profileController.countryCode?.dialCode ??
                                        AppStrings.indiaCode,
                                    style: const TextStyle(
                                        fontFamily: FontFamily.latoSemiBold,
                                        fontSize: AppSize.size14,
                                        color: AppColors.blackTextColor)),
                              ],
                            ),
                          )),
                  ),
                ),
                fillColor: AppColors.backGroundColor,
                controller: profileController.mobileController,
                suffixIcon: Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        right:
                            languageController.arb.value ? 0 : AppSize.size16,
                        left:
                            languageController.arb.value ? AppSize.size16 : 0),
                    child: const Text(
                      AppStrings.edit,
                      style: TextStyle(
                        fontSize: AppSize.size12,
                        fontFamily: FontFamily.latoRegular,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: AppSize.size38,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.size24),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: AppSize.opacity10,
                    color:
                        AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                    blurRadius: AppSize.size20,
                  ),
                ],
              ),
              child: CustomTextField(
                controller: profileController.birthController,
                // hintText: AppStrings.birthOfDate,
                hintText: 'Date of Birth',
                hintFontSize: AppSize.size14,
                hintColor: AppColors.smallTextColor,
                hintTextColor: AppColors.smallTextColor,
                fontFamily: FontFamily.latoRegular,
                height: AppSize.size54,
                fillColor: AppColors.backGroundColor,
                cursorColor: AppColors.smallTextColor,
                fillFontFamily: FontFamily.latoSemiBold,
                fillFontWeight: FontWeight.w600,
                fillFontSize: AppSize.size14,
                fontWeight: FontWeight.w400,
                fillTextColor: AppColors.blackTextColor,
                suffixIcon: Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        right:
                            languageController.arb.value ? 0 : AppSize.size16,
                        left: languageController.arb.value
                            ? AppSize.size16
                            : AppSize.size0),
                    child: GestureDetector(
                      onTap: () {
                        profileController.selectDate(context);
                      },
                      child: Image.asset(
                        AppIcons.calendarIcon,
                      ),
                    ),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: AppSize.size30,
                ),
                contentPadding: const EdgeInsets.only(
                    left: AppSize.size16,
                    right: AppSize.size16,
                    top: AppSize.size18,
                    bottom: AppSize.size18),
              ),
            ),
          ),
          /*
          Padding(
            padding: const EdgeInsets.only(top: AppSize.size24),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: AppSize.opacity10,
                    color:
                        AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                    blurRadius: AppSize.size20,
                  ),
                ],
              ),
              child: CustomTextField(
                controller: profileController.emailController,
                hintText: AppStrings.enterEmail,
                hintFontSize: AppSize.size14,
                hintColor: AppColors.smallTextColor,
                hintTextColor: AppColors.smallTextColor,
                fontFamily: FontFamily.latoRegular,
                height: AppSize.size54,
                fillColor: AppColors.backGroundColor,
                cursorColor: AppColors.smallTextColor,
                fillFontFamily: FontFamily.latoSemiBold,
                fillFontWeight: FontWeight.w600,
                fillFontSize: AppSize.size14,
                fontWeight: FontWeight.w400,
                fillTextColor: AppColors.blackTextColor,
                suffixIcon: Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        right:
                            languageController.arb.value ? 0 : AppSize.size16,
                        left: languageController.arb.value
                            ? AppSize.size16
                            : AppSize.size0),
                    child: Image.asset(
                      AppIcons.emailIcon,
                    ),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: AppSize.size30,
                ),
                contentPadding: const EdgeInsets.only(
                    left: AppSize.size16,
                    right: AppSize.size16,
                    top: AppSize.size18,
                    bottom: AppSize.size18),
              ),
            ),
          ),
          */
          const Padding(
            padding:
                EdgeInsets.only(top: AppSize.size24, bottom: AppSize.size10),
            child: Text(
              AppStrings.gender,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.latoRegular,
                fontSize: AppSize.size14,
                color: AppColors.smallTextColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(AppSize.three, (index) {
              return Obx(() => GestureDetector(
                    onTap: () {
                      profileController.setSelectedIndex(index);
                    },
                    child: Container(
                      width: AppSize.size99,
                      height: AppSize.size44,
                      decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        borderRadius: BorderRadius.circular(AppSize.size8),
                        border: Border.all(
                          color: index == profileController.selectedIndex.value
                              ? AppColors.primaryColor
                              : AppColors.smallTextColor
                                  .withOpacity(AppSize.opacity20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: AppSize.opacity10,
                            color: AppColors.blackTextColor
                                .withOpacity(AppSize.opacity10),
                            blurRadius: AppSize.size20,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          profileController.genderList[index],
                          style: TextStyle(
                            fontSize: AppSize.size14,
                            fontFamily: FontFamily.latoMedium,
                            fontWeight: FontWeight.w500,
                            color:
                                index == profileController.selectedIndex.value
                                    ? AppColors.primaryColor
                                    : AppColors.blackTextColor,
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
          ),
        ],
      ),
    );
  }
}
