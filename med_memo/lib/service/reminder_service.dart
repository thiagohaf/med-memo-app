import 'package:isar/isar.dart';
import 'package:med_memo/model/reminder.dart';
import 'package:path_provider/path_provider.dart';

final class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  Isar? _db;

  factory ReminderService() {
    return _instance;
  }

  ReminderService._internal();

  Future<void> _setupDB() async {
    if (_db == null) {
      final dir = await getApplicationDocumentsDirectory();
      _db = await Isar.open([ReminderSchema], directory: dir.path);
    }
  }

  Future<Isar> get _database async {
    if (_db == null) {
      await _setupDB();
    }
    return _db!;
  }

  Future<int> saveReminder(Reminder newReminder) async {
    final db = await _database;
    int id = 0;
    await db.writeTxn(() async {
      id = await db.reminders.put(newReminder);
    });
    return id;
  }

  Future<bool> deleteReminder(Reminder reminder) async {
    final db = await _database;
    return await db.writeTxn(() async {
      return await db.reminders.delete(reminder.id);
    });
  }

  Future<List<Reminder>> getReminders() async {
    final db = await _database;
    return await db.reminders.where().findAll();
  }

  Future<Reminder?> getReminderById(int id) async {
    final db = await _database;
    return await db.reminders.get(id);
  }
}
