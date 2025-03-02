import 'package:flutter/material.dart';
import 'package:hygie_mobile/presentation/journal/journal_page.dart';
import 'package:hygie_mobile/presentation/objectifs/objectif_page.dart';
import 'package:hygie_mobile/presentation/recompense/recompense_page.dart';
import 'package:hygie_mobile/presentation/dashboard/new_dashboard.dart';

class ResponsiveTabBar extends StatelessWidget {
  final List<Map<String, dynamic>> tabs = [
    {"icon": Icons.dashboard, "label": "Dashboard", "isActive": true},
    {"icon": Icons.book, "label": "Journal", "isActive": false},
    {"icon": Icons.card_giftcard, "label": "Récompenses", "isActive": false},
    {"icon": Icons.flag, "label": "Objectifs", "isActive": false},
  ];

  Widget buildTabItem(BuildContext context, IconData icon, String label,
      bool isActive, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // Navigation vers les différentes pages en fonction de l'index
          switch (index) {
            case 0: // Dashboard
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NewDashboard()),
              );
              break;
            case 1: // Journal
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JournalPage()),
              );
              break;
            case 2: // Récompenses
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecompensePage()),
              );
              break;
            case 3: // Objectifs
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ObjectifsPage()),
              );
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: isActive ? Colors.blue : Colors.grey),
            SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? Colors.blue : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 24,
            offset: Offset(0, -8),
          )
        ],
      ),
      child: screenWidth > 400
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabs
                  .asMap()
                  .entries
                  .map((entry) => buildTabItem(context, entry.value["icon"],
                      entry.value["label"], entry.value["isActive"], entry.key))
                  .toList(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs
                    .asMap()
                    .entries
                    .map((entry) => buildTabItem(
                        context,
                        entry.value["icon"],
                        entry.value["label"],
                        entry.value["isActive"],
                        entry.key))
                    .toList(),
              ),
            ),
    );
  }
}

// Nouvelle version de la TabBar qui accepte un index sélectionné et une fonction de callback
class ResponsiveTabBarFixed extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  ResponsiveTabBarFixed({
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final List<Map<String, dynamic>> tabs = [
    {"icon": Icons.dashboard, "label": "Dashboard"},
    {"icon": Icons.book, "label": "Journal"},
    {"icon": Icons.card_giftcard, "label": "Récompenses"},
    {"icon": Icons.flag, "label": "Objectifs"},
  ];

  Widget buildTabItem(
      BuildContext context, IconData icon, String label, int index) {
    final bool isActive = index == selectedIndex;

    return Expanded(
      child: InkWell(
        onTap: () => onTabSelected(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: isActive ? Colors.blue : Colors.grey),
            SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? Colors.blue : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      elevation: 8,
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false, // Ne pas appliquer de padding en haut
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs
                .asMap()
                .entries
                .map((entry) => buildTabItem(context, entry.value["icon"],
                    entry.value["label"], entry.key))
                .toList(),
          ),
        ),
      ),
    );
  }
}
