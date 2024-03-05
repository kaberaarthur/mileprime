import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_colors.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController controller;
  final int maxLine;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final Color? textColor;
  final double? fontSize;
  final int? maxLength;
  final double? radius;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final String? hintText;
  final Color? hintTextColor;
  final double? hintFontSize;
  final FontWeight? hintTextWeight;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
    final Color? colorText;
  final Offset? offset;
  final double? spreadRadius;
  final VoidCallback? onTap;
  final Color? enableColor;
  final Color? disabledColor;
  final Color? focusedColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixWidget;
  final FormFieldValidator<String>? validator;
  final double? height;
  final double? width;
  final Color? color;
  final Color? fillTextColor;
final  TextInputAction? textInputAction;
  final String? labelText;
  final Color? colors;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final AlignmentGeometry? alignment;
  final VoidCallback? onTogglePasswordVisibility;
  final bool obscureText;
  final Widget? suffix;
  final  String? fontFamily;
  final String? fillFontFamily;
  final FontWeight? fontWeight;
  final FontWeight? fillFontWeight;
  final FontStyle? fontStyle;
  final Widget? prefix;
  final double? fillFontSize;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Color? hintColor;


  const CustomTextField(
      {Key? key,
        this.validator,
        this.fontFamily,
        this.obscureText = false,
        this.spreadRadius,
        this.offset,
        this.onChanged,
        this.disabledColor,
        this.maxLine = 1,
        this.maxLength,
        this.radius,
        this.fontSize,
        this.fillColor,
        this.textColor,
        this.isPassword = false,
        this.enabled = true,
        this.keyboardType = TextInputType.text,
        this.focusNode,
        this.hintText,
        this.hintTextColor,
        this.hintFontSize,
        this.hintTextWeight,
        this.textAlign,
        this.textAlignVertical,
        this.prefixIcon,
        this.suffixIcon,
        this.onTap,
        this.enableColor,
        this.focusedColor,
        this.cursorColor,
        required this.controller,
        this.contentPadding,
        this.prefixWidget,
        this.readOnly = false,
        this.height,
        this.width,
        this.color,
        this.colors,
        this.gradient,
        this.borderRadius,
        this.inputFormatters,
        this.labelText,
        this.suffix,
        this.alignment,
        this.onTogglePasswordVisibility,
        this.fontWeight,
        this.fontStyle,
        this.prefix,
        this.fillTextColor,
        this.fillFontFamily,
        this.fillFontWeight,
        this.suffixIconConstraints,
        this.fillFontSize, this.textInputAction, this.prefixIconConstraints, this.colorText, this.hintColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

textInputAction: textInputAction,
      cursorColor: cursorColor,
      style: TextStyle(
          color:colorText,
          fontFamily: fillFontFamily,
          fontWeight: fillFontWeight,
          fontSize: fillFontSize),
      obscureText: obscureText,
      readOnly: readOnly,
      validator: validator,
      onTap: onTap,
      obscuringCharacter: '*',
      onChanged: onChanged,
      controller: controller,
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      textAlignVertical: textAlignVertical,
      textAlign: textAlign ?? TextAlign.start,
      enabled: enabled,
      decoration: InputDecoration(prefixIconConstraints: prefixIconConstraints,
        filled: true,
        fillColor: fillColor,
        labelText: labelText,
        hintText: hintText,
        border:  OutlineInputBorder(
          borderSide:    BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: TextStyle(
          color: hintColor,
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            fontSize: fontSize),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(AppSize.size10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:   BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(AppSize.size10),
        ),
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        prefix: prefix,
        suffix: suffix,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
      ),
    );
  }
}
