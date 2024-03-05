import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/book_ride_controller.dart';

selectPaymentBottomSheet(BuildContext context) {
  BookRideController bookRideController = Get.put(BookRideController());
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    constraints: const BoxConstraints(
      maxWidth: kIsWeb ? AppSize.size800 : double.infinity,
    ),
    isScrollControlled: true,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.size10),
        topRight: Radius.circular(AppSize.size10),
      ),
      borderSide: BorderSide.none,
    ),
    context: context,
    builder: (context) {
      return Container(
        height: AppSize.size616,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.size10),
            topLeft: Radius.circular(AppSize.size10),
          ),
          color: AppColors.backGroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                  top: AppSize.size20,
                  left: AppSize.size20,
                  right: AppSize.size20,
                ),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: AppSize.size16,
                    ),
                    child: Text(
                      AppStrings.selectPaymentMode,
                      style: TextStyle(
                        fontFamily: FontFamily.latoBold,
                        fontWeight: FontWeight.w700,
                        fontSize: AppSize.size20,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ),
                  const Text(
                    AppStrings.selectPaymentMethod,
                    style: TextStyle(
                      fontFamily: FontFamily.latoMedium,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSize.size14,
                      color: AppColors.smallTextColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: AppSize.size24,
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
                      trailing: Container(
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
                        child: Center(
                          child: Container(
                            width: AppSize.size8,
                            height: AppSize.size8,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.smallTextColor.withOpacity(AppSize.opacity20),
                    height: AppSize.size50,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookRideController.paymentMethod.length,
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
                            bookRideController.paymentMethodImage[index],
                            width: AppSize.size28,
                          ),
                          title: Text(
                            bookRideController.paymentMethod[index],
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
            ),
            Container(
              height: AppSize.size100,
              color: AppColors.backGroundColor,
              padding: const EdgeInsets.only(
                top: AppSize.size24,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: AppSize.size54,
                    margin: const EdgeInsets.only(
                      left: AppSize.size20,
                      right: AppSize.size20,
                      bottom: AppSize.size20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blackTextColor,
                      borderRadius: BorderRadius.circular(AppSize.size10),
                    ),
                    child: const Center(
                      child: Text(
                        AppStrings.confirm,
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
            ),
          ],
        ),
      );
    },
  );
}