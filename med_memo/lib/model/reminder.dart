class Reminder {
  final String time;
  final String medication;
  final String dosage;
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
