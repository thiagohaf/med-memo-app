import 'package:isar/isar.dart';

part 'reminder.g.dart';

@collection
class Reminder {
  Id id = Isar.autoIncrement;
  String time;
  String medication;
  String dosage;
  bool checked;

  Reminder({
    required this.time,
    required this.medication,
    required this.dosage,
    this.checked = false,
  });

  @override
  String toString() {
    return 'Reminder(time: $time, medication: $medication, dosage: $dosage, checked: $checked)';
  }
}
