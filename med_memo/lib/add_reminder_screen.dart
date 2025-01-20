import 'package:flutter/material.dart';
import 'package:med_memo/components/DateTimePicker.dart';
import 'package:med_memo/utils/constants.dart';

import 'model/reminder.dart';

import 'package:flutter/material.dart';

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

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _medicationController = TextEditingController();
  final _dosageController = TextEditingController();
  DateTime? _selectedDateTime;
  bool _checked = false;

  Future<void> _pickDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _pickDateTime(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date & Time',
                      hintText: _selectedDateTime != null
                          ? '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} ${_selectedDateTime!.hour.toString().padLeft(2, '0')}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}'
                          : 'Pick date and time',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (_selectedDateTime == null) {
                        return 'Please select a date and time';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _medicationController,
                decoration: InputDecoration(
                  labelText: 'Medication',
                  hintText: 'Enter medication name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medication';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dosageController,
                decoration: InputDecoration(
                  labelText: 'Dosage',
                  hintText: 'Enter dosage',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dosage';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _checked,
                    onChanged: (bool? value) {
                      setState(() {
                        _checked = value!;
                      });
                    },
                  ),
                  Text('Checked'),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final reminder = Reminder(
                      time: _selectedDateTime.toString(),
                      medication: _medicationController.text,
                      dosage: _dosageController.text,
                      checked: _checked,
                    );

                    print(">>>>> ${reminder}");
                    // Exibe o resultado ou o salva em algum lugar
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Reminder Created'),
                        content: Text(reminder.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Save Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}