import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/employee_list/employee_list_screen.dart';
import 'app_constant.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: AppConstant.projectName,
        debugShowCheckedModeBanner: false,
        navigatorKey: AppConstant.rootNavigatorKey,
        home: const EmployeeListScreen(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1)),
              child: child!);
        },
      ),
    );
  }
}
