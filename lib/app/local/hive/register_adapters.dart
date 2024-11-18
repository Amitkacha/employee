import 'package:employee_management/presentation/employee_list/model/employee_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> registerAdapters() async {
  ///TypeId 1
  Hive.registerAdapter(EmployeeDataModelAdapter());
}
