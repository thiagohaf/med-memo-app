import 'package:flutter/material.dart';
import 'package:med_memo/components/dateTimePicker.dart';
import 'package:med_memo/model/reminder.dart';
import 'package:med_memo/utils/constants.dart';
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
  String? _selectedDateTime;
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ReminderViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.addReminderScreenTitle.label),
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
                  labelText: Constants.addReminderScreenMedication.label,
                  hintText: Constants.addReminderScreenMedicationHint.label,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Constants.addReminderScreenMedicationError.label;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dosageController,
                decoration: InputDecoration(
                  labelText: Constants.addReminderScreenDosage.label,
                  hintText: Constants.addReminderScreenDosageHint.label,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Constants.addReminderScreenDosageError.label;
                  }
                  return null;
                },
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
                        title: Text(Constants.addReminderScreenSuccessMessage.label),
                        content: Text('O medicamento: ${reminder.medication} \ncom a dosagem ${reminder.dosage} \nfoi adicionado para ${reminder.time}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Fecha o diálogo
                              Navigator.of(context).pop(
                                  true); // Retorna para a tela anterior com valor true
                            },
                            child: Text(Constants.addReminderScreenOKButton.label),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text(Constants.addReminderScreenAddButton.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
