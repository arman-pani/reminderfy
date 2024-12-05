// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 0;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      title: fields[0] as String,
      isCompleted: fields[1] as bool,
      tags: (fields[2] as List).cast<Tag>(),
    )..id = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isCompleted)
      ..writeByte(2)
      ..write(obj.tags)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TagAdapter extends TypeAdapter<Tag> {
  @override
  final int typeId = 1;

  @override
  Tag read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Tag.daily;
      case 1:
        return Tag.personal;
      case 2:
        return Tag.work;
      default:
        return Tag.daily;
    }
  }

  @override
  void write(BinaryWriter writer, Tag obj) {
    switch (obj) {
      case Tag.daily:
        writer.writeByte(0);
        break;
      case Tag.personal:
        writer.writeByte(1);
        break;
      case Tag.work:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
