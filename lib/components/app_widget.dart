
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../resources/color_manager.dart';

Widget heightBox(double height) {
  return SizedBox(height: height);
}

Widget widthBox(double width) {
  return SizedBox(width: width);
}

Widget appLoader({double? size, Color? color}) {
  return Center(
    child: LoadingAnimationWidget.hexagonDots(
      color: color ?? ColorManager.primary,
      size: size ?? 48,
    ),
  );
}

