import 'package:flutter/material.dart';
import 'package:med_memo/components/dateTimePicker.dart';
import 'package:med_memo/model/reminder.dart';
import 'package:med_memo/view_model/reminder_view_model.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ReminderViewModel>(context);

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
              DateTimePickerWidget(
                onDateTimeSelected: (dateTime) {
                  setState(() {
                    _selectedDateTime = dateTime;
                  });
                },
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

                    viewModel.saveReminder(reminder);

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Reminder Created'),
                        content: Text(reminder.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
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
