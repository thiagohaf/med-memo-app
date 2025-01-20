import 'package:flutter/material.dart';
import 'package:med_memo/utils/Constants.dart';
import 'package:med_memo/model/reminder.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  // Lista de lembretes com estado (checked ou não)
  final List<Reminder> _reminders = [
    Reminder(time: '7:00 AM', medication: 'Carsil 35mg', dosage: '2 tablets', checked: false),
    Reminder(time: '9:00 AM', medication: 'Roaccutane 30mg', dosage: '1 capsule', checked: false),
    Reminder(time: '12:00 PM', medication: 'CardioActive 20ml', dosage: '20 drops', checked: false),
    Reminder(time: '6:00 PM', medication: 'Carsil 35mg', dosage: '2 tablets', checked: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.reminderScreenPageTitle.label),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
               Navigator.pushNamed(context, '/add_reminder');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];
          return Dismissible(
            key: Key(reminder.time + reminder.medication),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                _reminders.removeAt(index);
              });

              // Exibe um snackbar de confirmação
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${reminder.medication} ${Constants.reminderScreenDeleteMessage.label}'),
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
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
        ],
      ),
    );
  }

  Widget _buildReminderTile(Reminder reminder, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Alternar estado do lembrete
          reminder.checked = !reminder.checked;

          // Mover para o final da lista se estiver marcado
          if (reminder.checked) {
            final completedReminder = _reminders.removeAt(index);
            _reminders.add(completedReminder);
          } else {
            // Reordenar para cima caso seja desmarcado
            final uncompletedReminder = _reminders.removeAt(index);
            _reminders.insert(0, uncompletedReminder);
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
              reminder.checked ? Icons.check_box : Icons.check_box_outline_blank,
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
                      decoration: reminder.checked ? TextDecoration.lineThrough : null,
                      color: reminder.checked ? Colors.grey : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${reminder.time} - ${reminder.dosage}',
                    style: TextStyle(
                      fontSize: 14.0,
                      decoration: reminder.checked ? TextDecoration.lineThrough : null,
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
