import 'package:employee_management/components/app_widget.dart';
import 'package:employee_management/components/common_appbar.dart';
import 'package:employee_management/components/text_widget.dart';
import 'package:employee_management/presentation/employee_list/cubit/employee_list_state.dart';
import 'package:employee_management/resources/assets_manager.dart';
import 'package:employee_management/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/di.dart';
import '../../base/base_stateful_state.dart';
import '../../resources/strings_manager.dart';
import '../../utils/utils.dart';
import '../add_employee/add_employee_screen.dart';
import 'cubit/employee_list_cubit.dart';
import 'model/employee_data_model.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends BaseStatefulCubitState<EmployeeListCubit, EmployeeListScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const CommonAppBar(
      title: AppStrings.employeeList,
    );
  }

  final employeeListCubit = getIt.get<EmployeeListCubit>();
  final appUtils = getIt.get<AppUtils>();

  @override
  void initState() {
    employeeListCubit.getAllEmployee();
    super.initState();
  }

  @override
  Color? get scaffoldBgColor => ColorManager.white;

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AddEmployeeScreen();
        }));
        employeeListCubit.getAllEmployee();
      },
      child: Container(
        height: 50.h,
        width: 50.w,
        margin: EdgeInsets.only(bottom: 24.h, right: 6.w),
        decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(6.r)),
        child: Icon(
          Icons.add,
          size: 24.sp,
          color: ColorManager.white,
        ),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocBuilder<EmployeeListCubit, EmployeeListState>(
      builder: (BuildContext context, EmployeeListState state) {
        if (state is EmployeeListLoadingState) {
          return const CircularProgressIndicator();
        }
        return _employeeListView();
      },
    );
  }

  _noEmployeeDataFoundView() {
    return SizedBox(
      width: screenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            PNGImages.imgNoEmployeeFound,
            height: 230.h,
            width: 280.w,
          ),
          TextWidget(
            text: AppStrings.noEmployeeRecordsFound,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          )
        ],
      ),
    );
  }

  _employeeListView() {
    return (employeeListCubit.currentEmployeesList.isEmpty && employeeListCubit.previousEmployeesList.isEmpty)
        ? _noEmployeeDataFoundView()
        : ListView(
            children: [
              if (employeeListCubit.currentEmployeesList.isNotEmpty) currentEmployeeListView(employeeListCubit.currentEmployeesList),
              if (employeeListCubit.previousEmployeesList.isNotEmpty) previousEmployeeListView(employeeListCubit.previousEmployeesList),
              Container(
                width: screenSize.width,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                color: ColorManager.colorF2F2F2,
                child: TextWidget(
                  text: AppStrings.swipeLeftToDelete,
                  fontSize: 15.sp,
                  color: ColorManager.color949C9E,
                ),
              )
            ],
          );
  }

  Widget _employeeTile(EmployeeDataModel employee) {
    return Dismissible(
      key: ValueKey(employee.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: SvgPicture.asset(SVGIcon.icDeleteEmployee),
      ),
      onDismissed: (direction) async {
        await employee.delete();
        appUtils.showErrorSnackBar(
          AppStrings.employeeDataHasBeenDeleted,
        );
      },
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddEmployeeScreen(
              editEmployee: employee,
              isEdit: true,
            );
          }));

          employeeListCubit.getAllEmployee();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: screenSize.width,
          margin: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: employee.name, color: ColorManager.color323238, fontSize: 16.sp, fontWeight: FontWeight.w500),
              heightBox(6.h),
              TextWidget(
                text: employee.role,
                color: ColorManager.color949C9E,
              ),
              heightBox(6.h),
              TextWidget(
                text: employee.endDate == null
                    ? "From ${appUtils.convertStringToDateTime(employee.startDate)}"
                    : "${appUtils.convertStringToDateTime(employee.startDate)} -"
                        " ${appUtils.convertStringToDateTime(employee.endDate)}",
                fontSize: 12.sp,
                color: ColorManager.color949C9E,
              ),
            ],
          ),
        ),
      ),
    );
  }

  currentEmployeeListView(List<EmployeeDataModel> employeeList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenSize.width,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          color: ColorManager.colorF2F2F2,
          child: TextWidget(
            text: AppStrings.currentEmployees,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.primary,
          ),
        ),
        SizedBox(height: 8.h),
        ...employeeList.map((employee) => _employeeTile(employee))
      ],
    );
  }

  previousEmployeeListView(List<EmployeeDataModel> employeeList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenSize.width,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          color: ColorManager.colorF2F2F2,
          child: TextWidget(
            text: AppStrings.previousEmployees,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.primary,
          ),
        ),
        SizedBox(height: 8.h),
        ...employeeListCubit.previousEmployeesList.map((employee) => _employeeTile(employee))
      ],
    );
  }
}
