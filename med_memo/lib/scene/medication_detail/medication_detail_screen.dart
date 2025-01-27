import 'package:flutter/material.dart';

class MedicationDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Roaccutane 30mg',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Isotretinoin, also known as 13-cis-retinoic acid and sold under the brand name Accutane among others, is a medication primarily used to treat severe acne.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Schedule',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildScheduleTile('07:00-09:00 AM'),
                _buildScheduleTile('18:00-20:00 PM'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Capsules',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Duration: 6 months'),
            const Text('Dose: 2/day'),
            const Text('Frequency: Daily'),
            const SizedBox(height: 16),
            const Text(
              'Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const LinearProgressIndicator(value: 0.4),
            const Text('40% complete'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação para mostrar efeitos colaterais
              },
              child: const Text('Possible side effects'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleTile(String time) {
    return Chip(
      label: Text(time),
    );
  }
}
