import 'package:flutter/material.dart';
import 'package:med_memo/service/reminder_service.dart';
import '../model/reminder.dart';

class ReminderViewModel extends ChangeNotifier {
  final ReminderService _service = ReminderService();
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  ReminderViewModel() {
    loadReminders();
  }

  Future<void> loadReminders() async {
    final fetchedReminders = await _service.getReminders();
    _reminders = fetchedReminders;
    notifyListeners();
    }

  Future<void> saveReminder(Reminder reminder) async {
    await _service.saveReminder(reminder);
    await loadReminders(); // Recarrega a lista após salvar
  }

  Future<void> deleteReminder(Reminder reminder) async {
    await _service.deleteReminder(reminder);
    await loadReminders(); // Recarrega a lista após deletar
  }

  void clearFields() {
    notifyListeners();
  }
}