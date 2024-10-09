import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hygie_mobile/commons/header.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  late TabController _tabController;

  final Map<DateTime, List<Map<String, String>>> activities = {
    DateTime.now(): [
      {'time': '12:05', 'description': '2 cigarettes consommées'},
      {'time': '10:23', 'description': '1 cigarette consommée'},
    ],
    DateTime(2024, 10, 9): [
      {'time': '09:30', 'description': '2 cigarettes consommées'},
      {'time': '10:23', 'description': '1 cigarette consommée'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _incrementDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(title: ""),
          SizedBox(height: 20),

          // Onglets "Activités" et "Programme"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white, // Couleur du texte sélectionné
              unselectedLabelColor: Colors.black54,
              indicator: BoxDecoration(
                color: Color.fromRGBO(4, 75, 217, 1), // Fond bleu pour l'onglet actif
                borderRadius: BorderRadius.circular(8), // Coins arrondis
              ),
              tabs: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5, // Largeur personnalisée
                  child: Tab(
                    text: "Activités",
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5, // Largeur personnalisée
                  child: Tab(
                    text: "Programme",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // Réduit l'espace entre les onglets et la date

          // Affichage de la date choisie (sans carte)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.blue),
                  onPressed: () => _incrementDate(-1),
                ),
                // Texte de la date avec style de couleur
                Text(
                  DateFormat('EEEE d MMMM').format(selectedDate),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(4, 75, 217, 1)), // Couleur bleue
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.blue),
                  onPressed: () => _incrementDate(1),
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // Réduit l'espace entre la date et les activités

          // Contenu des onglets
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Vue "Activités"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildActivityList(selectedDate),
                ),
                // Vue "Programme"
                const Center(child: Text('Programme - En construction')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire la liste des activités du jour
  Widget _buildActivityList(DateTime date) {
    final formattedDate = DateTime(date.year, date.month, date.day);
    final dailyActivities = activities[formattedDate] ?? [];

    if (dailyActivities.isEmpty) {
      return const Center(child: Text('Aucune activité enregistrée pour cette date.'));
    }

    return ListView.builder(
      itemCount: dailyActivities.length,
      itemBuilder: (context, index) {
        final activity = dailyActivities[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              // Icône circulaire pour l'activité
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.local_fire_department, color: Colors.grey),
              ),
              SizedBox(width: 10),

              // Détails de l'activité
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['description']!,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Heure de l'activité
              Text(
                activity['time']!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        );
      },
    );
  }
}
