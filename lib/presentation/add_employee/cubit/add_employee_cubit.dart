import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../employee_list/model/employee_data_model.dart';
import 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final Box<EmployeeDataModel> employeeBox;

  AddEmployeeCubit(this.employeeBox) : super(AddEmployeeInitialState());

  static AddEmployeeCubit get(context) => BlocProvider.of(context);

  String? selectedRole;
  bool isEdit = false;
  DateTime? selectedFromDate = DateTime.now(), selectedToDate;
  TextEditingController employeeNameController = TextEditingController();

  setFromDateVal(dateVal) {
    selectedFromDate = dateVal;
    emit(AddEmployeeUpdateState());
  }

  setToDateVal(dateVal) {
    selectedToDate = dateVal;
    emit(AddEmployeeUpdateState());
  }

  setPrefillData(EmployeeDataModel? editEmployee) {
    if (isEdit) {
      employeeNameController.text = editEmployee?.name ?? '';
      selectedRole = editEmployee?.role;
      print("editEmployee?.startDate ${editEmployee?.startDate}");
      selectedFromDate = editEmployee?.startDate != null ? DateFormat("yyyy-MM-dd hh:mm:ss").parse(editEmployee!.startDate) : DateTime.now();
      selectedToDate = editEmployee?.endDate != null ? DateFormat("yyyy-MM-dd hh:mm:ss").parse(editEmployee!.endDate!) : null;
      emit(AddEmployeeUpdateState());
    }
  }

  saveEmployee(EmployeeDataModel employeeData) async {
    await employeeBox.add(employeeData);
  }

  editEmployee(EmployeeDataModel employeeData) async {
    await employeeData.save();
  }

  clearData() {
    selectedRole = null;
    selectedFromDate = DateTime.now();
    selectedToDate = null;
    employeeNameController.clear();
  }
}
