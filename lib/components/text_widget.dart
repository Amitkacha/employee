import 'package:employee_management/app/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';

class TextWidget extends StatefulWidget {
  final String? text;
  final Color? color;
  final FontStyle? fontStyle;
  final double? fontSize;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final GestureTapCallback? onTap;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? textHeight;
  final TextStyle? textStyle;
  final TextDecoration? decoration;

  const TextWidget({super.key, this.text, this.color ,
    this.fontSize, this.fontFamily ,
    this.letterSpacing, this.textAlign, this.onTap,
    this.fontWeight = FontWeight.normal,
    this.textOverflow, this.maxLines,
    this.textHeight, this.textStyle, this.decoration, this.fontStyle});

  @override
  TextWidgetState createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Text(
        widget.text ?? '',
        textAlign: widget.textAlign ?? TextAlign.left,
        maxLines: widget.maxLines,
        softWrap: true,
        overflow: widget.textOverflow,
        style: widget.textStyle ??
            TextStyle(
              color: widget.color ?? ColorManager.color323238,
              height: widget.textHeight?.h,
              fontSize: widget.fontSize ?? 14.sp,
              letterSpacing: widget.letterSpacing,
              decoration: widget.decoration,
              fontFamily: widget.fontFamily ?? AppConstant.fontFamily,
              fontWeight: widget.fontWeight,
              fontStyle: widget.fontStyle,
            ),
      ),
    );
  }
}
