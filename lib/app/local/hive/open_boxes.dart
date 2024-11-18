import 'package:employee_management/app/local/hive/box_names.dart';
import 'package:employee_management/presentation/employee_list/model/employee_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> openBoxes() async {
  await Hive.openBox<EmployeeDataModel>(employeeBox);
}
