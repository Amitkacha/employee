import 'package:employee_management/app/extension.dart';
import 'package:employee_management/components/app_button.dart';
import 'package:employee_management/components/app_widget.dart';
import 'package:employee_management/components/common_appbar.dart';
import 'package:employee_management/components/text_widget.dart';
import 'package:employee_management/presentation/add_employee/cubit/add_employee_state.dart';
import 'package:employee_management/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_constant.dart';
import '../../app/di.dart';
import '../../base/base_stateful_state.dart';
import '../../components/app_text_field.dart';
import '../../components/custom_date_picker.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../utils/utils.dart';
import '../employee_list/model/employee_data_model.dart';
import 'cubit/add_employee_cubit.dart';

class AddEmployeeScreen extends StatefulWidget {
  final EmployeeDataModel? editEmployee;
  final bool isEdit;

  const AddEmployeeScreen({super.key, this.editEmployee, this.isEdit = false});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends BaseStatefulCubitState<AddEmployeeCubit, AddEmployeeScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CommonAppBar(
      title: widget.isEdit ? AppStrings.editEmployeeDetails : AppStrings.addEmployeeDetails,
      prefixIcon: widget.isEdit ? SVGIcon.icDeleteEmployee : null,
      onTapAction: () async {
        if (widget.editEmployee != null) {
          await widget.editEmployee!.delete();
          goBack();
        }
      },
      shouldShowBackButton: true,
    );
  }

  @override
  bool get resizeToAvoidBottomInset => true;

  final addEmployeeCubit = getIt.get<AddEmployeeCubit>();
  final appUtils = getIt.get<AppUtils>();

  @override
  void initState() {
    addEmployeeCubit.isEdit = widget.isEdit;

    addEmployeeCubit.setPrefillData(widget.editEmployee);

    super.initState();
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        listener: (BuildContext context, state) async {},
        builder: (BuildContext context, Object? state) {
          return Column(
            children: [
              heightBox(24.h),
              AppTextField(
                controller: addEmployeeCubit.employeeNameController,
                prefixIcon: SVGIcon.icPerson,
                hint: AppStrings.employeeName,
              ),
              heightBox(24.h),
              _selectRoleView(),
              heightBox(24.h),
              Row(
                children: [
                  _selectDateView(
                      isToday: true,
                      dateValue: appUtils.convertTimestampToDateTime(addEmployeeCubit.selectedFromDate),
                      hintText: AppStrings.fromDate,
                      onTap: () async {
                        DateTime? selectedDate = await showDialog<DateTime>(
                          context: context,
                          builder: (context) => CustomDatePicker(
                            endDate: addEmployeeCubit.selectedToDate,
                            preSelectedDate : addEmployeeCubit.selectedFromDate,
                          ),
                        );
                        if(selectedDate != null){
                          addEmployeeCubit.selectedFromDate = selectedDate;
                          setState(() {});
                        }
                      }),
                  SvgPicture.asset(SVGIcon.icRightArrow),
                  _selectDateView(
                      isToday: false,
                      hintText: AppStrings.noDate,
                      dateValue: appUtils.convertTimestampToDateTime(addEmployeeCubit.selectedToDate),
                      onTap: () async {
                        DateTime? selectedDate = await showDialog<DateTime>(
                          context: context,
                          builder: (context) => CustomDatePicker(
                            isNoDate: true,
                            preSelectedDate : addEmployeeCubit.selectedToDate,
                            firstDate: addEmployeeCubit.selectedFromDate ,
                          ),
                        );
                        if(selectedDate != null){
                          addEmployeeCubit.selectedToDate = selectedDate;
                          setState(() {});
                        }
                      }),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1.h,
          color: ColorManager.colorF2F2F2,
        ),
        heightBox(16.h),
        Padding(
          padding: EdgeInsets.only(right: 4.w, bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                text: AppStrings.cancel,
                onTap: () => goBack(),
              ),
              AppButton(
                text: AppStrings.save,
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if (addEmployeeCubit.employeeNameController.text.isEmpty) {
                    appUtils.showErrorSnackBar("Please enter employee name");
                  } else if (addEmployeeCubit.selectedRole == null) {
                    appUtils.showErrorSnackBar("Please select role of employee");
                  } else {
                    if (widget.isEdit) {
                      final employee = widget.editEmployee;
                      employee!.name = addEmployeeCubit.employeeNameController.text;
                      employee.role = addEmployeeCubit.selectedRole.orEmpty();
                      employee.startDate = addEmployeeCubit.selectedFromDate!.toStringType();
                      employee.endDate = addEmployeeCubit.selectedToDate?.toStringType();
                      await addEmployeeCubit.editEmployee(employee);
                    } else {
                      await addEmployeeCubit.saveEmployee(EmployeeDataModel(
                          id: uuid.v4(),
                          name: addEmployeeCubit.employeeNameController.text,
                          role: addEmployeeCubit.selectedRole.orEmpty(),
                          startDate: addEmployeeCubit.selectedFromDate!.toStringType(),
                          endDate: addEmployeeCubit.selectedToDate?.toStringType()));
                    }
                    goBack();
                  }
                },
                isSelectedButton: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _selectRoleView() {
    return GestureDetector(
      onTap: () {
        _showBottomSheet();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w , vertical: 12 ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6 ),
            border: Border.all(color: ColorManager.colorE5E5E5)),
        child: Row(
          children: [
            SvgPicture.asset(SVGIcon.icRole, height: 24,width: 24,),
            widthBox(12.w),
            TextWidget(
              text: addEmployeeCubit.selectedRole ?? AppStrings.selectRole,
              color: addEmployeeCubit.selectedRole == null ? ColorManager.color949C9E : null,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: ColorManager.primary,
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() async {
    final selectedRole = await showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white, // Set dark background color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.separated(
          itemCount: AppConstant.roles.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return  SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: TextWidget(
                  text: AppConstant.roles[index],
                  textAlign: TextAlign.center,
                  fontSize: 16 ,
                  onTap: () {
                    Navigator.pop(context, AppConstant.roles[index]);
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1 ,
              color: ColorManager.colorF2F2F2,
            );
          },
        );
      },
    );
    if (selectedRole != null) {
      addEmployeeCubit.selectedRole = selectedRole;
      setState(() {});
    }
  }

  _selectDateView({required bool isToday, required String hintText, required String?
  dateValue, GestureTapCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12 ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r), border: Border.all(color: ColorManager.colorE5E5E5)),
          child: Row(
            children: [
              SvgPicture.asset(SVGIcon.icDatePicker),
              widthBox(12.w),
              TextWidget(
                text: dateValue ?? hintText,
                color: dateValue == null ? ColorManager.color949C9E : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

// @override
// void dispose() {
//   addEmployeeCubit.clearData();
//   super.dispose();
// }
}
