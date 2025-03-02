import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  late TabController _tabController;

  // Liste des consommations du jour
  List<Map<String, dynamic>> dailyConsumptions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadConsumptions(); // Charger les données au démarrage
  }

  /// Charge les consommations du jour sélectionné
  Future<void> _loadConsumptions() async {
    try {
      // Début et fin du jour sélectionné
      final startOfDay =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      // Récupérer les données depuis Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('consommations')
          .where('dateConsommation',
              isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('dateConsommation', isLessThan: endOfDay.toIso8601String())
          .get();

      // Mapper les données pour les afficher
      final data = snapshot.docs.map((doc) {
        final consumption = doc.data();
        return {
          'time': DateFormat('HH:mm')
              .format(DateTime.parse(consumption['dateConsommation'])),
          'description':
              '${consumption['quantité']} ${consumption['type']} consommées',
        };
      }).toList();

      setState(() {
        dailyConsumptions = data; // Met à jour les consommations du jour
      });
    } catch (e) {
      print('Erreur lors du chargement des consommations : $e');
    }
  }

  /// Change la date sélectionnée et recharge les consommations
  void _incrementDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
    _loadConsumptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(title: ""),
            const SizedBox(height: 20),

            // Onglets "Activités" et "Programme"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                indicator: BoxDecoration(
                  color: const Color.fromRGBO(4, 75, 217, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                tabs: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Tab(text: "Activités"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Tab(text: "Programme"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Affichage de la date choisie
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.blue),
                    onPressed: () => _incrementDate(-1),
                  ),
                  Text(
                    DateFormat('EEEE d MMMM', 'fr').format(selectedDate),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(4, 75, 217, 1),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: Colors.blue),
                    onPressed: () => _incrementDate(1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Contenu des onglets
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Vue "Activités"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildActivityList(),
                  ),
                  // Vue "Programme"
                  const Center(child: Text('Programme - En construction')),
                ],
              ),
            ),

            // Espace en bas pour éviter que le contenu soit caché par la TabBar
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Liste des activités pour la date sélectionnée
  Widget _buildActivityList() {
    if (dailyConsumptions.isEmpty) {
      return const Center(
        child: Text('Aucune consommation enregistrée pour cette date.'),
      );
    }

    return ListView.builder(
      itemCount: dailyConsumptions.length,
      itemBuilder: (context, index) {
        final activity = dailyConsumptions[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                child:
                    const Icon(Icons.local_fire_department, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['description']!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
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
