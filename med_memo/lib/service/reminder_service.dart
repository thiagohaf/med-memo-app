import 'package:isar/isar.dart';
import 'package:med_memo/model/reminder.dart';
import 'package:path_provider/path_provider.dart';

final class ReminderService {
  late Isar? _db;

  ReminderService() {
    _setupDB();
  }

  void _setupDB() async {
    final dir = await getApplicationDocumentsDirectory();
    _db = await Isar.open([ReminderSchema], directory: dir.path);
  }

  Future<int> saveReminder(Reminder newReminder) async {
    int id = 0; // Default to 0
    await _db?.writeTxn(() async {
      final putId = await _db?.reminders.put(newReminder);
      if (putId != null) {
        id = putId;
      }
    });
    return id; // Return 0 if putId is null, else the putId
  }

  Future<bool> deleteReminder(Reminder reminder) async {
    bool? success = false;
    await _db?.writeTxn(() async {
      success = await _db?.reminders.delete(reminder.id);
    });
    return success ?? false;
  }

  Future<List<Reminder>?> getReminders() async {
    return await _db?.reminders.where().findAll();
  }

  Future<Reminder?> getReminderById(int id) async {
    return await _db?.reminders.get(id);
  }
}
