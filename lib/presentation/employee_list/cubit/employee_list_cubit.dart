import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/employee_data_model.dart';
import 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  final Box<EmployeeDataModel> employeeBox;

  EmployeeListCubit(this.employeeBox) : super(EmployeeListInitialState());

  static EmployeeListCubit get(context) => BlocProvider.of(context);

  List<EmployeeDataModel> employee = <EmployeeDataModel>[];

  List<EmployeeDataModel> currentEmployeesList = [];
  List<EmployeeDataModel> previousEmployeesList = [];

  getAllEmployee() {
    emit(EmployeeListLoadingState());
    List<EmployeeDataModel> employee = employeeBox.values.cast<EmployeeDataModel>().toList();
    currentEmployeesList = employee.where((emp) => emp.endDate == null).toList();
    previousEmployeesList = employee.where((emp) => emp.endDate != null).toList();
    emit(EmployeeListCompleteState());
  }
}
