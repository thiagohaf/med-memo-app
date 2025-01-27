import 'package:flutter/material.dart';
import 'package:med_memo/scene/add_reminder/add_reminder_screen.dart';
import 'package:med_memo/app_routes.dart';
import 'package:med_memo/scene/intro/introScreen.dart';
import 'package:med_memo/scene/medication_detail/medication_detail_screen.dart';
import 'package:med_memo/scene/reminder/reminder_screen.dart';
import 'package:med_memo/view_model/reminder_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderViewModel()),
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
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
