import 'package:employee_management/components/text_widget.dart';
import 'package:employee_management/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app/app_constant.dart';

class AppUtils {
  AppUtils._privateConstructor();

  static final AppUtils instance = AppUtils._privateConstructor();

  DateTime currentDateTime = DateTime.now();

  String? convertStringToDateTime(String? dateValue) {
    if (dateValue != null) {
      DateTime parsedDate = DateTime.parse(dateValue);
      return DateFormat("dd, MMM yyyy").format(parsedDate);
    }
    return dateValue;
  }

  String? convertTimestampToDateTime(DateTime? selectedDate) {
    if (selectedDate != null) {
      return isSameDay(selectedDate, DateTime.now()) ? AppStrings.today : DateFormat('d MMM yyyy').format(selectedDate);
    }
    return null;
  }

  void showErrorSnackBar(String message, [VoidCallback? onUndo]) {
    ScaffoldMessenger.of(AppConstant.rootNavigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: TextWidget(
          text: message,
          color: ColorManager.white,
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: ColorManager.black.withOpacity(0.5),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
