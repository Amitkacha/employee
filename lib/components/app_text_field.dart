import 'package:employee_management/app/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/color_manager.dart';
import 'app_widget.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
   final String? suffixText;
  final String? prefixIcon;
  final Widget? suffixWidget;
  final Color? color;
  final Color? hintColor, focusColor;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final Widget? suffix, prefix;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? minLines;
  final bool? isDense;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapSuffixIcon;
  final double? height;
  final double? horizontalContentPadding;
  final double? verticalContentPadding;
  final double? textHeight;
  final double? width, topPadding;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isShadowEnable;
  final bool isBorderEnable;
  final String? fontFamilyText;
  final String? suffixFontFamilyText;
  final String? fontFamilyHint;
  final FontWeight? fontWeightText;
  final FontWeight? suffixFontWeightText;
  final FontWeight? fontWeightHint;
  final String? suffixIconName;
  final Widget? suffixIconWidget;
  final double? suffixIconHeight;
  final double? suffixIconWidth;
  final bool passwordVisible;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final bool autoFocus;
  final bool expands;
  final double? fontSize;
  final double? suffixFontSize;
  final TextAlignVertical? textAlignVertical;
  final String? counterText;
  final Color? fontColor;
  final Color? fieldBorderClr;
  final double? borderRadius;
  final double? contentPadding;
  final double? fieldHorizontalPadding;
  final List<BoxShadow>? boxShadow;

  const AppTextField(
      {super.key,
      required this.controller,
      this.focusNode,
      this.hint,

      this.suffixText,
      this.suffixWidget,
      this.expands = false,
      this.autoFocus = false,
      this.prefixIcon,
      this.prefix,
      this.color,
      this.fontColor,
      this.focusColor,
      this.textAlignVertical,
      this.textCapitalization,
      this.initialValue,
      this.readOnly,
      this.textAlign,
      this.topPadding,
      this.suffix,
      this.textInputType,
      this.maxLines = 1,
      this.minLines,
      this.isDense,
      this.onTap,
      this.height,
      this.onFieldSubmitted,
      this.verticalContentPadding,
      this.horizontalContentPadding,
      this.validator,
      this.maxLength,
      this.textInputAction,
      this.inputFormatters,
      this.width,
      this.hintColor,
      this.isBorderEnable = true,
      this.isShadowEnable = false,
      this.fontFamilyText,
      this.suffixFontFamilyText,
      this.suffixFontWeightText,
      this.fontFamilyHint,
      this.fontWeightHint,
      this.fontWeightText,
      this.suffixIconName,
      this.suffixIconHeight,
      this.suffixIconWidth,
      this.onTapSuffixIcon,
      this.passwordVisible = false,
      this.suffixIconWidget,
      this.onChanged,
      this.onEditingComplete,
      this.counterText,
      this.fontSize,
      this.suffixFontSize,
      this.fieldBorderClr,
      this.borderRadius,
      this.textHeight,
      this.boxShadow,
      this.fieldHorizontalPadding,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: fieldHorizontalPadding ?? 16.w),
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        // TextCapitalization.sentences,
        textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
        autofocus: autoFocus,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        validator: validator,
        onTap: onTap,
        obscureText: passwordVisible,
        maxLength: maxLength,
        controller: controller,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: initialValue,
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        minLines: minLines ?? 1,
        textAlign: textAlign ?? TextAlign.left,
        keyboardType: textInputType,
        expands: expands,
         style: TextStyle(
          fontFamily: AppConstant.fontFamily,
          fontSize: fontSize ?? 16 ,
          color: fontColor ?? ColorManager.color323238,
        ),

        cursorColor: ColorManager.color323238,
        onChanged: onChanged,

        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          enabled: true,
          alignLabelWithHint: true,
          counterText: counterText ?? "",
          isDense: isDense,
          prefixIcon: prefixIcon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widthBox(12.w),
                    SvgPicture.asset(
                      prefixIcon!,
                      colorFilter: focusColor != null
                          ? ColorFilter.mode(
                              ColorManager.primary, BlendMode.srcIn)
                          : null,
                    ),
                    widthBox(12.w),
                  ],
                )
              : prefix,
          focusColor: Colors.black12,
          suffixText: suffixText,
          suffix: suffix,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: suffixIconWidget ??
              (suffixIconName != null
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onTapSuffixIcon,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(
                          suffixIconName!,
                          width: suffixIconWidth,
                          height: suffixIconHeight,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              ColorManager.primary, BlendMode.srcIn),
                        ),
                      ))
                  : null),
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: AppConstant.fontFamily,
            fontSize:  16 ,
            color: hintColor ?? ColorManager.color949C9E,
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalContentPadding ?? 16.w,
              vertical: verticalContentPadding ?? 0.h),
          filled: true,
          fillColor: color ?? ColorManager.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6 ),
            borderSide: BorderSide(
                color: focusColor ?? ColorManager.colorE5E5E5, width: 1.5 ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6 ),
            borderSide: BorderSide(
                color: focusColor ?? ColorManager.colorE5E5E5, width: 1.5 ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6 ),
            borderSide: BorderSide(
                color: focusColor ?? ColorManager.colorE5E5E5, width: 1.5 ),
          ),
        ),
      ),
    );
  }
}
