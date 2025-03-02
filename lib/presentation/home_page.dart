import 'package:flutter/material.dart';
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Récompenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Objectifs',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
