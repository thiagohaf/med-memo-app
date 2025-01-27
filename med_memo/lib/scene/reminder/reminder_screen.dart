import 'package:flutter/material.dart';
import 'package:med_memo/utils/Constants.dart';
import 'package:med_memo/model/reminder.dart';
import 'package:med_memo/view_model/reminder_view_model.dart';

import '../../app_routes.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final ReminderViewModel _viewModel = ReminderViewModel();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    await _viewModel.loadReminders();
    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToAddReminder(BuildContext context) async {
    final result = await Navigator.pushNamed(context, AppRoutes.addReminder.routeName);

    if (result == true) {
      setState(() {
        // Atualiza a lista de lembretes
        _loadReminders();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.reminderScreenPageTitle.label),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addReminder.routeName)
                  .then((result) {
                if (result == true) {
                  // Atualiza a tela reminder após voltar de addReminder
                  setState(() {
                    _loadReminders();
                  });
                }
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _viewModel.reminders.length,
              itemBuilder: (context, index) {
                final reminder = _viewModel.reminders[index];
                return Dismissible(
                  key: Key(reminder.time + reminder.medication),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) async {
                    await _viewModel.deleteReminder(reminder);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${reminder.medication} ${Constants.reminderScreenDeleteMessage.label}'),
                      ),
                    );
                  },
                  child: _buildReminderTile(reminder, index),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
        ],
      ),
    );
  }

  Widget _buildReminderTile(Reminder reminder, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          reminder.checked = !reminder.checked;
          if (reminder.checked) {
            final completedReminder = _viewModel.reminders.removeAt(index);
            _viewModel.reminders.add(completedReminder);
          } else {
            final uncompletedReminder = _viewModel.reminders.removeAt(index);
            _viewModel.reminders.insert(0, uncompletedReminder);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: reminder.checked ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(31, 0, 0, 0),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              reminder.checked
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: reminder.checked ? Colors.lightBlue : null,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.medication,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      decoration:
                          reminder.checked ? TextDecoration.lineThrough : null,
                      color: reminder.checked ? Colors.grey : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${reminder.time} - ${reminder.dosage}',
                    style: TextStyle(
                      fontSize: 14.0,
                      decoration:
                          reminder.checked ? TextDecoration.lineThrough : null,
                      color: reminder.checked ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
