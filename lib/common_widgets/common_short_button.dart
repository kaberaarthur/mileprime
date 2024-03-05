import 'package:flutter/material.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
class ShortButton extends StatelessWidget {
  final String? text;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? buttonColor;
  final String? fontFamily;
  final Color borderColor;
  final VoidCallback? onTap;

  const ShortButton(
      {super.key,
        this.text,
        this.textColor,
        this.buttonColor,
        this.height,
        this.width,
        required this.borderColor, this.fontFamily, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: AppSize.size1),
          borderRadius: BorderRadius.circular(AppSize.size10),
          color: buttonColor,
        ),
        child: Text(
          text ?? "",
          style: TextStyle(
              color: textColor, fontSize: AppSize.size16, fontFamily: fontFamily),
        ),
      ),
    );
  }
}