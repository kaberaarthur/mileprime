// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/add_promo_controller.dart';
import 'package:prime_taxi_flutter_ui_kit/view/widget/special_offers_bottom_sheet.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class AddPromoScreen extends StatelessWidget {
  AddPromoScreen({Key? key}) : super(key: key);

  AddPromoController addPromoController = Get.put(AddPromoController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          resizeToAvoidBottomInset: false,
          appBar: _appBar(),
          body: _body(),
          bottomNavigationBar: _applyPromoButton(context),
        ),
      ),
    );
  }

  //Add Promo Content
  _appBar() {
    return AppBar(
      backgroundColor: AppColors.backGroundColor,
      elevation: AppSize.size0,
      automaticallyImplyLeading: false,
      title: Obx(() => Padding(
        padding:
        const EdgeInsets.only(left: AppSize.size5, top: AppSize.size10),
        child: !addPromoController.searchBoolean.value ? Row(
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
                AppStrings.addPromo,
                style: TextStyle(
                  fontSize: AppSize.size20,
                  fontFamily: FontFamily.latoBold,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor,
                ),
              ),
            ),
          ],
        ) : _searchTextField(),
      )),
      actions: [
        Obx(() => Padding(
          padding: const EdgeInsets.only(
            right: AppSize.size20,
            top: AppSize.size10,left: AppSize.size20
          ),
          child: !addPromoController.searchBoolean.value ? GestureDetector(
            onTap: () {
              addPromoController.searchBoolean.value = true;
            },
            child: Image.asset(
              AppIcons.search,
              width: AppSize.size18,
              color: AppColors.blackTextColor,
            ),
          ) : GestureDetector(
            onTap: () {
              addPromoController.searchBoolean.value = false;
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

  _body() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: addPromoController.promoOffer.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              bottom: AppSize.size24,
            ),
            decoration: BoxDecoration(
              color: AppColors.backGroundColor,
              border: Border.all(
                color:
                AppColors.smallTextColor.withOpacity(AppSize.opacity15),
                width: AppSize.size1and5,
              ),
              borderRadius: BorderRadius.circular(AppSize.size10),
              boxShadow: [
                BoxShadow(
                  spreadRadius: AppSize.opacity10,
                  color: AppColors.blackTextColor.withOpacity(AppSize.opacity10),
                  blurRadius: AppSize.size10,
                ),
              ],
            ),
            child: ListTile(
              dense: true,
              horizontalTitleGap: AppSize.size13,
              contentPadding: const EdgeInsets.only(
                left: AppSize.size16,
                right: AppSize.size16,
                top: AppSize.size3,
                bottom: AppSize.size3,
              ),
              leading: Image.asset(
                AppIcons.offerIcon,
                width: AppSize.size40,
              ),
              title: Text(
                addPromoController.promoOffer[index],
                style: const TextStyle(
                  fontSize: AppSize.size14,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.latoBold,
                  color: AppColors.blackTextColor,
                ),
              ),
              subtitle: Text(
                addPromoController.promoOfferSubtitle[index],
                style: const TextStyle(
                  fontSize: AppSize.size12,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.latoRegular,
                  color: AppColors.smallTextColor,
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  addPromoController.selectOfferContainer(index);
                },
                child: Obx(() => Container(
                  width: AppSize.size16,
                  height: AppSize.size16,
                  margin: const EdgeInsets.only(
                    left: AppSize.size8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: addPromoController.selectedOfferIndex.value == index
                      ? Center(
                    child: Container(
                      width: AppSize.size8,
                      height: AppSize.size8,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ) : null,
                )),
              ),
            ),
          );
        },
      ),
    );
  }

  _applyPromoButton(BuildContext context) {
    return Container(
      height: AppSize.size120,
      color: AppColors.backGroundColor,
      padding: const EdgeInsets.only(
        top: AppSize.size16,
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            specialOffersBottomSheet(context);
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
                AppStrings.applyPromo,
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
