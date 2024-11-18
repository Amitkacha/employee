import 'package:employee_management/app/app_constant.dart';
import 'package:employee_management/app/extension.dart';
import 'package:employee_management/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import 'app_widget.dart';

class AppButton extends StatelessWidget {
  final double? width, height;
  final double? borderRadius;
  final String? text;
  final String? stringAssetName;
  final GestureTapCallback? onTap;
  final bool showLoading;
  final bool isSelectedButton;
  final bool isTrailingIcon;
  final Color? textColor;
  final Color? loaderColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? assetHeight;
  final double? assetWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? buttonPadHorizon;
  final double? buttonPadVertical;
  final double borderWidth;
  final Widget? iconWidget;
  final EdgeInsetsGeometry? buttonMargin;
  final Gradient? gradientColor;
  final List<BoxShadow>? boxShadow;

  const AppButton(
      {super.key,
      this.width,
      this.borderRadius,
      this.height,
      this.text,
      this.onTap,
      this.showLoading = false,
      this.textColor,
      this.verticalPadding,
      this.stringAssetName,
      this.isSelectedButton = false,
      this.assetWidth,
      this.loaderColor,
      this.assetHeight,
      this.fontSize,
      this.fontWeight,
      this.horizontalPadding,
      this.borderColor,
      this.backgroundColor,
      this.borderWidth = 1.0,
      this.iconWidget,
      this.buttonMargin,
      this.gradientColor,
      this.boxShadow,
      this.buttonPadHorizon,
      this.buttonPadVertical,
      this.isTrailingIcon = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: buttonPadHorizon ?? 10 , vertical: buttonPadVertical ?? 0.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            width: width,
            height: height ?? 40 ,
            margin: buttonMargin,
            decoration: BoxDecoration(
              boxShadow: boxShadow,
              gradient: gradientColor,
              color: backgroundColor ?? (isSelectedButton ? ColorManager.primary : ColorManager.colorEDF8FF),
              border: Border.all(color: borderColor ?? ColorManager.transparent),
              borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h, horizontal: horizontalPadding ?? 20.w),
              child: Center(
                child: showLoading
                    ? appLoader(color: loaderColor ?? ColorManager.white, size: 25.h)
                    : TextWidget(
                        text: text?.orEmpty(),
                        fontSize: fontSize,
                        fontWeight: fontWeight ?? FontWeight.w500,
                        fontFamily: AppConstant.fontFamily,
                        color: textColor ?? (isSelectedButton ? ColorManager.white :
                        ColorManager.primary),
                      ),
              ),
            )),
      ),
    );
  }
}
