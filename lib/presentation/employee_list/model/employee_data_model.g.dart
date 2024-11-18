// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeDataModelAdapter extends TypeAdapter<EmployeeDataModel> {
  @override
  final int typeId = 1;

  @override
  EmployeeDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeDataModel(
      id: fields[0] as String,
      name: fields[1] as String,
      role: fields[2] as String,
      startDate: fields[3] as String,
      endDate: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
