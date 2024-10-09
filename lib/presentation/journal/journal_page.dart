import 'package:flutter/material.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:intl/intl.dart'; // Assurez-vous d'avoir importé ce package dans votre pubspec.yaml

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  DateTime selectedDate = DateTime.now(); // Date sélectionnée, initialisée à aujourd'hui

final Map<DateTime, List<Map<String, String>>> activities = {
  DateTime.now(): [
    {'time': '12:05', 'description': '2 cigarettes consommées'},
    {'time': '10:23', 'description': '1 cigarette consommée'},
    {'time': '08:45', 'description': '1 cigarette consommée'},
  ],
  DateTime(2024, 10, 9): [ // Exemples pour le 7 octobre 2024
    {'time': '09:30', 'description': '2 cigarette consommée'},
    {'time': '10:23', 'description': '1 cigarette consommée'},
    {'time': '08:45', 'description': '1 cigarette consommée'},
  ],
};

  // Méthode pour changer la date
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022), // Date minimum
      lastDate: DateTime.now(), // Date maximum (aujourd'hui)
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Mettre à jour la date sélectionnée
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Utilisation du header réutilisable
            const Header(title: "",),
            
            // Section de sélection de date
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date: ${DateFormat.yMMMMd().format(selectedDate)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Changer de date'),
                  ),
                ],
              ),
            ),

            // Affichage des activités du jour
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Activités enregistrées :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._buildActivityList(selectedDate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire la liste des activités selon la date sélectionnée
  List<Widget> _buildActivityList(DateTime date) {
    // Normaliser la date à uniquement l'année, le mois et le jour
    final formattedDate = DateTime(date.year, date.month, date.day);
    final dailyActivities = activities[formattedDate] ?? [];

    if (dailyActivities.isEmpty) {
      return [const Text('Aucune activité enregistrée pour cette date.')];
    }

    return dailyActivities.map((activity) {
      return ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text('${activity['time']}'),
        subtitle: Text(activity['description']!),
      );
    }).toList();
  }
}
