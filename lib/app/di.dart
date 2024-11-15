import 'package:employee_management/app/local/hive/box_names.dart';
import 'package:employee_management/presentation/employee_list/model/employee_data_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../presentation/add_employee/cubit/add_employee_cubit.dart';
import '../presentation/employee_list/cubit/employee_list_cubit.dart';
import '../utils/utils.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  final appUtils = AppUtils.instance;
  getIt.registerLazySingleton<AppUtils>(() => appUtils);

  getIt.registerLazySingleton<EmployeeListCubit>(
      () => EmployeeListCubit(getIt.get()));
  getIt.registerFactory<AddEmployeeCubit>(() => AddEmployeeCubit(getIt.get()));
}

Future<void> initBoxDI() async {
  getIt.registerSingleton(
    Hive.box<EmployeeDataModel>(employeeBox),
  );
}
