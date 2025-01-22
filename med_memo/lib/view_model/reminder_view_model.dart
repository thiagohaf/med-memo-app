import 'package:flutter/material.dart';
import 'package:med_memo/service/reminder_service.dart';
import '../model/reminder.dart';

class AddReminderViewModel extends ChangeNotifier {
  final ReminderService _service = ReminderService();

  AddReminderViewModel();

  Future<void> saveReminder(Reminder reminder) async {
    _service.saveReminder(reminder);
    notifyListeners();
  }

  void clearFields() {
    notifyListeners();
  }
}
