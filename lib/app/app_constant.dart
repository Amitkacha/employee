import 'package:employee_management/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class AppConstant {
  static GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static const String projectName = "Employee Management";
  static const String fontFamily = "Roboto";
  static const List<String> roles = [
    AppStrings.productDesigner,
    AppStrings.flutterDeveloper,
    AppStrings.qaTester,
    AppStrings.productOwner,
  ];
}
