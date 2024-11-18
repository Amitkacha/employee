import 'package:employee_management/components/app_button.dart';
import 'package:employee_management/components/app_widget.dart';
import 'package:employee_management/components/text_widget.dart';
import 'package:employee_management/resources/resources.dart';
import 'package:employee_management/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app/di.dart';

class CustomDatePicker extends StatefulWidget {
  final bool? isNoDate;
  final DateTime? firstDate;
  final DateTime? endDate;
  final DateTime? preSelectedDate;
  const CustomDatePicker({super.key, this.isNoDate, this.firstDate, this.endDate , this.preSelectedDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  String? selectedBtn;

  @override
  void initState() {
    _setPreFillData();
    super.initState();
  }

  _setPreFillData() {
    if (widget.isNoDate ?? false) {
      selectedBtn = AppStrings.noDate;
      selectedDate = widget.preSelectedDate;
    } else {
      selectedDate = widget.preSelectedDate ?? DateTime.now();
      selectedBtn = AppStrings.today;
    }
  }

  void _updateDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _setToday() {
    selectedBtn = AppStrings.today;
    _updateDate(DateTime.now());
  }

  void _setNextMonday() {
    selectedBtn = AppStrings.nextMonday;

    DateTime now = DateTime.now();
    int daysUntilNextMonday = (8 - now.weekday) % 7;
    _updateDate(now.add(Duration(days: daysUntilNextMonday)));
  }

  void _setNextTuesday() {
    selectedBtn = AppStrings.nextTuesday;

    DateTime now = DateTime.now();
    int daysUntilNextTuesday = (9 - now.weekday) % 7;
    _updateDate(now.add(Duration(days: daysUntilNextTuesday)));
  }

  void _setAfterOneWeek() {
    selectedBtn = AppStrings.after1Week;

    _updateDate(DateTime.now().add(const Duration(days: 7)));
  }

  final appUtils = getIt.get<AppUtils>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.white,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isNoDate == true
                ? Row(
                    children: [
                      Expanded(
                        child: AppButton(
                            onTap: () {
                              selectedBtn = AppStrings.noDate;
                              setState(() {});
                            },
                            isSelectedButton: selectedBtn == AppStrings.noDate,
                            text: AppStrings.noDate,
                            buttonPadHorizon: 0,
                            horizontalPadding: 10.w),
                      ),
                      widthBox(8.w),
                      Expanded(
                        child: AppButton(onTap: _setToday, isSelectedButton: selectedBtn == AppStrings.today, text: AppStrings.today, horizontalPadding: 10.w, buttonPadHorizon: 0),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                                onTap: _setToday, isSelectedButton: selectedBtn == AppStrings.today, text: AppStrings.today, buttonPadHorizon: 0, horizontalPadding: 10.w),
                          ),
                          widthBox(8.w),
                          Expanded(
                            child: AppButton(
                                onTap: _setNextMonday,
                                isSelectedButton: selectedBtn == AppStrings.nextMonday,
                                text: AppStrings.nextMonday,
                                horizontalPadding: 10.w,
                                buttonPadHorizon: 0),
                          ),
                        ],
                      ),
                      heightBox(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppButton(
                                onTap: _setNextTuesday,
                                isSelectedButton: selectedBtn == AppStrings.nextTuesday,
                                text: AppStrings.nextTuesday,
                                horizontalPadding: 10.w,
                                buttonPadHorizon: 0),
                          ),
                          widthBox(8.w),
                          Expanded(
                            child: AppButton(
                                onTap: _setAfterOneWeek,
                                isSelectedButton: selectedBtn == AppStrings.after1Week,
                                text: AppStrings.after1Week,
                                horizontalPadding: 10.w,
                                buttonPadHorizon: 0),
                          ),
                        ],
                      ),
                    ],
                  ),
            heightBox(16.h),
            TableCalendar(
              focusedDay: selectedDate ??  widget.firstDate ?? widget.endDate ??  DateTime.now(),
              firstDay: widget.firstDate ?? DateTime(2000),
              lastDay: widget.endDate ?? DateTime(2100),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                  selectedBtn = null;
                });
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronMargin: EdgeInsets.zero,
                rightChevronMargin: EdgeInsets.zero,
                leftChevronIcon: Icon(
                  Icons.arrow_left_rounded,
                  color: ColorManager.color949C9E,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_right_rounded,
                  color: ColorManager.color949C9E,
                ),
                leftChevronVisible: true,
                rightChevronVisible: true,
              ),
              calendarStyle: CalendarStyle(
                todayTextStyle: TextStyle(color: selectedDate == DateTime.now() ? ColorManager.white : ColorManager.black),
                todayDecoration: BoxDecoration(
                  border: Border.all(color: ColorManager.primary),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: ColorManager.primary,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(SVGIcon.icDatePicker),
                widthBox(2.w),
                TextWidget(
                  text: appUtils.convertTimestampToDateTime(selectedDate),
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                AppButton(
                  text: AppStrings.cancel,
                  onTap: () => Navigator.pop(context),
                ),
                AppButton(
                  text: AppStrings.save,
                  isSelectedButton: true,
                  onTap: () => Navigator.pop(context, selectedDate),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
