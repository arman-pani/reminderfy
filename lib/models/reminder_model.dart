import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 1)
enum Tag {
  @HiveField(0)
  daily,

  @HiveField(1)
  personal,

  @HiveField(2)
  work,
}

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  List<Tag> tags;

  @HiveField(3)
  String id;

  ReminderModel({
    required this.title,
    required this.isCompleted,
    required this.tags,
  }) : id = const Uuid().v4();

  @override
  String toString() =>
      'ReminderModel(id: $id, title: $title, isCompleted: $isCompleted, tags: $tags)';
}
