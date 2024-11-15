import 'package:hive/hive.dart';

part 'employee_data_model.g.dart';

@HiveType(typeId: 1)
class EmployeeDataModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String role;
  @HiveField(3)
  String startDate;
  @HiveField(4)
  String? endDate;

  EmployeeDataModel({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });
}
