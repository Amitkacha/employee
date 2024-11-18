import 'package:employee_management/app/extension.dart';
import 'package:employee_management/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/color_manager.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? iconImage;
  final String? prefixTextName, prefixIcon;
  final bool? shouldShowBackButton;
  final bool? showLogoTitle;
  final PreferredSizeWidget? bottom;
  final bool? isPrefixIcon;
  final Widget? leading;
  final double? elevation;
  final Widget? prefixWidget;
  final bool automaticallyImplyLeading;
  final GestureTapCallback? onTapPrefix;
  final GestureTapCallback? onPressBack;
  final Color? statusBarColor, backgroundColor, textColor;
  final GestureTapCallback? onTapAction;
  final double? toolbarHeight, titleSpacing;
  final Brightness? statusBarIconBrightness;
  final Brightness? statusBarBrightness;
  final bool? centerTitle;
  final Widget? flexibleSpace;
  final Widget? titleWidget;

  const CommonAppBar(
      {super.key,
      this.title,
      this.shouldShowBackButton = false,
      this.showLogoTitle = false,
      this.bottom,
      this.isPrefixIcon,
      this.prefixIcon,
      this.prefixTextName,
      this.toolbarHeight,
      this.onTapPrefix,
      this.iconImage,
      this.onPressBack,
      this.automaticallyImplyLeading = true,
      this.leading,
      this.statusBarColor,
      this.prefixWidget,
      this.backgroundColor,
      this.textColor,
      this.onTapAction,
      this.statusBarBrightness,
      this.centerTitle = false,
      this.flexibleSpace,
      this.titleSpacing,
      this.statusBarIconBrightness,
      this.titleWidget,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: backgroundColor  ?? ColorManager.primary ,
        surfaceTintColor: Colors.transparent,
        elevation: elevation,
        automaticallyImplyLeading: automaticallyImplyLeading,
        toolbarHeight: toolbarHeight ?? 56.h,
        title: titleWidget ??
            (iconImage ??
                TextWidget(
                  text : title?.orEmpty(),
                  textAlign: TextAlign.left,
                  color: textColor ?? ColorManager.white,
                    fontSize : 18,
                )),
        titleSpacing: titleSpacing ?? 0,
        centerTitle: centerTitle ?? false,
        leading: (shouldShowBackButton ?? false)
            ? leading ??
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onPressBack ??
                      () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                  child:   Icon(Icons.arrow_back, color : ColorManager.white),
                )
            : const SizedBox(),
        leadingWidth: (shouldShowBackButton ?? false) ? 55 : 16,
        actions: [
          prefixTextName != null
              ? GestureDetector(
                  onTap: onTapPrefix,
                  child: Container(
                    margin: EdgeInsets.only(right: 15.w),
                    padding: const EdgeInsets.only(right: 5, left: 5, top: 0),
                    child: TextWidget(

                      text : prefixTextName,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onTap: onTapAction,
                    ),
                  ),
                )
              : prefixIcon != null
                  ? GestureDetector(
                      onTap: onTapAction,
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 22,
                          bottom: 5,
                        ),
                        child: SvgPicture.asset(prefixIcon!),
                      ),
                    )
                  : prefixWidget ?? const SizedBox.shrink(),
        ],
        bottom: bottom,
        flexibleSpace: flexibleSpace);
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 56.h);
}
