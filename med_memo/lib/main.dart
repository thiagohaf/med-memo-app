import 'package:flutter/material.dart';
import 'package:med_memo/add_reminder_screen.dart';
import 'package:med_memo/app_routes.dart';
import 'package:med_memo/introScreen.dart';
import 'package:med_memo/medication_detail_screen.dart';
import 'package:med_memo/reminder_screen.dart';
import 'package:med_memo/view_model/reminder_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddReminderViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.intro.routeName,
      routes: {
        AppRoutes.intro.routeName: (context) => IntroScreen(),
        AppRoutes.reminder.routeName: (context) => RemindersScreen(),
        AppRoutes.medicationDetail.routeName: (context) =>
            MedicationDetailScreen(),
        AppRoutes.addReminder.routeName: (context) => AddReminderScreen()
      },
    );
  }
}
