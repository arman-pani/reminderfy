import 'package:hive/hive.dart';
import 'package:simple_remainder_app/models/reminder_model.dart';

class ReminderService {
  static final _box = Hive.box<ReminderModel>('reminders');

  static Future<void> addDummyReminders() async {
    List<ReminderModel> dummyReminders = [
      ReminderModel(
        title: "Welcome World",
        isCompleted: false,
        tags: [Tag.daily, Tag.personal],
      ),
      ReminderModel(
        title: "Hope you enjoy this app",
        isCompleted: false,
        tags: [Tag.work, Tag.daily],
      ),
      ReminderModel(
        title: "Thank You!",
        isCompleted: false,
        tags: [Tag.work, Tag.personal, Tag.daily],
      ),
    ];
    _box.addAll(dummyReminders);
  }

  static Future<void> addReminder(ReminderModel reminder) async {
    await _box.add(reminder);
  }

  static Future<void> deleteReminder({required String reminderId}) async {
    var reminderKey = _box.keys.firstWhere(
      (key) => _box.get(key)?.id == reminderId,
      orElse: () => throw Exception('Reminder not found'),
    );

    await _box.delete(reminderKey);
  }

  static Future<void> toggleCompletion({required String reminderId}) async {
    var reminderKey = _box.keys.firstWhere(
      (key) => _box.get(key)?.id == reminderId,
      orElse: () => throw Exception('Reminder not found'),
    );

    ReminderModel? reminder = _box.get(reminderKey);
    reminder!.isCompleted = !reminder.isCompleted;
    await reminder.save();
  }

  static Future<void> updateReminder({
    required String reminderId,
    required String title,
    required List<Tag> tags,
  }) async {
    ReminderModel reminder = _box.values.firstWhere(
      (reminder) => reminder.id == reminderId,
      orElse: () => throw Exception('Reminder not found'),
    );

    reminder.title = title;
    reminder.tags = tags;
    await reminder.save();
  }

  static List<ReminderModel> getReminders() {
    return _box.values.toList();
  }
}
