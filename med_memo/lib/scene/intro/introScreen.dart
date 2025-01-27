import 'package:flutter/material.dart';
import 'package:med_memo/app_routes.dart';
import 'package:med_memo/utils/constants.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Spacer(),
            SizedBox(
              height: 200,
              child: Image.asset('assets/remedio.png'), // Adicione sua imagem aqui
            ),
            // const Spacer(),
            const SizedBox(height: 30),
            Text(
              Constants.reminderScreenTitle.label,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              Constants.reminderScreenDescription.label,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.reminder.routeName);
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
