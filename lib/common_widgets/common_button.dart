import 'package:flutter/material.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';


class ButtonCommon extends StatelessWidget {
 final String? text;
 final VoidCallback? onTap;
 final  Color? textColor;
 final Color? buttonColor;
 final Color? borderColor;
 final double? height;
 final double? width;
 final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;

  const ButtonCommon(
      {super.key,
      this.text,
      this.buttonColor,
      this.textColor,
      this.onTap,
      this.borderColor,
      this.height,
      this.width,
      this.fontFamily,
      this.fontWeight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.size10),
            color: buttonColor,
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Text(
          text ?? "",
          style: TextStyle(
            fontFamily: FontFamily.latoSemiBold,
            color: textColor ?? AppColors.backGroundColor,
            fontWeight: fontWeight,
            fontSize: AppSize.size16,
          ),
        ),
      ),
    );
  }
}


