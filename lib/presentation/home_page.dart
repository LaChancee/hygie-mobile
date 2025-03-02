import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hygie_mobile/presentation/dashboard/new_dashboard.dart';
import 'package:hygie_mobile/presentation/journal/journal_page.dart';
import 'package:hygie_mobile/presentation/objectifs/objectif_page.dart';
import 'package:hygie_mobile/presentation/recompense/recompense_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            NewDashboard(),
            JournalPage(),
            RecompensePage(),
            ObjectifsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon_dashboard.svg', // Chemin vers votre fichier SVG
              width: 24,
              height: 24,
              color: _selectedIndex == 0
                  ? const Color(0xFF044BD9)
                  : const Color(0xFF707070),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon_journal.svg', // Chemin vers votre fichier SVG
              width: 24,
              height: 24,
              color: _selectedIndex == 1
                  ? const Color(0xFF044BD9)
                  : const Color(0xFF707070),
            ),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon_recompenses.svg', // Chemin vers votre fichier SVG
              width: 24,
              height: 24,
              color: _selectedIndex == 2
                  ? const Color(0xFF044BD9)
                  : const Color(0xFF707070),
            ),
            label: 'Récompenses',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon_objectif.svg', // Chemin vers votre fichier SVG
              width: 24,
              height: 24,
              color: _selectedIndex == 3
                  ? const Color(0xFF044BD9)
                  : const Color(0xFF707070),
            ),
            label: 'Objectifs',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF044BD9),
        unselectedItemColor: const Color(0xFF707070),
        onTap: _onItemTapped,
      ),
    );
  }
}
