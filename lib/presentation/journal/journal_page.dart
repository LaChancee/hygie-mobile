import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/programme/programme.dart';
import 'package:intl/intl.dart';
import 'package:hygie_mobile/commons/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/journal/modale_add_activity.dart';
import 'package:hygie_mobile/presentation/programme/new_programme.dart';

class JournalPage extends StatefulWidget {
  final bool openAddActivityModal;

  const JournalPage({Key? key, this.openAddActivityModal = false})
      : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  late TabController _tabController;
  bool isActivitiesTab = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    if (widget.openAddActivityModal) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showAddActivityModal();
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        isActivitiesTab = _tabController.index == 0;
      });
    }
  }

  void _showAddActivityModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return ModaleAddActivity();
      },
    );
  }

  void _handleAddButtonPress() {
    if (isActivitiesTab) {
      _showAddActivityModal();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NewProgrammePage(),
        ),
      );
    }
  }

  /// Retourne le flux des consommations pour la date sélectionnée
  Stream<QuerySnapshot> _getConsumptionsStream() {
    final userId = FirebaseAuth
        .instance.currentUser?.uid; // Récupérer l'ID de l'utilisateur actuel
    if (userId == null) {
      return const Stream.empty();
    }

    // Début et fin du jour sélectionné en UTC
    final startOfDay =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
            .toUtc();
    final endOfDay = startOfDay.add(const Duration(days: 1)).toUtc();

    print('Start of day: ${startOfDay.toIso8601String()}');
    print('End of day: ${endOfDay.toIso8601String()}');

    // Récupérer les données depuis Firestore
    return FirebaseFirestore.instance
        .collection('consommations')
        .where('userId', isEqualTo: userId) // Filtrer par utilisateur
        .where('date', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
        .where('date', isLessThan: endOfDay.toIso8601String())
        .snapshots();
  }

  /// Change la date sélectionnée et recharge les consommations
  void _incrementDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
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
                  ProgramSection(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bouton "Ajouter une activité/programme"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _handleAddButtonPress,
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    isActivitiesTab
                        ? 'Ajouter une activité'
                        : 'Ajouter un programme',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF044BD9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Liste des activités pour la date sélectionnée
  Widget _buildActivityList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _getConsumptionsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(
              child: Text('Erreur lors du chargement des consommations.'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('Aucune consommation enregistrée pour cette date.'));
        }

        final data = snapshot.data!.docs.map((doc) {
          final consumption = doc.data() as Map<String, dynamic>;
          print('Document data: $consumption');

          // Logique conditionnelle pour ajuster la description
          String unit;
          String description;
          if (consumption['type'] == 'Tabac') {
            unit = consumption['quantity'] > 1 ? 'cigarettes' : 'cigarette';
            description =
                '${consumption['quantity']} $unit consommée${consumption['quantity'] > 1 ? 's' : ''}';
          } else if (consumption['type'] == 'Alcool') {
            unit = consumption['quantity'] > 1 ? 'verres' : 'verre';
            description =
                '${consumption['quantity']} $unit d\'alcool consommé${consumption['quantity'] > 1 ? 's' : ''}';
          } else {
            unit = consumption['type'];
            description =
                '${consumption['quantity']} $unit consommé${consumption['quantity'] > 1 ? 's' : ''}';
          }

          return {
            'time': DateFormat('HH:mm')
                .format(DateTime.parse(consumption['date']).toLocal()),
            'description': description,
            'type': consumption[
                'type'], // Ajoutez le type pour l'utiliser dans l'affichage
          };
        }).toList();

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final activity = data[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: _getIconForConsumption(activity['type']),
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
      },
    );
  }

  /// Retourne l'icône appropriée pour le type de consommation
  Widget _getIconForConsumption(String type) {
    switch (type) {
      case 'Tabac':
        return const Icon(Icons.smoking_rooms,
            color: Color.fromRGBO(4, 75, 217, 1));
      case 'Alcool':
        return const Icon(Icons.local_bar,
            color: Color.fromRGBO(4, 75, 217, 1));
      default:
        return const Icon(Icons.local_fire_department, color: Colors.grey);
    }
  }
}
