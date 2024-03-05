// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/payments_controller.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_size.dart';
import '../../config/app_strings.dart';
import '../../config/font_family.dart';

class PaymentsScreen extends StatelessWidget {
  PaymentsScreen({Key? key}) : super(key: key);

  PaymentsController paymentsController = Get.put(PaymentsController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.backGroundColor,
        width: kIsWeb ? AppSize.size800 : null,
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: _appBar(),
          body: _paymentsContent(),
        ),
      ),
    );
  }

  //Payments Content
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
              padding: EdgeInsets.only(left: AppSize.size12,right: AppSize.size12),
              child: Text(
                AppStrings.payment,
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

  _paymentsContent() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.size24,
        left: AppSize.size20,
        right: AppSize.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
              horizontalTitleGap: AppSize.size5,
              contentPadding: const EdgeInsets.only(
                left: AppSize.size16,
                right: AppSize.size16,
                top: AppSize.size3,
                bottom: AppSize.size3,
              ),
              leading: Image.asset(
                AppIcons.cashIcon,
                width: AppSize.size28,
              ),
              title: const Text(
                AppStrings.cash,
                style: TextStyle(
                  fontSize: AppSize.size16,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.latoSemiBold,
                  color: AppColors.blackTextColor,
                ),
              ),
              trailing: Image.asset(
                AppIcons.rightArrowIcon,
                width: AppSize.size16,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: AppSize.size40, bottom: AppSize.size24),
            child: Text(
              AppStrings.addPaymentMethods,
              style: TextStyle(
                fontSize: AppSize.size16,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.latoBold,
                color: AppColors.blackTextColor,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: paymentsController.paymentMethod.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(
                  bottom: AppSize.size16,
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
                  horizontalTitleGap: AppSize.size5,
                  contentPadding: const EdgeInsets.only(
                    left: AppSize.size16,
                    right: AppSize.size16,
                    top: AppSize.size3,
                    bottom: AppSize.size3,
                  ),
                  leading: Image.asset(
                    paymentsController.paymentMethodImage[index],
                    width: AppSize.size28,
                  ),
                  title: Text(
                    paymentsController.paymentMethod[index],
                    style: const TextStyle(
                      fontSize: AppSize.size16,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.latoSemiBold,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                  trailing: Image.asset(
                    AppIcons.rightArrowIcon,
                    width: AppSize.size16,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
