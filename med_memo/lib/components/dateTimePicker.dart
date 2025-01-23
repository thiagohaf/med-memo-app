import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatefulWidget {
  final Function(String) onDateTimeSelected;

  DateTimePickerWidget({required this.onDateTimeSelected});

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime? _selectedDateTime;
  var labelText = 'Date & Time';

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
    );

    if (pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      labelText = DateFormat('dd/MM/yyyy HH:mm:ss').format(_selectedDateTime!);
    });

    widget.onDateTimeSelected(labelText);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDateTime(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            hintText: _selectedDateTime != null
                ? DateFormat('dd/MM/yyyy HH:mm:ss').format(_selectedDateTime!)
                : 'Pick date and time',
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }
}
